package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductDeliveryMapper;
import com.shop.fullstack.product.vo.ProductDeliveryVO;

@Service
public class ProductDeliveryService {
    
    @Autowired
    ProductDeliveryMapper productDeliveryMapper;
    
    public List<ProductDeliveryVO> selectProductDeliveries() {
        return productDeliveryMapper.selectProductDeliveries();
    }

    public ProductDeliveryVO selectProductDelivery(int pdId) {
        return productDeliveryMapper.selectProductDelivery(pdId);
    }

    public int insertProductDelivery(ProductDeliveryVO productDelivery) {
        return productDeliveryMapper.insertProductDelivery(productDelivery);
    }

    public int updateProductDeliveries(List<ProductDeliveryVO> productDeliveries) {
        int updateCount = 0;
        for (ProductDeliveryVO productDelivery : productDeliveries) {
            updateCount += productDeliveryMapper.updateProductDelivery(productDelivery);
        }
        return updateCount;
    }

    public int deleteProductDelivery(int pdId) {
        return productDeliveryMapper.deleteProductDelivery(pdId);
    }
}
