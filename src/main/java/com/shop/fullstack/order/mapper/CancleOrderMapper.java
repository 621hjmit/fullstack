package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.CancleOrderVO;

public interface CancleOrderMapper {

	
	List<CancleOrderVO> selectCancleOrders(CancleOrderVO cancleOrder);
	CancleOrderVO selectCancleOrder(int coNum);
	int insertCancleOrder(CancleOrderVO cancleOrder);
	int updateCancleOrder(CancleOrderVO cancleOrder);
	int deleteCancleOrder(int coNum);
}
