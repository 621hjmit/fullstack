package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductMainInfoService;
import com.shop.fullstack.product.vo.ProductMainInfoVO;
import com.shop.fullstack.product.vo.ProductVO;

@RestController
public class ProductMainInfoController {

	@Autowired
	private ProductMainInfoService productMainInfoService;
	
	@GetMapping("/productMainInfos")
	public List<ProductMainInfoVO> getProductMainInfos(ProductMainInfoVO productMainInfo){
		return productMainInfoService.selectProductMainInfos();
	}
	
	@PutMapping("/productMainInfo/{piId}")
	public ResponseEntity<String> updateProductMainInfo(@PathVariable int piId, @RequestBody List<ProductMainInfoVO> productMainInfoList) {
	    int result = productMainInfoService.updateProductMainInfo(piId, productMainInfoList);

	    if (result > 0) {
	        return ResponseEntity.ok("Product main info updated successfully");
	    } else {
	        return ResponseEntity.badRequest().body("Failed to update product main info");
	    }
	}
	
}