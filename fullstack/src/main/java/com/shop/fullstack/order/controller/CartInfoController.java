package com.shop.fullstack.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.CartInfoService;
import com.shop.fullstack.order.vo.CartInfoVO;
import com.shop.fullstack.order.vo.ResultCountVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CartInfoController {

	
	@Autowired
	public CartInfoService cartInfoService;
	
	@GetMapping("/cart")
	public ResultCountVO<CartInfoVO> getMyCart(CartInfoVO cart) {
		log.info("jsp에서 넘어왔늬 cart: "+cart);
		return cartInfoService.getMyCart(cart);
	}

	@PostMapping("/cart")
	public int insertCart(@RequestBody CartInfoVO cart) {
		log.info("jsp에서 넘어왔늬 cart: "+cart);
		return cartInfoService.insertCart(cart);
   }
}
