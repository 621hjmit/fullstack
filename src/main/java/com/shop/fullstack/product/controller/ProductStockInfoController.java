package com.shop.fullstack.product.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductStockInfoService;
import com.shop.fullstack.product.vo.ProductStockInfoVO;

@RestController
public class ProductStockInfoController {

	@Autowired
	private ProductStockInfoService productStockInfoService;

	/*
	 * @PostMapping("/product-stock-info") public int
	 * addProductStockInfo(@RequestBody ProductStockInfoVO productStockInfoVO) {
	 * return productStockInfoService.insertProductStockInfo(productStockInfoVO); }
	 */

	// 제품 재고 업데이트
	@PutMapping("/product-stock/{piId}")
	public ResponseEntity<?> updateProductStock(@PathVariable int piId, @RequestBody Map<String, Integer> request) {
		Integer newQuantity = request.get("quantity");
		if (newQuantity == null || newQuantity < 0) {
			return ResponseEntity.badRequest().body("유효하지 않은 재고 수량입니다.");
		}

		productStockInfoService.updateProductStockQuantity(piId, newQuantity);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/product-stock-info/{piId}")
	public ProductStockInfoVO getProductStockInfoByProductId(@PathVariable int piId) {
		return productStockInfoService.selectProductStockInfoByProductId(piId);
	}

	@GetMapping("/product-stock-info")
	public List<ProductStockInfoVO> getAllProductStockInfos() {
		return productStockInfoService.selectAllProductStockInfos();
	}
}
