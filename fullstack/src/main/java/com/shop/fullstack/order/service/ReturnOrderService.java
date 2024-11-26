package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.ReturnOrderMapper;
import com.shop.fullstack.order.vo.ReturnOrderVO;

@Service
public class ReturnOrderService {

	
	@Autowired
	private ReturnOrderMapper returnOrderMapper;
	
	public List<ReturnOrderVO> selectReturnOrders(ReturnOrderVO returnOrder){
		return returnOrderMapper.selectReturnOrders(returnOrder);
	}
	public ReturnOrderVO selectReturnOrder(int roNum) {
		return returnOrderMapper.selectReturnOrder(roNum);
	}
	public int insertReturnOrder(ReturnOrderVO returnOrder) {
		return returnOrderMapper.insertReturnOrder(returnOrder);
	}
	public int updateReturnOrder(ReturnOrderVO returnOrder) {
		return returnOrderMapper.updateReturnOrder(returnOrder);
	}
	public int deleteReturnOrder(int roNum) {
		return returnOrderMapper.deleteReturnOrder(roNum);
	}
}
