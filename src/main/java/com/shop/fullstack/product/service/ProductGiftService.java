package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductGiftMapper;
import com.shop.fullstack.product.vo.ProductGiftVO;

@Service
public class ProductGiftService {
    
    @Autowired
    ProductGiftMapper productGiftMapper;
    
    public List<ProductGiftVO> selectProductGifts() {
        return productGiftMapper.selectProductGifts();
    }

    public ProductGiftVO selectProductGift(int pgId) {
        return productGiftMapper.selectProductGift(pgId);
    }

    public int insertProductGift(ProductGiftVO productGift) {
        return productGiftMapper.insertProductGift(productGift);
    }

 // 단일 객체와 리스트를 모두 처리하는 업데이트 메서드
    public int updateProductGifts(Object productGifts) {
        int updateCount = 0;

        if (productGifts instanceof List) {
            // 여러 선물 정보가 전달된 경우 리스트로 처리
            List<ProductGiftVO> giftList = (List<ProductGiftVO>) productGifts;
            for (ProductGiftVO productGift : giftList) {
                updateCount += productGiftMapper.updateProductGift(productGift);
            }
        } else if (productGifts instanceof ProductGiftVO) {
            // 단일 선물 정보가 전달된 경우 처리
            ProductGiftVO productGift = (ProductGiftVO) productGifts;
            updateCount += productGiftMapper.updateProductGift(productGift);
        } else {
            throw new IllegalArgumentException("지원하지 않는 데이터 형식입니다.");
        }

        return updateCount;
    }

    public int deleteProductGift(int pgId) {
        return productGiftMapper.deleteProductGift(pgId);
    }
}
