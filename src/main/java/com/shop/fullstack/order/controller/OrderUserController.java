package com.shop.fullstack.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.OrderUserService;
import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class OrderUserController {

	@Autowired
	private OrderUserService orderUserService;
	
	@PostMapping("/orderUser")
	public UserInfoVO getOrderUser(@RequestBody UserInfoVO orderUser) {
		log.info("orderUser1 {}",orderUser);
		return orderUserService.selectOrderUser(orderUser);
	}
	
	@PostMapping("/orderAddr")
	public AddressInfoVO getOrderAddr(@RequestBody AddressInfoVO orderAddr) {
		log.info("orderAddr {}",orderAddr);
		return orderUserService.selectOrderAddr(orderAddr);
	}
}
