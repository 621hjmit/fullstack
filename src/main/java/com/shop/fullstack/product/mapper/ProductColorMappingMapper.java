package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductColorMappingVO;
import com.shop.fullstack.product.vo.ProductColorVO;

@Mapper
public interface ProductColorMappingMapper {

    // Select all product color mappings
    List<ProductColorMappingVO> selectProductColorMappings();

    // Select product color mappings by product ID
    List<ProductColorVO> selectProductColorsByProductId(int piId);

    // Insert product color mapping
    int insertProductColorMapping(ProductColorMappingVO productColorMapping);

    // Update product color mapping
    int updateProductColorMapping(ProductColorMappingVO productColorMapping);

    // Delete product color mapping by product ID
    int deleteProductColorMappingByProductId(int piId);
    
    List<ProductColorMappingVO> selectColorProductCountsByDetailCategory(@Param("detailCategoryId") int detailCategoryId);
}