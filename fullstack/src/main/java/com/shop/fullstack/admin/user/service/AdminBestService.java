package com.shop.fullstack.admin.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.user.mapper.AdminBestMapper;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;
@Service
public class AdminBestService {
    @Autowired
    AdminBestMapper adminBestMapper;
    public ResultCountVO<UserInfoVO> getAdminBestUsers(UserInfoVO userInfoVO){
      if(userInfoVO.getCount()==0) {
        userInfoVO.setCount(10);
      }
      if(userInfoVO.getPage()!=0) {
        int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
        userInfoVO.setStart(start);
      }
      ResultCountVO rcv = new ResultCountVO();
      rcv.setCount(adminBestMapper.getAdminBestUsersTotal(userInfoVO));
      rcv.setList(adminBestMapper.getAdminBestUsers(userInfoVO));
      return rcv;
    }
}
