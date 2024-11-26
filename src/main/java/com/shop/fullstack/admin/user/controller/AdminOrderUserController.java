package com.shop.fullstack.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminOrderUserService;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
public class AdminOrderUserController {
    
    @Autowired
    AdminOrderUserService adminOrderUserService;
    
    @GetMapping("/order-user")
    public ResultCountVO<UserInfoVO> getList(UserInfoVO userInfoVO) {
       return adminOrderUserService.getAdminOrderUsers(userInfoVO);
    }
    
    @PostMapping("/order-user2")
    public ResultCountVO<UserInfoVO> getSearchedList(@RequestBody UserInfoVO userInfoVO) {
      log.info("jsp에서 넘어왔늬 userInfoVO: "+userInfoVO);
       return adminOrderUserService.getSearchedList(userInfoVO);
    }
    

    @PostMapping("/order-user3")
    public ResultCountVO<UserInfoVO> membersWithoutOrders(@RequestBody UserInfoVO userInfoVO) {
      log.info("언오더드 유저: "+userInfoVO);
       return adminOrderUserService.membersWithoutOrders(userInfoVO);
    }
}
