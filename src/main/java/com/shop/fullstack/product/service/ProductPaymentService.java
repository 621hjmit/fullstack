package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductPaymentMapper;
import com.shop.fullstack.product.vo.ProductPaymentVO;

@Service
public class ProductPaymentService {
    
    @Autowired
    ProductPaymentMapper productPaymentMapper;
    
    public List<ProductPaymentVO> selectProductPayments() {
        return productPaymentMapper.selectProductPayments();
    }

    public ProductPaymentVO selectProductPayment(int ppId) {
        return productPaymentMapper.selectProductPayment(ppId);
    }

    public int insertProductPayment(ProductPaymentVO productPayment) {
        return productPaymentMapper.insertProductPayment(productPayment);
    }

    // 여러 결제수단 정보를 업데이트하는 메서드 추가
    public int updateProductPayments(List<ProductPaymentVO> productPayments) {
        int updateCount = 0;
        for (ProductPaymentVO productPayment : productPayments) {
            updateCount += productPaymentMapper.updateProductPayment(productPayment);
        }
        return updateCount;
    }

    public int deleteProductPayment(int ppId) {
        return productPaymentMapper.deleteProductPayment(ppId);
    }
}
