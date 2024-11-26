package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.ExchangeOrderMapper;
import com.shop.fullstack.order.vo.ExchangeOrderVO;

@Service
public class ExchangeOrderService {

	
	@Autowired
	private ExchangeOrderMapper exchangeOrderMapper;
	
	public List<ExchangeOrderVO> selectExchangeOrders(ExchangeOrderVO exchangeOrder){
		return exchangeOrderMapper.selectExchangeOrders(exchangeOrder);
	}
	public ExchangeOrderVO selectExchangeOrder(int eoNum) {
		return exchangeOrderMapper.selectExchangeOrder(eoNum);
	}
	public int insertExchangeOrder(ExchangeOrderVO exchangeOrder) {
		return exchangeOrderMapper.insertExchangeOrder(exchangeOrder);
	}
	public int updateExchangeOrder(ExchangeOrderVO exchangeOrder) {
		return exchangeOrderMapper.updateExchangeOrder(exchangeOrder);
	}
	public int deleteExchangeOrder(int eoNum) {
		return exchangeOrderMapper.deleteExchangeOrder(eoNum);
	}
}
