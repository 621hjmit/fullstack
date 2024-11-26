package com.shop.fullstack.category.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CategoryVO {
	private Integer mainCategoryId; // MAIN_CATEGORY_ID
    private String mainCategoryName; // MAIN_CATEGORY_NAME
    
    private Integer subCategoryId; // SUB_CATEGORY_ID
    private Integer foreignMainCategoryId; // MAIN_CATEGORY_ID (FOREIGN KEY)
    private String subCategoryName; // SUB_CATEGORY_NAME
    
    private Integer detailCategoryId; // DETAIL_CATEGORY_ID
    private Integer foreignSubCategoryId; // SUB_CATEGORY_ID (FOREIGN KEY)
    private String detailCategoryName; // DETAIL_CATEGORY_NAME
	
}