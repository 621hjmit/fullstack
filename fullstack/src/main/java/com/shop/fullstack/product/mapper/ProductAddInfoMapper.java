package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductAddInfoVO;

@Mapper
public interface ProductAddInfoMapper {
	List<ProductAddInfoVO> selectProductAddInfos(int paiId);
	ProductAddInfoVO selectProductAddInfo(ProductAddInfoVO productAddInfo);
	int insertProductAddInfo(ProductAddInfoVO productAddInfo);
	int updateProductAddInfo(ProductAddInfoVO productAddInfo);
	int deleteProductAddInfo(int paiId);
}
