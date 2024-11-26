package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductSizeMappingService;
import com.shop.fullstack.product.vo.ProductSizeMappingVO;
import com.shop.fullstack.product.vo.ProductSizeVO;

@RestController
public class ProductSizeMappingController {

    @Autowired
    private ProductSizeMappingService productSizeMappingService;

    // Get all product size mappings
    @GetMapping("/productSizeMapping")
    public List<ProductSizeMappingVO> getAllProductSizeMappings() {
        return productSizeMappingService.getAllProductSizeMappings();
    }

    // Get product size mappings by product ID
	/*
	 * @GetMapping("/productSizeMapping/{piId}") public ProductSizeMappingVO
	 * getProductSizeMappingByProductId(@PathVariable int piId) { return
	 * productSizeMappingService.getProductSizeMapping(piId); }
	 */

    // Add product size mapping
    @PostMapping("/productSizeMapping")
    public int addProductSizeMapping(ProductSizeMappingVO productSizeMapping) {
        return productSizeMappingService.addProductSizeMapping(productSizeMapping);
    }

    // Update product size mapping
    @PutMapping("/productSizeMapping/{piId}")
    public ResponseEntity<String> updateProductSizes(@PathVariable int piId, @RequestBody List<ProductSizeVO> sizes) {
        productSizeMappingService.updateProductSizeMapping(piId, sizes);
        return ResponseEntity.ok("Product sizes updated successfully");
    }

    // Delete product size mapping by product ID
    @DeleteMapping("/productSizeMapping/{piId}")
    public int deleteProductSizeMappingByProductId(@PathVariable int piId) {
        return productSizeMappingService.deleteProductSizeMapping(piId);
    }
}
