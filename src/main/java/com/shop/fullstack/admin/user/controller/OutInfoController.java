package com.shop.fullstack.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.OutInfoService;
import com.shop.fullstack.user.vo.OutTypeInfoVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
public class OutInfoController {

    @Autowired
    private OutInfoService outInfoService;
    
    @GetMapping("/out-infos")
    public List<OutTypeInfoVO> getOutTypeInfos() {
    	log.info("여기는 탈퇴회원 조회를 위한 컨트롤러 입니다.");
        return outInfoService.getOutTypeInfos(); 
    }
}
