package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductRecommendationService;
import com.shop.fullstack.product.vo.ProductVO;

@RestController
public class ProductRecommendationContoller {

	@Autowired
	private ProductRecommendationService productRecommendationService;

	@GetMapping("/product/{piId}/recommendations")
	public List<ProductVO> getRecommendedProducts(@PathVariable int piId, @RequestParam int piMainCategoryId,
			@RequestParam int piSubCategoryId) {
		return productRecommendationService.getRandomRecommendations(piMainCategoryId, piSubCategoryId, piId);
	}

	@GetMapping("/product/{productId}/explore")
	public List<ProductVO> getSameDetailCategoryRecommendations(
	        @PathVariable("productId") int productId,
	        @RequestParam("detailCategoryId") int detailCategoryId) {
	    return productRecommendationService.getSameDetailCategoryRecommendations(detailCategoryId, productId);
	}

}
