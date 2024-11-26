package com.shop.fullstack.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.PaymentInfoService;
import com.shop.fullstack.order.vo.PaymentInfoVO;

@RestController
public class PaymentInfoController {

	@Autowired 
	private PaymentInfoService paymentInfoService;
	
	@PostMapping("/payInfo")
	public int insertPayinfo(@RequestBody PaymentInfoVO payinfo) {
		return paymentInfoService.insertPayinfo(payinfo);
	}
}
