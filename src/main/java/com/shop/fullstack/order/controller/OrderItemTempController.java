package com.shop.fullstack.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.OrderItemTempService;
import com.shop.fullstack.order.vo.OrderItemTempVO;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.order.vo.StatusChangeVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class OrderItemTempController {

	@Autowired
	private OrderItemTempService orderItemTempService;
	
	@GetMapping("/orderItemTemp")
	public ResultCountVO<OrderItemTempVO> getMyItemsTemp(OrderItemTempVO orderItemTemp){
		log.info("jsp에서 넘어왔늬 orderItemTemp1: "+orderItemTemp);
		return orderItemTempService.selectOrderItemTemps(orderItemTemp);
	}
	
	@PostMapping("/orderItemTemp")
	public int insertOrderItemTemp(@RequestBody OrderItemTempVO orderItemTemp) {
		log.info("jsp에서 넘어왔늬 orderItemTemp2: "+orderItemTemp);
		return orderItemTempService.insertOrderItemTemp(orderItemTemp);
	}
	
	@PutMapping("/changeCount")
	public int changeCountOrderItem(@RequestBody OrderItemTempVO orderItemTemp) {
	    log.info("jsp에서 넘어온 orderItemTemp3: " + orderItemTemp);
	    return orderItemTempService.updateCountOrderItem(orderItemTemp);
	}
	
	@PutMapping("/changeStatus")
	public int changStatusOrderItem(@RequestBody OrderItemTempVO orderItemTemp) {
	    log.info("jsp에서 넘어온 orderItemTemp4: " + orderItemTemp);
	    return orderItemTempService.updateStatusOrderItem(orderItemTemp);
	}
	
	@PutMapping("/changeMultiStatus")
	public int changeMultiStatus(@RequestBody StatusChangeVO<OrderItemTempVO> oitForChangeStatus) {
		log.info("jsp에서 넘어온 orderItemTemp5: " + oitForChangeStatus);
		return orderItemTempService.updateStatusOrderItemS(oitForChangeStatus);
	}
}