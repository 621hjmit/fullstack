package com.shop.fullstack.product.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductImgVO {
	private int pimgId;         // 이미지 ID
    private int piId;           // 상품 ID
    private String pimgName;    // 이미지 파일명
    private String pimgUrl;    // 이미지 경로
    private Timestamp pimgCredat;  // 생성 시간
}