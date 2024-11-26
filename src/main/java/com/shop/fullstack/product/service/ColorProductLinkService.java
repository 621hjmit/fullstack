package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ColorProductLinkMapper;
import com.shop.fullstack.product.vo.ProductVO;

@Service
public class ColorProductLinkService {

    @Autowired
    private ColorProductLinkMapper colorProductLinkMapper;

    // 특정 제품의 LINK_ID 조회
    public Integer getLinkIdByProductId(int productId) {
        return colorProductLinkMapper.getLinkIdByProductId(productId);
    }

    // 새로운 LINK_ID 생성
    public int createNewLinkId() {
        Integer maxLinkId = colorProductLinkMapper.getMaxLinkId();
        return (maxLinkId == null) ? 1 : maxLinkId + 1;
    }

    // 두 제품을 매핑 테이블에 추가하는 메서드
    @Transactional
    public void addColorProductLinks(int originalProductId, int newProductId) {
        Integer linkId = getLinkIdByProductId(originalProductId);

        if (linkId == null) {
            // 원본 제품의 LINK_ID가 없다면 새로운 LINK_ID 생성
            linkId = createNewLinkId();
            addColorProductLink(linkId, originalProductId);
        }

        // 새로운 제품을 동일한 LINK_ID로 추가 (중복 방지 로직 포함)
        addColorProductLink(linkId, newProductId);
    }

    // 제품과 LINK_ID 매핑 추가 (중복 매핑 방지 추가)
    public void addColorProductLink(int linkId, int productId) {
        // 중복 매핑 방지: 이미 해당 linkId와 productId로 매핑이 되어 있는지 확인
        if (colorProductLinkMapper.existsColorProductLink(linkId, productId) == 0) {
            colorProductLinkMapper.addColorProductLink(linkId, productId);
        }
    }

    // 특정 제품 매핑 삭제
    public int removeColorProductLinkByProductId(int linkId) {
        return colorProductLinkMapper.deleteColorProductLinkByLinkId(linkId);
    }

    // LINK_ID로 연결된 제품 ID 목록 조회
    public List<Integer> getProductIdsByLinkId(int linkId) {
        return colorProductLinkMapper.selectProductIdsByLinkId(linkId);
    }

    // LINK_ID로 연결된 제품 정보 조회
    public List<ProductVO> getProductsByLinkId(int linkId) {
        return colorProductLinkMapper.getProductsByLinkId(linkId);
    }

    // 색상 등록 시 링크 아이디 중복 방지를 위한 링크 추가 조건 설정 메서드
    @Transactional
    public void addOrEnsureLinkForProduct(int productId) {
        // 특정 제품의 LINK_ID 조회
        Integer linkId = getLinkIdByProductId(productId);

        if (linkId == null) {
            // 만약 제품이 LINK_ID와 연결되어 있지 않다면 새로운 LINK_ID 생성 및 매핑 추가
            linkId = createNewLinkId();
            addColorProductLink(linkId, productId);
        }
    }
    
    public ProductVO getProductById(int piId) {
        return colorProductLinkMapper.getProductById(piId);
    }
}