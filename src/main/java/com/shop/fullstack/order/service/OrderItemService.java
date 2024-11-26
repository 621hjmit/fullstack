package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrderItemMapper;
import com.shop.fullstack.order.vo.OrderItemVO;
import com.shop.fullstack.order.vo.ResultCountVO;

@Service
public class OrderItemService {

	@Autowired
	private OrderItemMapper orderItemMapper;
	
	public ResultCountVO<OrderItemVO> selectOrderItems(OrderItemVO orderItem){
		if(orderItem.getPageCount()==0) {
			orderItem.setPageCount(10);
		}
		if(orderItem.getPage()!=0) {
			int start = (orderItem.getPage()-1)*orderItem.getPageCount();
			orderItem.setStart(start);
		}
		ResultCountVO<OrderItemVO> resultCount = new ResultCountVO<>();
		resultCount.setList(orderItemMapper.selectOrderItems(orderItem));
		resultCount.setCount(orderItemMapper.selectOrderItemTotal(orderItem));
		return resultCount;
	}
	public OrderItemVO selectOrderItemOne(int oiNum) {
		return orderItemMapper.selectOrderItemOne(oiNum);
	}
	public int insertOrderItem(OrderItemVO orderItem) {
		return orderItemMapper.insertOrderItem(orderItem);
	}
	public int insertOrderItemS(List<OrderItemVO> orderItems) {
		int result = 0;
		for(OrderItemVO orderItem : orderItems) {
			result += orderItemMapper.insertOrderItem(orderItem); }
		return result;
	}
	public int updateOrderItem(OrderItemVO orderItem) {
		return orderItemMapper.updateOrderItem(orderItem);
	}
	public int updateOrderItemPay(OrderItemVO orderItem) {
		return orderItemMapper.updateOrderItemPay(orderItem);
	}
	public int updateOrderItemDelivery(OrderItemVO orderItem) {
		return orderItemMapper.updateOrderItemDelivery(orderItem);
	}
	public int updateOrderItemStatus(OrderItemVO orderItem) {
		return orderItemMapper.updateOrderItemStatus(orderItem);
	}
	public int deleteOrderItem(int oiNum) {
		return orderItemMapper.deleteOrderItem(oiNum);
	}
}

