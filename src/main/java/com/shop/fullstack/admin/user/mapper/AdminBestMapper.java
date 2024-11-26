package com.shop.fullstack.admin.user.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.shop.fullstack.user.vo.UserInfoVO;

@Mapper
public interface AdminBestMapper {
    public List<UserInfoVO> getAdminBestUsers(UserInfoVO user);
    public int getAdminBestUsersTotal(UserInfoVO user);
}
