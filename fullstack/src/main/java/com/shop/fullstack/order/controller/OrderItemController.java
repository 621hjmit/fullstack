package com.shop.fullstack.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.OrderItemService;

import com.shop.fullstack.order.vo.OrderItemVO;
import com.shop.fullstack.order.vo.ResultCountVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class OrderItemController {
 
	@Autowired
	private OrderItemService orderItemService;
	
	@GetMapping("/orderItems")
	public ResultCountVO<OrderItemVO> getOrderItems(OrderItemVO orderItem){
		log.info("jsp에서 넘어온 orderItems 1: " + orderItem);
		return orderItemService.selectOrderItems(orderItem);
	}
	
	@PostMapping("/orderItems")
	public int insertOrderItemS(@RequestBody List<OrderItemVO> orderItems) {
		log.info("pay.jsp에서 넘어온 orderItems 2: " + orderItems);
		return orderItemService.insertOrderItemS(orderItems);
	}
}
