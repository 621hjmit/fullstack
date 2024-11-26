package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrderDeliveryMapper;
import com.shop.fullstack.order.vo.OrderDeliveryVO;

@Service
public class OrderDeliveryService {

	
	@Autowired
	private OrderDeliveryMapper orderDeliveryMapper;
	
	public List<OrderDeliveryVO> selectOrderDeliveryAll(OrderDeliveryVO orderDelivery){
		return orderDeliveryMapper.selectOrderDeliveryAll(orderDelivery);
	}
	public OrderDeliveryVO selectOrderDelivery(int ordNum) {
		return orderDeliveryMapper.selectOrderDelivery(ordNum);
	}
	public int insertOrderDelivery(OrderDeliveryVO orderDelivery) {
		return orderDeliveryMapper.insertOrderDelivery(orderDelivery);
	}
	public int updateOrderDelivery(OrderDeliveryVO orderDelivery) {
		return orderDeliveryMapper.updateOrderDelivery(orderDelivery);
	}
	public int deleteOrderDelivery(int ordNum) {
		return orderDeliveryMapper.deleteOrderDelivery(ordNum);
	}
}
