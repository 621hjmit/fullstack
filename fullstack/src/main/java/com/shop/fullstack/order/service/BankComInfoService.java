package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.BankComInfoMapper;
import com.shop.fullstack.order.vo.BankcomInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BankComInfoService {

	
	@Autowired
	private BankComInfoMapper bankComInfoMapper;
	
	public List<BankcomInfoVO> selectBankcoms(BankcomInfoVO bankCom){
		return bankComInfoMapper.selectBankcoms(bankCom);
	}
	
	public BankcomInfoVO selectBankcom(int bciNum) {
		return bankComInfoMapper.selectBankcom(bciNum);
	}
	
	public int insertBankcom(BankcomInfoVO bankCom) {
		return bankComInfoMapper.insertBankcom(bankCom);
	}
	
	public int updateBankcom(BankcomInfoVO bankcom) {
		return bankComInfoMapper.updateBankcom(bankcom);
	}
	
	public int deleteBankcom(int bciNum) {
		return bankComInfoMapper.deleteBankcom(bciNum);
	}
	
	public int saveBankComs(List<BankcomInfoVO> bankComs) {
		int result = 0;
		for(BankcomInfoVO bankCom:bankComs) {
			if(bankCom.getBciNum()==0) {
				result += bankComInfoMapper.insertBankcom(bankCom);
			}else {
				result += bankComInfoMapper.updateBankcom(bankCom);
			}
		}
		int tempResult = bankComInfoMapper.selectRowCount();
		log.info("result=>{}", result);
		log.info("tempResult=>{}", tempResult);
		if(bankComs.size() != result) {
			throw new RuntimeException("오류가 발생하였습니다.");
		}
		return result;
	}
	
	public int deleteBankComs(List<Integer> bciNums) {
		int result = 0;
		for(int bciNum:bciNums) {
			result += bankComInfoMapper.deleteBankcom(bciNum);
		}
		return result;
	}
}
