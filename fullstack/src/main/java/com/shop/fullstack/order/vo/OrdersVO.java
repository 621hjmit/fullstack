package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrdersVO {

	private int orNum;
	private String orId;
	private int uiNum;
	private String uiName;
	private String orPiName;
	private int orItemCount;
	private int orAmount;
	private int payNum;
	private String payName;
	private String payMethod;
	private int deiNum;
	private String deiReceiver;
	private String deiInvoiceNum;
	private String orStatus;
	private String orStatusPay;
	private String orStatusDelivery;
	private String orCancle;
	private String orExchange;
	private String orReturn;
	private String orRefund;
	private String credat;
	private String cretim;
	private String orClosedDate;
	private String orMemo;
	private int ciNum;		
	
	private Integer pageCount=10;
    private Integer page;
    private Integer start=1;
    private String startDate;
    private String endDate;
}