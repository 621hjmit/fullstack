package com.shop.fullstack.product.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ColorProductLinkService;
import com.shop.fullstack.product.vo.ProductVO;

@RestController
public class ColorProductLinkController {

    @Autowired
    private ColorProductLinkService colorProductLinkService;

    // 두 제품을 색상 매핑 테이블에 추가
    @PostMapping("/colorProductLink")
    public ResponseEntity<String> addColorProductLinks(@RequestParam int originalProductId,
                                                       @RequestParam int newProductId) {
        try {
            colorProductLinkService.addColorProductLinks(originalProductId, newProductId);
            return ResponseEntity.ok("색상 매핑이 성공적으로 추가되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("색상 매핑 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    // 특정 제품의 매핑 삭제
    @DeleteMapping("/colorProductLink/{linkId}")
    public ResponseEntity<String> removeColorProductLinkByLinkId(@PathVariable int linkId) {
        try {
            int deleteCount = colorProductLinkService.removeColorProductLinkByProductId(linkId);
            if (deleteCount > 0) {
                return ResponseEntity.noContent().build(); // 삭제 성공, 내용 없음
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                                     .body("해당 제품의 매핑이 존재하지 않습니다.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("매핑 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    // LINK_ID로 연결된 제품 ID 목록 조회
    @GetMapping("/colorProductLink/link/{linkId}")
    public ResponseEntity<List<Integer>> getProductIdsByLinkId(@PathVariable int linkId) {
        try {
            List<Integer> productIds = colorProductLinkService.getProductIdsByLinkId(linkId);
            if (productIds.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                                     .body(Collections.emptyList());
            }
            return ResponseEntity.ok(productIds);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Collections.emptyList());
        }
    }

    @GetMapping("/colorProductLink/linked/{piId}")
    public ResponseEntity<List<ProductVO>> getLinkedProducts(@PathVariable int piId) {
        try {
            Integer linkId = colorProductLinkService.getLinkIdByProductId(piId);
            if (linkId == null) {
                // 링크 ID가 없을 경우 빈 리스트 반환
                return ResponseEntity.ok(Collections.emptyList());
            }
            List<ProductVO> linkedProducts = colorProductLinkService.getProductsByLinkId(linkId);
            return ResponseEntity.ok(linkedProducts);
        } catch (Exception e) {
            // 오류 로그를 남기고 500 응답을 반환
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.emptyList());
        }
    }
}