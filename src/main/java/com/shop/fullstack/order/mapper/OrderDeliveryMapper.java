package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.OrderDeliveryVO;

public interface OrderDeliveryMapper {

	
	List<OrderDeliveryVO> selectOrderDeliveryAll(OrderDeliveryVO orderDelivery);
	OrderDeliveryVO selectOrderDelivery(int ordNum);
	int insertOrderDelivery(OrderDeliveryVO orderDelivery);
	int updateOrderDelivery(OrderDeliveryVO orderDelivery);
	int deleteOrderDelivery(int ordNum);
}
