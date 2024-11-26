package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.OrdersVO;
import com.shop.fullstack.order.vo.ResultCountVO;

public interface OrdersMapper {

	int selectOrderTotal(OrdersVO order);
	List<OrdersVO> selectOrderAll(OrdersVO order);
	OrdersVO selectOrder(int orNum);
	
	int totalAmountToday();
	int totalCountToday();
	int totalAmountMonth(OrdersVO order);
	int totalCountMonth(OrdersVO order);
	int refundAmountToday(OrdersVO order);
	int refundCountToday(OrdersVO order);
	int refundAmountMonth(OrdersVO order);
	int refundCountMonth(OrdersVO order);
	int newOrder(OrdersVO order);
	int prepProduct(OrdersVO order);
	int prepDelivery(OrdersVO order);
	int holdDelivery(OrdersVO order);
	int onDelivery(OrdersVO order);
	int pendingOrder(OrdersVO order);
	int cancleOrder(OrdersVO order);
	List<OrdersVO> cancleOrderAll(OrdersVO order);
	int exchangeOrder(OrdersVO order);
	List<OrdersVO> exchangeOrderAll(OrdersVO order);
	int returnOrder(OrdersVO order);
	List<OrdersVO> returnOrderAll(OrdersVO order);
	int refundOrder(OrdersVO order);
	List<OrdersVO> refundOrderAll(OrdersVO order);
		
	int insertOrder(OrdersVO order);
	int updateOrder(OrdersVO order);
	int updateOrderPay(OrdersVO order);
	int updateOrderDelivery(OrdersVO order);
	int updateOrStatusDelivery(OrdersVO orders);
	int updateOrderStatus(OrdersVO order);
	int deleteOrder(int orNum);
}
