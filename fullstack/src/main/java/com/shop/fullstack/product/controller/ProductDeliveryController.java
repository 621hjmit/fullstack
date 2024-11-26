package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductDeliveryService;
import com.shop.fullstack.product.vo.ProductDeliveryVO;

@RestController
public class ProductDeliveryController {

    @Autowired
    ProductDeliveryService productDeliveryService;
    
    @GetMapping("/productDeliveries")
    public List<ProductDeliveryVO> getProductDeliveries() {
        return productDeliveryService.selectProductDeliveries();
    }
    
    @PostMapping("/productDeliveries")
    public int addProductDelivery(ProductDeliveryVO productDelivery) {
        return productDeliveryService.insertProductDelivery(productDelivery);
    }
    
    @PutMapping("/productDeliveries")
    public int modifyProductDeliveries(@RequestBody List<ProductDeliveryVO> productDeliveries) {
        return productDeliveryService.updateProductDeliveries(productDeliveries);
    }
}
