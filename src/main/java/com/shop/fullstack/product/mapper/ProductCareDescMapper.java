package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductCareDescVO;

@Mapper
public interface ProductCareDescMapper {
    List<ProductCareDescVO> selectProductCareDescs();
    ProductCareDescVO selectProductCareDesc(int pcdId);
    int insertProductCareDesc(ProductCareDescVO productCareDesc);
    int updateProductCareDesc(ProductCareDescVO productCareDesc);
    int deleteProductCareDesc(int pcdId);
}