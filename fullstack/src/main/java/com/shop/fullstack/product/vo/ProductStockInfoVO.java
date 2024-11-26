package com.shop.fullstack.product.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductStockInfoVO {
    private int psiId;
    private int piId;
    private int quantity;
    private String lastUpdated;
}
