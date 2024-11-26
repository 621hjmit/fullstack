package com.shop.fullstack.product.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shop.fullstack.product.service.ProductImgService;
import com.shop.fullstack.product.vo.ProductImgVO;

@RestController
public class ProductImgController {

    @Autowired
    private ProductImgService productImgService;

    @GetMapping("/productImg")
    public List<ProductImgVO> getProductImgs(ProductImgVO img) {
        return productImgService.selectProductImgs(img);
    }

    @GetMapping("/productImg/{piId}")
    public List<ProductImgVO> getProductImage(@PathVariable int piId) {
        return productImgService.getImagesByProductId(piId);
    }

    @PostMapping("/productImg")
    public int addProductImage(@ModelAttribute ProductImgVO productImgVO, @RequestParam("images") MultipartFile[] images) {
        try {
            List<MultipartFile> imageList = Arrays.asList(images);
            return productImgService.saveProductImages(productImgVO.getPiId(), imageList);
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
 // 제품 이미지 수정 메서드
    @PutMapping("/productImg/{piId}/update")
    public ResponseEntity<String> updateProductImages(@PathVariable int piId,
                                                      @RequestPart(value = "mainImage", required = false) MultipartFile mainImage,
                                                      @RequestPart(value = "detailImages", required = false) List<MultipartFile> detailImages) {
        try {
            // 서비스 호출을 통해 기존 이미지를 삭제하고 새 이미지를 저장
            productImgService.updateProductImages(piId, mainImage, detailImages);

            return ResponseEntity.ok("Product images updated successfully.");
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update product images: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Unexpected error occurred: " + e.getMessage());
        }
    }
    
}
