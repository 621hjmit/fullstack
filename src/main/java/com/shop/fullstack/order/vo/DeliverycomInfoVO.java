package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeliverycomInfoVO {

	
	private int dciNum;
	private String dciName;
	private String dciId;
	private String dciContact;
	private String dciPhone;
	private String dciEmail;
	private String dciStartDate;
	private String dciEndDate;
}