package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductVO;

@Mapper
public interface ColorProductLinkMapper {

    // 특정 제품의 LINK_ID 조회
    Integer getLinkIdByProductId(@Param("productId") int productId);

    // 특정 제품의 모든 LINK_ID 조회 (중복 체크용)
    List<Integer> getLinkIdsByProductId(@Param("productId") int productId);

    // 최대 LINK_ID 조회
    Integer getMaxLinkId();

    // 제품과 LINK_ID 매핑 추가
    void addColorProductLink(@Param("linkId") int linkId, @Param("piId") int piId);

    // LINK_ID로 연결된 제품 정보 조회
    List<ProductVO> getProductsByLinkId(@Param("linkId") int linkId);

    // LINK_ID로 제품 ID 목록 조회
    List<Integer> selectProductIdsByLinkId(@Param("linkId") int linkId);

    // 특정 제품 매핑 삭제 (LINK_ID 기준으로 삭제)
    int deleteColorProductLinkByLinkId(@Param("linkId") int linkId);

    // 중복 매핑 확인
    int existsColorProductLink(@Param("linkId") int linkId, @Param("productId") int productId);
    
    ProductVO getProductById(@Param("piId") int piId);
    
}