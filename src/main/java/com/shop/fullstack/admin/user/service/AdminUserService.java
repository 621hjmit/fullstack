package com.shop.fullstack.admin.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.user.mapper.AdminUserMapper;
import com.shop.fullstack.admin.user.vo.StatisticsVO;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class AdminUserService {
  @Autowired
  private AdminUserMapper adminUserMapper;
  
  public List<StatisticsVO> getStat(){
    List<StatisticsVO> stat = adminUserMapper.getStat();
    return stat;
  }

  public List<UserInfoVO> getNewMember(){
    return adminUserMapper.getNewMember();
  }
  public ResultCountVO<UserInfoVO> memberInformationInquiry(UserInfoVO userInfoVO){
    if(userInfoVO.getCount()==0) {
      userInfoVO.setCount(10);;
    }
    if(userInfoVO.getPage()!=0) {
      int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
      userInfoVO.setStart(start);
    }
    ResultCountVO rcv = new ResultCountVO();
    rcv.setCount(adminUserMapper.memberInformationInquiryTotal());
    rcv.setList(adminUserMapper.memberInformationInquiry(userInfoVO));
    return rcv;
  }
  

  public ResultCountVO<UserInfoVO> memberInformationInquiry2(UserInfoVO userInfoVO){
    if(userInfoVO.getCount()==0) {
      userInfoVO.setCount(10);;
    }
    if(userInfoVO.getPage()!=0) {
      int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
      userInfoVO.setStart(start);
    }
    ResultCountVO rcv = new ResultCountVO();
    rcv.setCount(adminUserMapper.memberInformationInquiryTotal2(userInfoVO));
    rcv.setList(adminUserMapper.memberInformationInquiry2(userInfoVO));
    return rcv;
  }
  
  public ResultCountVO<UserInfoVO> getOutMember(UserInfoVO userInfoVO){
    log.info("넘겨보낸 vo"+userInfoVO.toString());
    if(userInfoVO.getCount()==0) {
      userInfoVO.setCount(10);
    }
    if(userInfoVO.getPage()!=0) {
      int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
      userInfoVO.setStart(start);
    }
    ResultCountVO rcv = new ResultCountVO();
    rcv.setCount(adminUserMapper.getOutMemberTotal(userInfoVO));
    rcv.setList(adminUserMapper.getOutMember(userInfoVO));
    return rcv;
  }
  
  public ResultCountVO<UserInfoVO> getDormantMember(UserInfoVO userInfoVO){
    log.info("넘겨보낸 vo"+userInfoVO.toString());
    if(userInfoVO.getCount()==0) {
      userInfoVO.setCount(10);
    }
    if(userInfoVO.getPage()!=0) {
      int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
      userInfoVO.setStart(start);
    }
    ResultCountVO rcv = new ResultCountVO();
    rcv.setCount(adminUserMapper.getDormantMemberTotal(userInfoVO));
    rcv.setList(adminUserMapper.getDormantMember(userInfoVO));
    return rcv;
  }
  
  public int updateType(List<UserInfoVO> users) {
    
    int result = 0;
    for(UserInfoVO user:users) {
      log.info("uiNum: "+user.getUiNum()+" type: "+user.getUiType());
      result += adminUserMapper.updateType(user); //0
    }
    if(users.size() != result) {
      throw new RuntimeException("오류가 발생하였습니다.");
    }
    return result;
  }
  
  public int updateGiNum(List<UserInfoVO> users) {
    
    int result = 0;
    for(UserInfoVO user:users) {
      result += adminUserMapper.updateGiNum(user); //0
    }
    if(users.size() != result) {
      throw new RuntimeException("오류가 발생하였습니다.");
    }
    return result;
  }
  
  public int deleteUser(List<UserInfoVO> users) {
    
    int result = 0;
    for(UserInfoVO user:users) {
      result += adminUserMapper.deleteUser(user); //0
    }
    
    if(users.size() != result) {
      throw new RuntimeException("오류가 발생하였습니다.");
    }
    return result;
  }
    
}
