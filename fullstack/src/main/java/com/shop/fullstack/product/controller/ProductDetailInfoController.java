package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductDetailInfoService;
import com.shop.fullstack.product.vo.ProductDetailInfoVO;

@RestController
public class ProductDetailInfoController {

	@Autowired
	private ProductDetailInfoService productDetailInfoService;
	
	@GetMapping("/productDetailInfo")
	public List<ProductDetailInfoVO> getProductDetailInfos(ProductDetailInfoVO productDetailInfo){
		return productDetailInfoService.selectProductDetailInfos(productDetailInfo);
	}
	
	@GetMapping("/productDetailInfo/{pdiId}")
	public ProductDetailInfoVO getProductDetailInfo(int piId){
		return productDetailInfoService.selectProductDetailInfoByProductId(piId);
	}
	
	@PostMapping("/productDetailInfo")
	public int addProductDetailInfo(@RequestBody ProductDetailInfoVO productDetailInfo) {
	    return productDetailInfoService.insertproductDetailInfo(productDetailInfo);
	}
	
	@PutMapping("/productDetailInfo/{piId}")
	public ResponseEntity<String> updateProductDetailInfo(@PathVariable int piId, @RequestBody ProductDetailInfoVO productDetailInfo) {
	    productDetailInfo.setPiId(piId);
	    int result = productDetailInfoService.updateProductDetailInfo(productDetailInfo);
	    
	    if (result > 0) {
	        return ResponseEntity.ok("Product detail info updated successfully");
	    } else {
	        return ResponseEntity.badRequest().body("Failed to update product detail info");
	    }
	}
}