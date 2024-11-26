package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrdersMapper;
import com.shop.fullstack.order.vo.DashboardVO;
import com.shop.fullstack.order.vo.OrdersVO;
import com.shop.fullstack.order.vo.ResultCountVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class OrderService {

	@Autowired
	private OrdersMapper ordersMapper;
	
	public ResultCountVO<OrdersVO> selectOrderAll(OrdersVO order){
		if(order.getPageCount() == 0) {
			order.setPageCount(10);
		}
		if(order.getPage() != 0) {
			int start = (order.getPage()-1) * order.getPageCount();
			order.setStart(start);
		}
		ResultCountVO<OrdersVO> resultCount = new ResultCountVO<>();
		resultCount.setList(ordersMapper.selectOrderAll(order));
		resultCount.setCount(ordersMapper.selectOrderTotal(order));
		return resultCount;
	}

	public OrdersVO selectOrder(int orNum) {
		return ordersMapper.selectOrder(orNum);
	}
	
	public ResultCountVO<OrdersVO> getCancleList(OrdersVO order){
		if(order.getPageCount() == 0) {
			order.setPageCount(10);
		}
		if(order.getPage() != 0) {
			int start = (order.getPage()-1) * order.getPageCount();
			order.setStart(start);
		}
		ResultCountVO<OrdersVO> resultCount = new ResultCountVO<>();
		resultCount.setList(ordersMapper.cancleOrderAll(order));
		resultCount.setCount(ordersMapper.cancleOrder(order));
		return resultCount;
	}
	
	public ResultCountVO<OrdersVO> getExchangeList(OrdersVO order){
		if(order.getPageCount() == 0) {
			order.setPageCount(10);
		}
		if(order.getPage() != 0) {
			int start = (order.getPage()-1) * order.getPageCount();
			order.setStart(start);
		}
		ResultCountVO<OrdersVO> resultCount = new ResultCountVO<>();
		resultCount.setList(ordersMapper.exchangeOrderAll(order));
		resultCount.setCount(ordersMapper.exchangeOrder(order));
		return resultCount;
	}
	
	public ResultCountVO<OrdersVO> getReturnList(OrdersVO order){
		if(order.getPageCount() == 0) {
			order.setPageCount(10);
		}
		if(order.getPage() != 0) {
			int start = (order.getPage()-1) * order.getPageCount();
			order.setStart(start);
		}
		ResultCountVO<OrdersVO> resultCount = new ResultCountVO<>();
		resultCount.setList(ordersMapper.returnOrderAll(order));
		resultCount.setCount(ordersMapper.returnOrder(order));
		return resultCount;
	}
	
	public ResultCountVO<OrdersVO> getRefundList(OrdersVO order){
		if(order.getPageCount() == 0) {
			order.setPageCount(10);
		}
		if(order.getPage() != 0) {
			int start = (order.getPage()-1) * order.getPageCount();
			order.setStart(start);
		}
		ResultCountVO<OrdersVO> resultCount = new ResultCountVO<>();
		resultCount.setList(ordersMapper.refundOrderAll(order));
		resultCount.setCount(ordersMapper.refundOrder(order));
		return resultCount;
	}
	
	public DashboardVO getDashBoardData(OrdersVO order) {
		DashboardVO dashboard = new DashboardVO();
		dashboard.setTotalAmountToday(ordersMapper.totalAmountToday());
		dashboard.setTotalCountToday(ordersMapper.totalCountToday());
		dashboard.setTotalAmountMonth(ordersMapper.totalAmountMonth(order));
		dashboard.setTotalCountMonth(ordersMapper.totalCountMonth(order));
		dashboard.setRefundAmountToday(ordersMapper.refundAmountToday(order));
		dashboard.setRefundCountToday(ordersMapper.refundCountToday(order));
		dashboard.setRefundAmountMonth(ordersMapper.refundAmountMonth(order));
		dashboard.setRefundCountMonth(ordersMapper.refundCountMonth(order));
		dashboard.setNewOrder(ordersMapper.newOrder(order));
		dashboard.setPrepProduct(ordersMapper.prepProduct(order));
		dashboard.setPrepDelivery(ordersMapper.prepDelivery(order));
		dashboard.setHoldDelivery(ordersMapper.holdDelivery(order));
		dashboard.setOnDelivery(ordersMapper.onDelivery(order));
		dashboard.setCancleOrder(ordersMapper.cancleOrder(order));
		dashboard.setExchangeOrder(ordersMapper.exchangeOrder(order));
		dashboard.setReturnOrder(ordersMapper.returnOrder(order));
		dashboard.setRefundOrder(ordersMapper.refundOrder(order));
		
		return dashboard;
	}
		
	public int insertOrder(OrdersVO order) {
		order.setOrStatus("open");
		return ordersMapper.insertOrder(order);
	}
	
	public int updateOrder(OrdersVO order) {
		return ordersMapper.updateOrder(order);
	}
	
	public int updateOrderPay(OrdersVO order) {
		return ordersMapper.updateOrderPay(order);
	}
	
	public int updateOrderDelivery(OrdersVO order) {
		return ordersMapper.updateOrderDelivery(order);
	}
	
	public int updateOrStatusDeliveryList(List<OrdersVO> orders) {
		int result = 0;
		for(OrdersVO order: orders) {
			result += ordersMapper.updateOrStatusDelivery(order);
		}
		return result;
	}
	
	public int updateOrderStatus(OrdersVO order) {
		return ordersMapper.updateOrderStatus(order);
	}
	
	public int deleteOrder(int orNum) {
		return ordersMapper.deleteOrder(orNum);
	}
}

