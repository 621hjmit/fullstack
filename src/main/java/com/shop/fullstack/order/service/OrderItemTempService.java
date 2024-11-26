package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrderItemTempMapper;
import com.shop.fullstack.order.vo.OrderItemTempVO;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.order.vo.StatusChangeVO;

@Service
public class OrderItemTempService {

	@Autowired
	private OrderItemTempMapper orderItemTempMapper;
	
	public ResultCountVO<OrderItemTempVO> selectOrderItemTemps(OrderItemTempVO orderItemTemp){
		ResultCountVO<OrderItemTempVO> resultCount = new ResultCountVO<>();
		resultCount.setList(orderItemTempMapper.selectOrderItemTemps(orderItemTemp));
		resultCount.setCount(orderItemTempMapper.selectOrderItemTempTotal(orderItemTemp));
		return resultCount;
	}
	public OrderItemTempVO selectOrderItemTemp(int oitNum) {
		return orderItemTempMapper.selectOrderItemTemp(oitNum);
	}
	public int insertOrderItemTemp(OrderItemTempVO orderItemTemp) {
		return orderItemTempMapper.insertOrderItemTemp(orderItemTemp);
	}
	public int updateOrderItemTemp(OrderItemTempVO orderItemTemp) {
		return orderItemTempMapper.updateOrderItemTemp(orderItemTemp);
	}
	
	public int updateCountOrderItem(OrderItemTempVO orderItemTemp) {
		return orderItemTempMapper.updateCountOrderItem(orderItemTemp);
	}
	
	public int updateStatusOrderItem(OrderItemTempVO orderItemTemp) {
		return orderItemTempMapper.updateStatusOrderItem(orderItemTemp);
	}
	
	public int updateStatusOrderItemS(StatusChangeVO<OrderItemTempVO> oitForChangeStatus) {
		List<Integer> oitNums = oitForChangeStatus.getList();
		String status = oitForChangeStatus.getStatus();
		OrderItemTempVO orderItemTemp = new OrderItemTempVO();
		int result = 0;
		for(int oitNum:oitNums) {
			orderItemTemp.setOitNum(oitNum);
			orderItemTemp.setOitStatus(status);
			result += orderItemTempMapper.updateStatusOrderItem(orderItemTemp); 
		}
		return result;
	}

	public int deleteOrderItemTemp(int oitNum) {
		return orderItemTempMapper.deleteOrderItemTemp(oitNum);
	}
}
