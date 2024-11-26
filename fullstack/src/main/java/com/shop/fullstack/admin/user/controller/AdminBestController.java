package com.shop.fullstack.admin.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminBestService;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AdminBestController {

    @Autowired
    AdminBestService adminBestService;
    
    @PostMapping("/best-user")
    public ResultCountVO<UserInfoVO> getList(@RequestBody UserInfoVO userInfoVO) {
       log.info("jsp에서 넘어왔니 "+userInfoVO);
       return adminBestService.getAdminBestUsers(userInfoVO);
    }
}
