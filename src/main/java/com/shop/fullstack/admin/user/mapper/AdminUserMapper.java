package com.shop.fullstack.admin.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.admin.user.vo.StatisticsVO;
import com.shop.fullstack.user.vo.UserInfoVO;

@Mapper
public interface AdminUserMapper {
    public List<StatisticsVO> getStat();
    public List<UserInfoVO> getNewMember(); 
    
    public List<UserInfoVO> memberInformationInquiry(UserInfoVO userInfoVO);
    public int memberInformationInquiryTotal();
    
    public List<UserInfoVO> memberInformationInquiry2(UserInfoVO userInfoVO);
    public int memberInformationInquiryTotal2(UserInfoVO userInfoVO);

    public List<UserInfoVO> getOutMember(UserInfoVO userInfoVO);
    public int getOutMemberTotal(UserInfoVO userInfoVO);
    
    public List<UserInfoVO> getDormantMember(UserInfoVO userInfoVO);
    public int getDormantMemberTotal(UserInfoVO userInfoVO);
    
    public int updateType(UserInfoVO userInfoVo);
    public int updateGiNum(UserInfoVO userInfoVo);
    public int deleteUser(UserInfoVO userInfoVo);
}
