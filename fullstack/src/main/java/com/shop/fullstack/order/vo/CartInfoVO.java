package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartInfoVO {
	
	private int ciNum;
	private int uiNum;
	private boolean ciStatus;
	private String credat;
	private String cretim;
}
