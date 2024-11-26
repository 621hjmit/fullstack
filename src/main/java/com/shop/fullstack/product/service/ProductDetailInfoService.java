package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ProductDetailInfoMapper;
import com.shop.fullstack.product.vo.ProductDetailInfoVO;

@Service
public class ProductDetailInfoService {
	@Autowired
	private ProductDetailInfoMapper productDetailInfoMapper;

	public List<ProductDetailInfoVO> selectProductDetailInfos(ProductDetailInfoVO productDetailInfo){
		return productDetailInfoMapper.selectProductDetailInfos(productDetailInfo);
	}
	public ProductDetailInfoVO selectProductDetailInfoByProductId(int piId) {
        return productDetailInfoMapper.selectProductDetailInfoByProductId(piId);
    }
	public int insertproductDetailInfo(ProductDetailInfoVO productDetailInfo) {
	    return productDetailInfoMapper.insertProductDetailInfo(productDetailInfo);
	}
	 @Transactional
	    public int updateProductDetailInfo(ProductDetailInfoVO productDetailInfo) {
	        return productDetailInfoMapper.updateProductDetailInfo(productDetailInfo);
	    }
	public int deleteproductDetailInfo(ProductDetailInfoVO productDetailInfo) {
		return productDetailInfoMapper.deleteProductDetailInfo(productDetailInfo);
	}
}