package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;

@Mapper
public interface ProductMaterialMappingMapper {

    // Select all product material mappings
    List<ProductMaterialMappingVO> selectAllProductMaterialMappings();

    // Select product material mapping by product ID
    List<ProductMaterialVO> selectProductMaterialsByProductId(int piId);

    // Insert product material mapping
    int insertProductMaterialMapping(ProductMaterialMappingVO productMaterialMapping);

    // Update product material mapping
    int updateProductMaterialMapping(ProductMaterialMappingVO productMaterialMapping);

    // Delete product material mapping by product ID
    int deleteProductMaterialMappingByProductId(int piId);
    
}
