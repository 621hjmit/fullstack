package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductOnlineMappingVO;

@Mapper
public interface ProductOnlineMappingMapper {

	// 온라인 구매 가능 여부 삽입
    int insertProductOnlineMapping(ProductOnlineMappingVO productOnlineMappingVO);

    // 특정 제품의 온라인 구매 가능 여부 업데이트
    int updateProductOnlineMapping(ProductOnlineMappingVO productOnlineMappingVO);

    // 특정 제품의 온라인 구매 가능 여부 조회
    ProductOnlineMappingVO selectProductOnlineMappingByProductId(int piId);

    // 모든 온라인 구매 가능 제품 조회
    List<ProductOnlineMappingVO> selectAllOnlineProducts();
}
