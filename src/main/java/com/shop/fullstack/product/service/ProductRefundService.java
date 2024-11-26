package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductRefundMapper;
import com.shop.fullstack.product.vo.ProductRefundVO;

@Service
public class ProductRefundService {
    
    @Autowired
    ProductRefundMapper productRefundMapper;
    
    public List<ProductRefundVO> selectProductRefunds() {
        return productRefundMapper.selectProductRefunds();
    }

    public ProductRefundVO selectProductRefund(int prId) {
        return productRefundMapper.selectProductRefund(prId);
    }

    public int insertProductRefund(ProductRefundVO productRefund) {
        return productRefundMapper.insertProductRefund(productRefund);
    }

    public int updateProductRefunds(List<ProductRefundVO> productRefunds) {
        int updateCount = 0;
        for (ProductRefundVO productRefund : productRefunds) {
            updateCount += productRefundMapper.updateProductRefund(productRefund);
        }
        return updateCount;
    }

    public int deleteProductRefund(int prId) {
        return productRefundMapper.deleteProductRefund(prId);
    }
}