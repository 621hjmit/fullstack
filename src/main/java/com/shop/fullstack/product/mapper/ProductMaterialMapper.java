package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;

@Mapper
public interface ProductMaterialMapper {
    List<ProductMaterialVO> selectProductMaterials();
    ProductMaterialVO selectProductMaterial(int pmId);
    int insertProductMaterial(ProductMaterialVO productMaterial);
    int updateProductMaterial(ProductMaterialVO productMaterial);
    int deleteProductMaterial(int pmId);
    List<ProductMaterialVO> selectMaterialFilterItemCountByDetailCategoryId(@Param("detailCategoryId") int detailCategoryId);
}
