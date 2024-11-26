package com.shop.fullstack.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.OrderService;
import com.shop.fullstack.order.vo.DashboardVO;
import com.shop.fullstack.order.vo.OrderItemTempVO;
import com.shop.fullstack.order.vo.OrdersVO;
import com.shop.fullstack.order.vo.ResultCountVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@GetMapping("/orders")
	public ResultCountVO<OrdersVO> getOrderList(OrdersVO order){
		log.info("js에서 넘어온 파람1{}", order);
		return orderService.selectOrderAll(order);
	}
	
	@GetMapping("/orderDashboard")
	public DashboardVO getDashBoardData(OrdersVO order) {
		return orderService.getDashBoardData(order);
	}
	
	@GetMapping("/cancleOrder")
	public ResultCountVO<OrdersVO> getCancleList(OrdersVO order){
		return orderService.getCancleList(order);
	}
	
	@GetMapping("/exchangeOrder")
	public ResultCountVO<OrdersVO> getExchangeList(OrdersVO order){
		return orderService.getExchangeList(order);
	}
	
	@GetMapping("/returnOrder")
	public ResultCountVO<OrdersVO> getReturnList(OrdersVO order){
		return orderService.getReturnList(order);
	}
	
	@GetMapping("/refundOrder")
	public ResultCountVO<OrdersVO> getRefundList(OrdersVO order){
		return orderService.getRefundList(order);
	}
	
	@PostMapping("/orders")
	public int insertOrder(@RequestBody OrdersVO order) {
		return orderService.insertOrder(order);
	}
	
	@PutMapping("/orderDelStatus")
	public int updateOrStatusDelivery(@RequestBody List<OrdersVO> orders) {
		log.info("js에서 넘어온 파람3{}", orders);
	    return orderService.updateOrStatusDeliveryList(orders);
	}
	
	@PutMapping("/orderStatus")
	public int updateOrderStatus(@RequestBody OrdersVO order) {
		log.info("js에서 넘어온 파람3{}", order);
	    return orderService.updateOrderStatus(order);
	}
}