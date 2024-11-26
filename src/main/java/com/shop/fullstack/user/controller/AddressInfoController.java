package com.shop.fullstack.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.user.service.AddressInfoService;
import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AddressInfoController {

    @Autowired
    private AddressInfoService addressInfoService;
    
    @PostMapping("/address")
    public List<AddressInfoVO> selectUserAddress(@RequestBody UserInfoVO user) {
        return addressInfoService.selectAddress(user);
    }
    
    @PostMapping("/address4")
    public AddressInfoVO selectUserAddressUiNum(@RequestBody UserInfoVO userVO) {
        log.info("userVO =>{}"+userVO);
        return addressInfoService.selectUserAddressUiNum(userVO);
    }
    
    @GetMapping("/address/{aiNum}")
    public AddressInfoVO selectUserAddress(@PathVariable int aiNum) {
        return addressInfoService.selectOne(aiNum);
    }
    
    // 배송주소 선택 후 선택된 주소 불러오는 컨트롤러(by 이슬)
    @GetMapping("/chooseAddress")
    public AddressInfoVO chooseAddress(int aiNum) {
    	return addressInfoService.selectOne(aiNum);
    }
    
    //ajax 방식 delete
    @DeleteMapping("/address/{aiNum}")
    public int deleteAddress(@PathVariable int aiNum) {
        return addressInfoService.deleteAddress(aiNum);
    }
    
    @PutMapping("/address2")
    public int updateAddress(@RequestBody AddressInfoVO addressInfoVO) {
        return addressInfoService.updateAddress(addressInfoVO);
    }
    
    @PostMapping("/address3")
    public int insertAddress(@RequestBody AddressInfoVO addressInfoVO) {
        return addressInfoService.insertAddress(addressInfoVO);
    }
}
