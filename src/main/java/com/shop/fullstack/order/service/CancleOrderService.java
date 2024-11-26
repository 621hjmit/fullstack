package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.CancleOrderMapper;
import com.shop.fullstack.order.vo.CancleOrderVO;

@Service
public class CancleOrderService {

	
	@Autowired
	private CancleOrderMapper cancleOrderMapper;
	
	public List<CancleOrderVO> selectCancleOrders(CancleOrderVO cancleOrder){
		return cancleOrderMapper.selectCancleOrders(cancleOrder);
	}
	
	public CancleOrderVO selectCancleOrder(int coNum) {
		return cancleOrderMapper.selectCancleOrder(coNum);
	}
	
	public int insertCancleOrder(CancleOrderVO cancleOrder) {
		return cancleOrderMapper.insertCancleOrder(cancleOrder);
	}
	
	public int updateCancleOrder(CancleOrderVO cancleOrder) {
		return cancleOrderMapper.updateCancleOrder(cancleOrder);
	}
	
	public int deleteCancleOrder(int coNum) {
		return cancleOrderMapper.deleteCancleOrder(coNum);
	}
}
