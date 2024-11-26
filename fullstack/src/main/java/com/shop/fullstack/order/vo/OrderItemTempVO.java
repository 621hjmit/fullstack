
package com.shop.fullstack.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderItemTempVO {

	private int oitNum;
	private int uiNum;
	private String uiName;
	private int piId;
	private String piName;
	private String piCode;
	private String piColorTitle;
	private String psName;
	private int piPrice;
	private int oitCount;
	private String oitStatus;
	private String credat;
	private String oitClosedDate;
	private int ciNum;
	
	//(메인 이미지 URL)
    private String pimgUrl;
	
    private String startDate;
    private String endDate;
}
