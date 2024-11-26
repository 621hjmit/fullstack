package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductStockInfoVO;

@Mapper
public interface ProductStockInfoMapper {
	int insertProductStockInfo(ProductStockInfoVO productStockInfoVO);
    int updateProductStockQuantity(ProductStockInfoVO productStockInfoVO);
    ProductStockInfoVO selectProductStockInfoByProductId(int piId);
    List<ProductStockInfoVO> selectAllProductStockInfos();
}
