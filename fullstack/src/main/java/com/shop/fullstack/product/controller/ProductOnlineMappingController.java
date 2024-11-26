package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductOnlineMappingService;
import com.shop.fullstack.product.vo.ProductOnlineMappingVO;

@RestController
public class ProductOnlineMappingController {
	
	@Autowired
    private ProductOnlineMappingService productOnlineMappingService;

    // 온라인 구매 가능 여부 삽입
    @PostMapping("/product-online")
    public int addProductOnlineMapping(@RequestBody ProductOnlineMappingVO productOnlineMappingVO) {
        return productOnlineMappingService.addProductOnlineMapping(productOnlineMappingVO);
    }

    // 특정 제품의 온라인 구매 가능 여부 업데이트
    @PutMapping("/product-online/{piId}")
    public int modifyProductOnlineMapping(@PathVariable int piId, @RequestBody ProductOnlineMappingVO productOnlineMappingVO) {
        productOnlineMappingVO.setPiId(piId);
        return productOnlineMappingService.modifyProductOnlineMapping(productOnlineMappingVO);
    }

    // 특정 제품의 온라인 구매 가능 여부 조회
    @GetMapping("/product-online/{piId}")
    public ProductOnlineMappingVO getProductOnlineMappingByProductId(@PathVariable int piId) {
        return productOnlineMappingService.getProductOnlineMappingByProductId(piId);
    }

    // 모든 온라인 구매 가능 제품 조회
    @GetMapping("/product-online/online-products")
    public List<ProductOnlineMappingVO> getAllOnlineProducts() {
        return productOnlineMappingService.getAllOnlineProducts();
    }
}
