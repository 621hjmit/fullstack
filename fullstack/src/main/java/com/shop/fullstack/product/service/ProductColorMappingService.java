package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ProductColorMappingMapper;
import com.shop.fullstack.product.vo.ProductColorMappingVO;
import com.shop.fullstack.product.vo.ProductColorVO;

@Service
public class ProductColorMappingService {

	@Autowired
	private ProductColorMappingMapper productColorMappingMapper;

	// Select all product color mappings
	public List<ProductColorMappingVO> getAllProductColorMappings() {
		return productColorMappingMapper.selectProductColorMappings();
	}

	// Select product color mappings by product ID
	public List<ProductColorVO> selectProductColorsByProductId(int piId) {
		return productColorMappingMapper.selectProductColorsByProductId(piId);
	}

	// Insert product color mapping
	public int addProductColorMapping(ProductColorMappingVO productColorMapping) {
		return productColorMappingMapper.insertProductColorMapping(productColorMapping);
	}

	@Transactional
	public void updateProductColorMapping(int piId, List<ProductColorVO> newColors) {
	    // 기존 색상 리스트 조회
	    List<ProductColorVO> currentColors = productColorMappingMapper.selectProductColorsByProductId(piId);

	    // 색상 정보 변경 여부 확인
	    if (!areColorListsEqual(currentColors, newColors)) {
	        // 색상이 변경된 경우에만 업데이트 진행 (삭제 후 삽입)
	        int deleteCount = productColorMappingMapper.deleteProductColorMappingByProductId(piId);
	        if (deleteCount > 0) {
	            System.out.println(deleteCount + " rows deleted from product_color_mapping table for product ID: " + piId);
	        }

	        for (ProductColorVO color : newColors) {
	            ProductColorMappingVO mapping = new ProductColorMappingVO();
	            mapping.setPiId(piId);
	            mapping.setPcId(color.getPcId());
	            int insertCount = productColorMappingMapper.insertProductColorMapping(mapping);
	            if (insertCount > 0) {
	                System.out.println("Inserted color mapping for product ID: " + piId + ", color ID: " + color.getPcId());
	            }
	        }
	    }
	}

	// Delete product color mapping by product ID
	public int deleteProductColorMappingByProductId(int piId) {
		return productColorMappingMapper.deleteProductColorMappingByProductId(piId);
	}

	// 색상 매핑 저장
	public int saveColorMapping(int productId, int colorId) {
		ProductColorMappingVO colorMapping = new ProductColorMappingVO();
		colorMapping.setPiId(productId);
		colorMapping.setPcId(colorId);
		return productColorMappingMapper.insertProductColorMapping(colorMapping);
	}

	public List<ProductColorMappingVO> getColorProductCountsByDetailCategory(int detailCategoryId) {
		return productColorMappingMapper.selectColorProductCountsByDetailCategory(detailCategoryId);
	}
	
	
	//수정 시 데이터 비교
	private boolean areColorListsEqual(List<ProductColorVO> list1, List<ProductColorVO> list2) {
	    // 리스트가 모두 null일 경우 동일하다고 판단
	    if (list1 == null && list2 == null) {
	        return true;
	    }

	    // 한쪽만 null인 경우 다르다고 판단
	    if (list1 == null || list2 == null) {
	        return false;
	    }

	    // 리스트의 크기가 다르면 다르다고 판단
	    if (list1.size() != list2.size()) {
	        return false;
	    }

	    // 리스트의 내용을 비교
	    for (int i = 0; i < list1.size(); i++) {
	        ProductColorVO color1 = list1.get(i);
	        ProductColorVO color2 = list2.get(i);
	        
	        // ID 값으로 비교
	        if (color1.getPcId() != color2.getPcId()) {
	            return false;
	        }
	    }

	    return true;
	}

}
