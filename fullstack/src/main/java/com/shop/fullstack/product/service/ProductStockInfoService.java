package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductStockInfoMapper;
import com.shop.fullstack.product.vo.ProductStockInfoVO;

@Service
public class ProductStockInfoService {

	 @Autowired
	    private ProductStockInfoMapper productStockInfoMapper;

	 public void insertProductStockInfo(ProductStockInfoVO productStockInfo) {
	        productStockInfoMapper.insertProductStockInfo(productStockInfo);
	    }

	    public void updateProductStockQuantity(int piId, int quantity) {
	        ProductStockInfoVO productStockInfoVO = new ProductStockInfoVO();
	        productStockInfoVO.setPiId(piId);
	        productStockInfoVO.setQuantity(quantity);
	        productStockInfoMapper.updateProductStockQuantity(productStockInfoVO);
	    }


	    public ProductStockInfoVO selectProductStockInfoByProductId(int piId) {
	        return productStockInfoMapper.selectProductStockInfoByProductId(piId);
	    }

	    public List<ProductStockInfoVO> selectAllProductStockInfos() {
	        return productStockInfoMapper.selectAllProductStockInfos();
	    }
	    
	    
}
