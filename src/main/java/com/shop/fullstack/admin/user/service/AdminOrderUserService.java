package com.shop.fullstack.admin.user.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.fullstack.admin.user.mapper.AdminOrderUserMapper;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminOrderUserService {
    
    @Autowired
    AdminOrderUserMapper adminOrderUserMapper;
    
    public ResultCountVO<UserInfoVO> getAdminOrderUsers(UserInfoVO userInfoVO){
      if(userInfoVO.getCount()==0) {
        userInfoVO.setCount(10);
      }
      if(userInfoVO.getPage()!=0) {
        int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
        userInfoVO.setStart(start);
      }
      ResultCountVO rcv = new ResultCountVO();
      rcv.setCount(adminOrderUserMapper.getAdminOrderUsersTotal());
      rcv.setList(adminOrderUserMapper.getAdminOrderUserList(userInfoVO));
      return rcv;
    }
    
    public  ResultCountVO<UserInfoVO> getSearchedList(UserInfoVO userInfoVO){
        log.info("넘겨보낸 vo"+userInfoVO.toString());
        if(userInfoVO.getCount()==0) {
          userInfoVO.setCount(10);
        }
        if(userInfoVO.getPage()!=0) {
          int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
          userInfoVO.setStart(start);
        }
        ResultCountVO rcv = new ResultCountVO();
        rcv.setCount(adminOrderUserMapper.getAdminOrderUsersTotal2(userInfoVO));
        rcv.setList(adminOrderUserMapper.getAdminOrderUserList2(userInfoVO));
        return rcv;
    }
    
    public  ResultCountVO<UserInfoVO> membersWithoutOrders(UserInfoVO userInfoVO){
      log.info("넘겨보낸 vo"+userInfoVO.toString());
      if(userInfoVO.getCount()==0) {
        userInfoVO.setCount(10);
      }
      if(userInfoVO.getPage()!=0) {
        int start = (userInfoVO.getPage()-1)*userInfoVO.getCount();
        userInfoVO.setStart(start);
      }
      ResultCountVO rcv = new ResultCountVO();
      rcv.setCount(adminOrderUserMapper.membersWithoutOrdersTotal(userInfoVO));
      rcv.setList(adminOrderUserMapper.membersWithoutOrders(userInfoVO));
      return rcv;
  }
    
    
}
