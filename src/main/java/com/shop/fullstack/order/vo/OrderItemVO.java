package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderItemVO {
	
	private int oiNum;
	
	private String orId;
	private String oiId;
	private int uiNum;
	private String uiName;
	
	private int piId;
	private String piName;
	private String piCode;
	private String piColorTitle;
	
	private String psName;
	private int oiPrice;
	private int oiCount;
	private int oiTotal;
	
	private int payNum;
	private String payName;
	private String payMethod;
	private int deiNum;
	private String deiReceiver;
	
	private String deiInvoiceNum;
	private String oiStatus;
	private String oiStatusPay;
	private String oiStatusDelivery;
	
	private String oiCancle;
	private String oiExchange;
	private String oiReturn;
	private String oiRefund;
	
	private String credat;
	private String cretim;
	private String oiClosedDate;	
	private String oiMemo;
	
	private int ciNum;
	
	private Integer pageCount=10;
    private Integer page;
    private Integer start=1;
    private String startDate;
    private String endDate;
}