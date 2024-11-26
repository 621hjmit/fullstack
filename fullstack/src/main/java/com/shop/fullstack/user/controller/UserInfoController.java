package com.shop.fullstack.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.user.dto.CombinedRequestDto;
import com.shop.fullstack.user.service.UserInfoService;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class UserInfoController {
    
    @Autowired
    private UserInfoService userInfoService;
    @PostMapping("/user/checkEmail")
    public int checkEmail(@RequestBody UserInfoVO user) {
        return userInfoService.selectEmail(user);
    }
    
    @PostMapping("/user")
    public UserInfoVO login(@RequestBody UserInfoVO user,HttpSession session) {
        return userInfoService.selectUser(user,session);
    }
    
    @PostMapping("/user1")
    public UserInfoVO selectOneUser(@RequestBody UserInfoVO userVO) {
        log.info("userVO =>{}"+userVO);
        return userInfoService.selectOneUser(userVO);
    }
    
    @PostMapping("/join")
    public int join(@RequestBody CombinedRequestDto requestDto) {
        return userInfoService.insertUser(requestDto);
    }
    
    //회원 정보 수정 매핑.
    @PutMapping("/user")
    public int modify(@RequestBody UserInfoVO userVO) {
        return userInfoService.updateUser(userVO);
    }
    
    @PutMapping("/user2")
    public int delete(@RequestBody UserInfoVO user) {
        return userInfoService.deleteUser(user.getUiNum());
    }
    
    @GetMapping("/api/user")
    public UserInfoVO getUserFromSession(HttpSession session) {
      UserInfoVO loginUser = (UserInfoVO) session.getAttribute("user");
      if (loginUser != null) {
        return loginUser;
      } else {
        return null; // 또는 에러 메시지
      }
    }
}
