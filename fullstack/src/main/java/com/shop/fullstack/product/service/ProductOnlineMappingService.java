package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductOnlineMappingMapper;
import com.shop.fullstack.product.vo.ProductOnlineMappingVO;

@Service
public class ProductOnlineMappingService {

	@Autowired
    private ProductOnlineMappingMapper productOnlineMappingMapper;

    // 온라인 구매 가능 여부 삽입
    public int addProductOnlineMapping(ProductOnlineMappingVO productOnlineMappingVO) {
        return productOnlineMappingMapper.insertProductOnlineMapping(productOnlineMappingVO);
    }

    // 특정 제품의 온라인 구매 가능 여부 업데이트
    public int modifyProductOnlineMapping(ProductOnlineMappingVO productOnlineMappingVO) {
        return productOnlineMappingMapper.updateProductOnlineMapping(productOnlineMappingVO);
    }

    // 특정 제품의 온라인 구매 가능 여부 조회
    public ProductOnlineMappingVO getProductOnlineMappingByProductId(int piId) {
        return productOnlineMappingMapper.selectProductOnlineMappingByProductId(piId);
    }

    // 모든 온라인 구매 가능 제품 조회
    public List<ProductOnlineMappingVO> getAllOnlineProducts() {
        return productOnlineMappingMapper.selectAllOnlineProducts();
    }
}
