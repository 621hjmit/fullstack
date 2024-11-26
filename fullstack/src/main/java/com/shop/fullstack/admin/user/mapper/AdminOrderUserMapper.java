package com.shop.fullstack.admin.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.user.vo.UserInfoVO;
@Mapper
public interface AdminOrderUserMapper {
    public List<UserInfoVO> getAdminOrderUserList(UserInfoVO userInfoVO);
    public int getAdminOrderUsersTotal();
    
    public List<UserInfoVO> getAdminOrderUserList2(UserInfoVO userInfoVO);
    public int getAdminOrderUsersTotal2(UserInfoVO userInfoVO);
    
    public List<UserInfoVO> membersWithoutOrders(UserInfoVO userInfoVO);
    public int membersWithoutOrdersTotal(UserInfoVO userInfoVO);
}
