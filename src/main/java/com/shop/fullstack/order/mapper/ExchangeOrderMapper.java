package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.ExchangeOrderVO;

public interface ExchangeOrderMapper {

	
	List<ExchangeOrderVO> selectExchangeOrders(ExchangeOrderVO exchangeOrder);
	ExchangeOrderVO selectExchangeOrder(int eoNum);
	int insertExchangeOrder(ExchangeOrderVO exchangeOrder);
	int updateExchangeOrder(ExchangeOrderVO exchangeOrder);
	int deleteExchangeOrder(int eoNum);
}
