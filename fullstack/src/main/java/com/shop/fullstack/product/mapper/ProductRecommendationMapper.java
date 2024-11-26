package com.shop.fullstack.product.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductVO;

@Mapper
public interface ProductRecommendationMapper {
	
	//같은 서브 카테고리에서 추천 제품 선택
	List<ProductVO> selectRandomRecommendations(Map<String, Object> params);
	
	// 같은 세부 카테고리에서 추천 제품 선택
    List<ProductVO> selectSameDetailCategoryRecommendations(@Param("detailCategoryId") int detailCategoryId,
                                                            @Param("piId") int piId);
}
