package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductCareDescMapper;
import com.shop.fullstack.product.vo.ProductCareDescVO;

@Service
public class ProductCareDescService {
    
    @Autowired
    ProductCareDescMapper productCareDescMapper;
    
    public List<ProductCareDescVO> selectProductCareDescs() {
        return productCareDescMapper.selectProductCareDescs();
    }

    public ProductCareDescVO selectProductCareDesc(int pcdId) {
        return productCareDescMapper.selectProductCareDesc(pcdId);
    }

    public int insertProductCareDesc(ProductCareDescVO productCareDesc) {
        return productCareDescMapper.insertProductCareDesc(productCareDesc);
    }

    public int updateProductCareDesc(ProductCareDescVO productCareDesc) {
        return productCareDescMapper.updateProductCareDesc(productCareDesc);
    }

    public int deleteProductCareDesc(int pcdId) {
        return productCareDescMapper.deleteProductCareDesc(pcdId);
    }
}
