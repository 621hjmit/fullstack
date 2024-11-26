package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentInfoVO {
	
	private int payNum;
	private int uiNum;
	
	private String payPg;
	private String payImpUid; // 아임포트 고유 결제번호
	private String payMethod; // 결제수단
	private String orId;  // 상점 주문번호 (orId)
	private String orPiName; //결제단위 제품명
	private int payAmount; // 결제금액
	private String payName;  // 결제자 정보
	private String payEmail;
	private String payTel;
	private String payAddr;
	private String payStatus;  // 결제 상태
	private String credat;
	private String cretim;
	private String payDate;
	
	private String cancelDate;
	private int cancleAmount;
	private String cancelReason;
}
