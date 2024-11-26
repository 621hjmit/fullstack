package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.OrderItemTempVO;

public interface OrderItemTempMapper {

	int selectOrderItemTempTotal(OrderItemTempVO orderItemTemp);
	List<OrderItemTempVO> selectOrderItemTemps(OrderItemTempVO orderItemTemp);
	OrderItemTempVO selectOrderItemTemp(int oitNum);
	int insertOrderItemTemp(OrderItemTempVO orderItemTemp);
	int updateOrderItemTemp(OrderItemTempVO orderItemTemp);
	int updateCountOrderItem(OrderItemTempVO orderItemTemp);
	int updateStatusOrderItem(OrderItemTempVO orderItemTemp);
	int deleteOrderItemTemp(int oitNum);
}
