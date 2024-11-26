package com.shop.fullstack.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.CardComInfoService;
import com.shop.fullstack.order.vo.CardcomInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CardComInfoController {

	@Autowired
	private CardComInfoService cardComInfoService;
	
	@GetMapping("/cardComs")
	public List<CardcomInfoVO> getCardComs(CardcomInfoVO cardCom){
		return cardComInfoService.selectCardComs(cardCom);
	}
	
	
	@PostMapping("/cardComs")
	public int saveCardComs(@RequestBody List<CardcomInfoVO> cardComs) {
		log.info("cardComs=>{}", cardComs);
		return cardComInfoService.saveCardComs(cardComs);
	}
	@DeleteMapping("/cardComs")
	public int deleteCardComs(@RequestBody List<Integer> cciNums) {
		return cardComInfoService.deleteCardComs(cciNums);
	}
}
