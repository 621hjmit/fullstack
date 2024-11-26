package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductSizeMapper;
import com.shop.fullstack.product.vo.ProductSizeVO;

@Service
public class ProductSizeService {
    
    @Autowired
    ProductSizeMapper productSizeMapper;
    
    public List<ProductSizeVO> selectProductSizes() {
        return productSizeMapper.selectProductSizes();
    }

    public ProductSizeVO selectProductSize(int psId) {
        return productSizeMapper.selectProductSize(psId);
    }

    public int insertProductSize(ProductSizeVO productSize) {
        return productSizeMapper.insertProductSize(productSize);
    }

    public int updateProductSize(ProductSizeVO productSize) {
        return productSizeMapper.updateProductSize(productSize);
    }

    public int deleteProductSize(int psId) {
        return productSizeMapper.deleteProductSize(psId);
    }
}
