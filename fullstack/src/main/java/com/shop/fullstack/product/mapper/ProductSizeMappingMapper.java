package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductSizeMappingVO;
import com.shop.fullstack.product.vo.ProductSizeVO;

@Mapper
public interface ProductSizeMappingMapper {
    List<ProductSizeMappingVO> selectProductSizeMappings();
    List<ProductSizeVO> selectProductSizesByProductId(int piId);
    int insertProductSizeMapping(ProductSizeMappingVO productSizeMappingVO);
    int deleteProductSizeMappingByProductId(ProductSizeMappingVO productSizeMappingVO);
    int deleteProductSizeMappingByProductId(int piId);
    ProductSizeMappingVO selectSizeById(int sizeId);
}
