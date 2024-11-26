package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductMainInfoVO;

@Mapper
public interface ProductMainInfoMapper {
	List<ProductMainInfoVO> selectProductMainInfos();
	List<ProductMainInfoVO> selectProductMainInfoByProductId(int piId);
    int insertProductMainInfo(ProductMainInfoVO productMainInfo);
    int updateProductMainInfo(ProductMainInfoVO productMainInfo);
    int deleteProductMainInfoById(int piId);
}