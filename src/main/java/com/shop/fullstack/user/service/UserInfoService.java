package com.shop.fullstack.user.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.user.mapper.UserInfoMapper;
import com.shop.fullstack.user.mapper.VisitInfoMapper;
import com.shop.fullstack.user.dto.CombinedRequestDto;
import com.shop.fullstack.user.mapper.AddressInfoMapper;
import com.shop.fullstack.user.mapper.NewsletterMapper;
import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;
import com.shop.fullstack.user.vo.NewsletterInfoVO;
import com.shop.fullstack.user.vo.VisitInfoVO;
import com.shop.fullstack.utill.EncryptUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserInfoService {
  @Autowired
  private UserInfoMapper userInfoMapper;
  @Autowired
  private AddressInfoMapper addressInfoMapper;
  @Autowired
  private VisitInfoMapper visitInfoMapper;
  @Autowired
  private NewsletterMapper newsletterMapper;
  
  public List<UserInfoVO> selectUsers(UserInfoVO userInfoVO){
    return null;
  }
  public UserInfoVO selectUser(UserInfoVO requestUser,HttpSession session){
    //로그인하는곳.
    UserInfoVO loginUser = userInfoMapper.selectUserForLogin(requestUser);
    String requestUserPwd = requestUser.getUiPwd();
    requestUserPwd = EncryptUtil.encrypt(requestUserPwd);
    log.info("비번 맞음? "+loginUser.getUiPwd().equals(requestUserPwd));
    //세션에 저장을 해야함 이건 서비스에서 해줘야함.
    if(loginUser!= null && loginUser.getUiPwd().equals(requestUserPwd)) {
        UserInfoVO uiNum = userInfoMapper.getUiNum(requestUser);
        session.setAttribute("user", uiNum);
        //visit info 를 넣는다잉.
        VisitInfoVO visitInfoVO = new VisitInfoVO();
        visitInfoVO.setUiNum(loginUser.getUiNum());
        int result = visitInfoMapper.insertVisit(visitInfoVO);
        log.info("★★★ result =>{}");
        return loginUser;
        //visit info 다 넣음.
    }
    return null;
  }
  
  
  public UserInfoVO selectOneUser(UserInfoVO requestUser){
      return userInfoMapper.selectUserOneForMypage(requestUser.getUiNum());
  }
  
  public UserInfoVO selectUser(int uiNum){
    return userInfoMapper.selectUser(uiNum);
  }
  
  public int selectEmail(UserInfoVO userInfoVO) {
    int checkUserOut = userInfoMapper.selectEmailCheckOut(userInfoVO);//탈퇴회원이냐?
    int checkUserExist = userInfoMapper.selectEmail(userInfoVO);//이미 가입했냐?
    //이멜 조회 하는데 휴면이라서 값이 1이고
    //이멜 조회 하는데 이미 있으면 리턴이 1이 나온다.
    int result = checkUserOut + checkUserExist;
    // 같은 아이디의 유저가 없으면 0 리턴 - 회원가입하삼.
    // 같은 아이디의 유저가 있으면 1 리턴 - 로긴 가능하지요.
    // 같은 아이디의 유저가 탈퇴 상태이면 2리턴 (가입불가, 다른 아이디로 시도 권유)
    log.info("result=>{}"+result);
    return result;
  }
  
  @Transactional
  public int updateUser(UserInfoVO uservo){
    //회원정보수정
    log.info("uservo: "+uservo);
    log.info("uiNews: "+uservo.getUiNews());
    
    //비번 암호화시키기
    if(uservo.getUiPwd()!=null ||uservo.getUiPwd()=="") {
      String pwd = EncryptUtil.encrypt(uservo.getUiPwd());
      uservo.setUiPwd(pwd);
    }
    
    
  //이름 변경시 주소에 들어가는 이름도 고쳐야해서 필드를 다 채워야함.
    String fullName;
    
    String last = uservo.getUiLastName();
    String first = uservo.getUiFirstName();
    
    UserInfoVO originalUser = userInfoMapper.getUserName(uservo.getUiNum());
    String originalLastName = originalUser.getUiLastName();
    String originalFirstName = originalUser.getUiFirstName();
    
    if(last==null) {
        last = originalLastName;
    }
    if(first==null) {
        first = originalFirstName;
    }
    
    uservo.setUiFullname(last+first);
    
    
    int result = 0;
    
    result += userInfoMapper.updateUser(uservo);
    result += addressInfoMapper.updateAddressDefault(uservo);
    result += newsletterMapper.updateSubscription(uservo);
    return result;
  }
  
  @Transactional
  public int insertUser(CombinedRequestDto requestDto){
    UserInfoVO uservo = requestDto.getUser();
    AddressInfoVO addressvo = requestDto.getAddress();
    NewsletterInfoVO subscriber = requestDto.getNewsletter();
    
    //비밀번호 암호화
    String pwd = EncryptUtil.encrypt(uservo.getUiPwd());
    uservo.setUiPwd(pwd);
    
    int result = 0;
    //insert user
    result += userInfoMapper.insertUser(uservo);
    int memberNumber = uservo.getUiNum();
    addressvo.setUiNum(memberNumber);
    addressvo.setAiDefault("1");
    
    //insert address
    result += addressInfoMapper.insertAddress(addressvo);
    
    // 예시로 unStatus가 'unsubscribed'일 경우 오늘 날짜를 추가
    //subscriber.unUnsubscribeDate = null;
    subscriber = setNewletterVO(subscriber, memberNumber);
    
    //insert subscriber
    result += newsletterMapper.insertSubscriber(subscriber);
    log.info("회원가입하고 쿼리 다 날린 result: "+result);
    return result;
  }
  
  public int deleteUser(int uiNum){
    return userInfoMapper.deleteUser(uiNum);
  }
  
  private static NewsletterInfoVO setNewssletter(UserInfoVO member) {
      NewsletterInfoVO newslettervo = new NewsletterInfoVO();
      newslettervo.setUnEmail(member.getUiEmail());
      int status = member.getUiNews();
      newslettervo.setUnSubscriptionDate(member.getCredat());
      
      if(status>0) {
        newslettervo.setUnStatus("active");
      }else {
        newslettervo.setUnUnsubscribeDate(member.getCredat());
        newslettervo.setUnStatus("unsubscribed");
      }
      
      newslettervo.setUnLastName(member.getUiLastName());
      newslettervo.setUnFirstName(member.getUiFirstName());
      newslettervo.setUiNum(member.getUiNum());
      log.info("newslettervo=>{}"+newslettervo.toString());
      
      return newslettervo;
  }
  
  /* 여기서 부터는 admin 페이지를 위한 서비스
  
  private static AddressInfoVO makeAddressVO(UserInfoVO member) {
      AddressInfoVO addressInfoVO = new AddressInfoVO();
      addressInfoVO.setUiNum(member.getUiNum());
      addressInfoVO.setAiPlaceName(member.getUiLastName()+member.getUiFirstName());
      addressInfoVO.setAiRecipentName(member.getUiLastName()+member.getUiFirstName());
      addressInfoVO.setAiCountryCode(member.getUiCountryCode());
      addressInfoVO.setAiPhone(member.getUiPhone());
      addressInfoVO.setAiZipcode(member.getAiZipcode());
      addressInfoVO.setAiAddress1(member.getAiAddress1());
      addressInfoVO.setAiAddress2(member.getAiAddress2());
      return null;
  }*/
  private static NewsletterInfoVO setNewletterVO(NewsletterInfoVO subscriber, int number) {
      subscriber.setUiNum(number);
      String status = subscriber.getUnStatus();
      String date;
      if(status.equals("1")) {
          status = "active";
      }else {
          status = "unsubscribed";
          date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
          subscriber.setUnUnsubscribeDate(date);
      }
      subscriber.setUnStatus(status);
      return subscriber;
  }
}
