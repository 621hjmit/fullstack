package com.shop.fullstack.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.order.service.BankComInfoService;
import com.shop.fullstack.order.vo.BankcomInfoVO;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class BankComInfoController {

	@Autowired
	private BankComInfoService bankComInfoService;
	
	@GetMapping("/bankComs")
	public List<BankcomInfoVO> getBankComs(BankcomInfoVO bankCom){
		return bankComInfoService.selectBankcoms(bankCom);
	}
	
	
	@PostMapping("/bankComs")
	public int saveBankComs(@RequestBody List<BankcomInfoVO> bankComs) {
		log.info("bankComs=>{}", bankComs);
		return bankComInfoService.saveBankComs(bankComs);
	}
	@DeleteMapping("/bankComs")
	public int deleteBankComs(@RequestBody List<Integer> bciNums) {
		return bankComInfoService.deleteBankComs(bciNums);
	}
}