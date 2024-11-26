package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductGiftService;
import com.shop.fullstack.product.vo.ProductGiftVO;

@RestController
public class ProductGiftController {

    @Autowired
    ProductGiftService productGiftService;
    
    @GetMapping("/productGifts")
    public List<ProductGiftVO> getProductGifts() {
        return productGiftService.selectProductGifts();
    }
    
    @PostMapping("/productGift")
    public int addProductGift(ProductGiftVO productGift) {
        return productGiftService.insertProductGift(productGift);
    }
    
    @PutMapping("/productGifts")
    public int modifyProductGifts(@RequestBody List<ProductGiftVO> productGifts) {
        return productGiftService.updateProductGifts(productGifts);
    }
}
