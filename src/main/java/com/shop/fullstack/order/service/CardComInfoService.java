package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.CardComInfoMapper;
import com.shop.fullstack.order.vo.CardcomInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CardComInfoService {

	
	@Autowired
	private CardComInfoMapper cardComInfoMapper;
	
	public List<CardcomInfoVO> selectCardComs(CardcomInfoVO cardCom){
		return cardComInfoMapper.selectCardcoms(cardCom);
	}
	
	public CardcomInfoVO selectCardCom(int cciNum) {
		return cardComInfoMapper.selectCardcom(cciNum);
	}
	
	public int insertCardCom(CardcomInfoVO cardCom) {
		return cardComInfoMapper.insertCardcom(cardCom);
	}
	
	public int updateCardCom(CardcomInfoVO cardCom) {
		return cardComInfoMapper.updateCardcom(cardCom);
	}
	
	public int deleteCardCom(int cciNum) {
		return cardComInfoMapper.deleteCardcom(cciNum);
	}
	
	public int saveCardComs(List<CardcomInfoVO> cardComs) {
		int result = 0;
		for(CardcomInfoVO cardCom:cardComs) {
			if(cardCom.getCciNum()==0) {
				result += cardComInfoMapper.insertCardcom(cardCom);
			}else {
				result += cardComInfoMapper.updateCardcom(cardCom);
			}
		}
		int tempResult = cardComInfoMapper.selectRowCount();
		log.info("result=>{}", result);
		log.info("tempResult=>{}", tempResult);
		if(cardComs.size() != result) {
			throw new RuntimeException("오류가 발생하였습니다.");
		}
		return result;
	}
	
	public int deleteCardComs(List<Integer> cciNums) {
		int result = 0;
		for(int cciNum:cciNums) {
			result += cardComInfoMapper.deleteCardcom(cciNum);
		}
		return result;
	}
}
