package com.shop.fullstack.user.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.user.vo.UserInfoVO;

@Mapper
public interface UserInfoMapper {
    public List<UserInfoVO> selectUsers(UserInfoVO userInfoVO);
    public UserInfoVO selectUser(UserInfoVO userInfoVO);
    public UserInfoVO selectUserOneForMypage(int uiNum);
    public UserInfoVO selectUser(int uiNum);
    public UserInfoVO getUserName(@Param("uiNum") int uiNum);
    public UserInfoVO selectUserForLogin(UserInfoVO userInfoVO);
    public UserInfoVO getUiNum(UserInfoVO userInfoVO);
    public int selectEmail(UserInfoVO userInfoVO);
    public int selectEmailCheckOut(UserInfoVO userInfoVO);
    public int updateUser(UserInfoVO userInfoVO);
    public int insertUser(UserInfoVO userInfoVO);
    public int deleteUser(int uiNum);
}
