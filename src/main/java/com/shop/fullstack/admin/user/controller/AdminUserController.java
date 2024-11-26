package com.shop.fullstack.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminUserService;
import com.shop.fullstack.admin.user.vo.StatisticsVO;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AdminUserController {
    @Autowired
    AdminUserService adminUserService;
    
    @GetMapping("/stats")
    public List<StatisticsVO> getStat() {
       return adminUserService.getStat();
    }
    
    @GetMapping("/new")
    public List<UserInfoVO> getNewMember() {
       return adminUserService.getNewMember();
    }
    
    @GetMapping("/inquery")
    public ResultCountVO<UserInfoVO> memberInformationInquiry(UserInfoVO userInfoVO) {
       return adminUserService.memberInformationInquiry(userInfoVO);
    }
    
    @PostMapping("/inquery2")
    public ResultCountVO<UserInfoVO> memberInformationInquiry2(@RequestBody UserInfoVO userInfoVO) {
      log.info("넘겨보낸 vo"+userInfoVO.toString());
      return adminUserService.memberInformationInquiry2(userInfoVO);  
    }

    @PostMapping("/out-user")
    public ResultCountVO<UserInfoVO> getOutMember(@RequestBody UserInfoVO userInfoVO) {
      log.info("넘겨보낸 vo"+userInfoVO.toString());
      return adminUserService.getOutMember(userInfoVO);
    }
    
    @PostMapping("/dormant-users")
    public ResultCountVO<UserInfoVO> getDormantMember(@RequestBody UserInfoVO userInfoVO) {
      log.info("넘겨보낸 vo"+userInfoVO.toString());
      return adminUserService.getDormantMember(userInfoVO);
    }
    
    @PutMapping("/admin-users")
    public int updateType(@RequestBody List<UserInfoVO> users) {
       return adminUserService.updateType(users);
    }
    
    @PutMapping("/users2")
    public int updateGiNum(@RequestBody List<UserInfoVO> users) {
      log.info("jsp에서 넘어왔니 users가"+users);
       return adminUserService.updateGiNum(users);
    }

    @PutMapping("/admin-users2")
    public int deleteUser(@RequestBody List<UserInfoVO> users) {
       return adminUserService.deleteUser(users);
    }
    
    
}
