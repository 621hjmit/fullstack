package com.shop.fullstack.product.vo;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductVO {
    private int piId;
    private String piCode;
    private String piName;
    private String piPrice;
    private String piCountryOfOrigin; // 제조국
    private String piStory;
    private int piMainCategoryId;
    private int piSubCategoryId;
    private int piDetailCategoryId;
    private String piColorTitle;
    private String piMaterialTitle;   
    
    private int page = 1;            // 요청된 페이지 번호
    private int itemsPerPage = 10;    // 페이지당 항목 수
    
    @JsonIgnore
    private int totalItems;           // 총 아이템 수
    
    private int offset;               // SQL 조회 시 사용할 오프셋

    // 기존 필드명으로 수정
    private String pimgUrl; // 기존 이미지 URL
    private List<ProductColorVO> colorList; // 색상 정보 목록
    private List<ProductSizeVO> sizeList; // 사이즈 정보 목록
    private List<ProductMaterialVO> materialList; // 소재 정보 목록
    private List<ProductMainInfoVO> mainInfoList; // 주요 정보 목록
    private ProductDetailInfoVO productDetailInfo; // 제품 세부 정보
    private List<ProductImgVO> productImgs = new ArrayList<>(); // 이미지 목록
    private ProductOnlineMappingVO productOnlineMapping;//온라인 구매 가능 여부

}

