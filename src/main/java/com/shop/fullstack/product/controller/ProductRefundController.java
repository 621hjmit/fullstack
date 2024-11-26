package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductRefundService;
import com.shop.fullstack.product.vo.ProductRefundVO;

@RestController
public class ProductRefundController {

    @Autowired
    ProductRefundService productRefundService;
    
    @GetMapping("/productRefunds")
    public List<ProductRefundVO> getProductRefunds() {
        return productRefundService.selectProductRefunds();
    }
    
    @PostMapping("/productRefunds")
    public int addProductRefund(ProductRefundVO productRefund) {
        return productRefundService.insertProductRefund(productRefund);
    }
    
    @PutMapping("/productRefunds")
    public int addProductRefund(@RequestBody List<ProductRefundVO> productRefund) {
        return productRefundService.updateProductRefunds(productRefund);
    }
}