package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.OrderItemVO;
import com.shop.fullstack.order.vo.OrdersVO;

public interface OrderItemMapper {
	
	int selectOrderItemTotal(OrderItemVO orderItem);
	List<OrderItemVO> selectOrderItems(OrderItemVO orderItem);
	OrderItemVO selectOrderItemOne(int oiNum);
	int insertOrderItem(OrderItemVO orderItem);
	int updateOrderItem(OrderItemVO orderItem);
	int updateOrderItemPay(OrderItemVO orderItem);
	int updateOrderItemDelivery(OrderItemVO orderItem);
	int updateOrderItemStatus(OrderItemVO orderItem);
	int deleteOrderItem(int oiNum);
}