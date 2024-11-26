package com.shop.fullstack.product.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductColorVO {
    private int pcId;
    private String pcName;
    private String pcCode;
    private int itemCount;
}
