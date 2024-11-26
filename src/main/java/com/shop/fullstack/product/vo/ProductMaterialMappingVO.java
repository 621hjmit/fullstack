package com.shop.fullstack.product.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductMaterialMappingVO {
	private Integer pmmId;
	private Integer piId;
	private Integer pmId;
    private int itemCount;
}
