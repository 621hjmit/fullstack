package com.shop.fullstack.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductRecommendationMapper;
import com.shop.fullstack.product.vo.ProductVO;

@Service
public class ProductRecommendationService {
	
	@Autowired
	ProductRecommendationMapper productRecommendationMapper;

	 public List<ProductVO> getRandomRecommendations(int piMainCategoryId, int piSubCategoryId, int piId){
		 Map<String, Object> params = new HashMap<>();
	        params.put("mainCategoryId", piMainCategoryId);
	        params.put("subCategoryId", piSubCategoryId);
	        params.put("productId", piId);
	        return productRecommendationMapper.selectRandomRecommendations(params);
	 }
	 
	 public List<ProductVO> getSameDetailCategoryRecommendations(int piDetailCategoryId, int piId) {
	        return productRecommendationMapper.selectSameDetailCategoryRecommendations(piDetailCategoryId, piId);
	    }
	 
}
