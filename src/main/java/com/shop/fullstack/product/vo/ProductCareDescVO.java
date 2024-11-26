package com.shop.fullstack.product.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductCareDescVO {
    private int pcdId;
    private int pmId; // product_material의 외래 키
    private String pcdDesc;
}
