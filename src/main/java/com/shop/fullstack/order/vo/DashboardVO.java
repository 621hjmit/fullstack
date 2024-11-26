package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DashboardVO {
	
	private int totalAmountToday;
	private int totalCountToday;
	private int totalAmountMonth;
	private int totalCountMonth;
	private int refundAmountToday;
	private int refundCountToday;
	private int refundAmountMonth;
	private int refundCountMonth;
	private int newOrder;
	private int prepProduct;
	private int prepDelivery;
	private int holdDelivery;
	private int onDelivery;
	private int pendingOrder;
	private int cancleOrder;
	private int exchangeOrder;
	private int returnOrder;
	private int refundOrder;
}
