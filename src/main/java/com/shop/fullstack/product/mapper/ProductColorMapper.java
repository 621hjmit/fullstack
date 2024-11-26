package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductColorVO;

@Mapper
public interface ProductColorMapper {
    List<ProductColorVO> selectProductColors();
    ProductColorVO selectProductColor(int pcId);
    int insertProductColor(ProductColorVO productColor);
    int updateProductColor(ProductColorVO productColor);
    int deleteProductColor(int pcId);
    List<ProductColorVO> selectColorFilterItemCountByDetailCategoryId(@Param("detailCategoryId") int detailCategoryId);
}
