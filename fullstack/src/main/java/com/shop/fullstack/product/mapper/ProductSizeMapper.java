package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductSizeVO;

@Mapper
public interface ProductSizeMapper {
    List<ProductSizeVO> selectProductSizes();
    ProductSizeVO selectProductSize(int psId);
    int insertProductSize(ProductSizeVO productSize);
    int updateProductSize(ProductSizeVO productSize);
    int deleteProductSize(int psId);
}