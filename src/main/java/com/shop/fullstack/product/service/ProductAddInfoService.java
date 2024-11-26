package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.product.mapper.ProductAddInfoMapper;
import com.shop.fullstack.product.vo.ProductAddInfoVO;

@Service
public class ProductAddInfoService {
	
	@Autowired
	ProductAddInfoMapper productAddInfoMapper;
	
	public List<ProductAddInfoVO> selectProductAddInfos(int paiId){
		return productAddInfoMapper.selectProductAddInfos(paiId);
	}
	public ProductAddInfoVO selectProductAddInfo(ProductAddInfoVO productAddInfo) {
		return productAddInfoMapper.selectProductAddInfo(productAddInfo);
	}
	public int insertProductAddInfo(ProductAddInfoVO productAddInfo) {
		return productAddInfoMapper.insertProductAddInfo(productAddInfo);
	}
	public int updateProductAddInfo(ProductAddInfoVO productAddInfo) {
		return productAddInfoMapper.updateProductAddInfo(productAddInfo);
	}
	public int deleteProductAddInfo(int paiId) {
		return productAddInfoMapper.deleteProductAddInfo(paiId);
	}
}
