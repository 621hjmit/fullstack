package com.shop.fullstack.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.DeliveryComInfoService;
import com.shop.fullstack.order.vo.DeliverycomInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class DeliveryComInfoController {

	
	@Autowired
	private DeliveryComInfoService deliveryComInfoService;
	
	@GetMapping("/deliveryComs")
	public List<DeliverycomInfoVO> getDeliveryComs(DeliverycomInfoVO deliveryCom){
		return deliveryComInfoService.selectDeliveryComs(deliveryCom);
	}
	
	@PostMapping("/deliveryComs")
	public int saveDeliveryComs(@RequestBody List<DeliverycomInfoVO> deliveryComs) {
		log.info("deliveryComs=>{}", deliveryComs);
		return deliveryComInfoService.saveDeliveryComs(deliveryComs);
	}
	@DeleteMapping("/deliveryComs")
	public int deleteDeliveryComs(@RequestBody List<Integer> dciNums) {
		return deliveryComInfoService.deleteDeliveryComs(dciNums);
	}
}