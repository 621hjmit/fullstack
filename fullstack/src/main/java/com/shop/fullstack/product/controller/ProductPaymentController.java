package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductPaymentService;
import com.shop.fullstack.product.vo.ProductPaymentVO;

@RestController
public class ProductPaymentController {

    @Autowired
    ProductPaymentService productPaymentService;
    
    @GetMapping("/productPayments")
    public List<ProductPaymentVO> getProductPayments() {
        return productPaymentService.selectProductPayments();
    }
    
    @PostMapping("/productPayments")
    public int addProductPayment(ProductPaymentVO productPayment) {
        return productPaymentService.insertProductPayment(productPayment);
    }
    
    @PutMapping("/productPayments")
    public int modifyProductPayment(@RequestBody List<ProductPaymentVO> productPayment) {
        return productPaymentService.updateProductPayments(productPayment);
    }
}