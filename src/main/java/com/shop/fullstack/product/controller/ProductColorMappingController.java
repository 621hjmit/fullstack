package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductColorMappingService;
import com.shop.fullstack.product.vo.ProductColorMappingVO;
import com.shop.fullstack.product.vo.ProductColorVO;

@RestController
public class ProductColorMappingController {

    @Autowired
    private ProductColorMappingService productColorMappingService;

    // Get all product color mappings
    @GetMapping("/productColorMapping")
    public List<ProductColorMappingVO> getAllProductColorMappings() {
        return productColorMappingService.getAllProductColorMappings();
    }

	/*
	 * // Get product color mappings by product ID
	 * 
	 * @GetMapping("/productColorMapping/{piId}") public List<ProductColorMappingVO>
	 * getProductColorMappingsByProductId(@PathVariable int piId) { return
	 * productColorMappingService.getProductColorMappingsByProductId(piId); }
	 */

 // 색상 매핑 업데이트
    @PutMapping("/productColorMapping/{piId}")
    public ResponseEntity<String> updateProductColors(@PathVariable int piId, @RequestBody List<ProductColorVO> colors) {
        productColorMappingService.updateProductColorMapping(piId, colors);
        return ResponseEntity.ok("Product colors updated successfully");
    }

    // Delete product color mapping by product ID
    @DeleteMapping("/productColorMapping/{piId}")
    public int deleteProductColorMappingByProductId(@PathVariable int piId) {
        return productColorMappingService.deleteProductColorMappingByProductId(piId);
    }
    
    @GetMapping("/productColorCounts/detailCategory/{detailCategoryId}")
    public List<ProductColorMappingVO> getColorProductCountsByDetailCategory(@PathVariable int detailCategoryId) {
        return productColorMappingService.getColorProductCountsByDetailCategory(detailCategoryId);
    }
    
}
