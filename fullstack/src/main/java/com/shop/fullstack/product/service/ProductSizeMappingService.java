package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ProductSizeMappingMapper;
import com.shop.fullstack.product.vo.ProductSizeMappingVO;
import com.shop.fullstack.product.vo.ProductSizeVO;

@Service
public class ProductSizeMappingService {

	@Autowired
	private ProductSizeMappingMapper productSizeMappingMapper;

	public List<ProductSizeMappingVO> getAllProductSizeMappings() {
		return productSizeMappingMapper.selectProductSizeMappings();
	}

	public List<ProductSizeVO> selectProductSizesByProductId(int piId) {
		return productSizeMappingMapper.selectProductSizesByProductId(piId);
	}

	public int addProductSizeMapping(ProductSizeMappingVO productSizeMappingVO) {
		return productSizeMappingMapper.insertProductSizeMapping(productSizeMappingVO);
	}

	@Transactional
	public void updateProductSizeMapping(int piId, List<ProductSizeVO> newSizes) {
		// 기존 사이즈 리스트 조회
		List<ProductSizeVO> currentSizes = productSizeMappingMapper.selectProductSizesByProductId(piId);

		// 사이즈 정보 변경 여부 확인
		if (!areSizeListsEqual(currentSizes, newSizes)) {
			// 사이즈가 변경된 경우에만 업데이트 진행 (삭제 후 삽입)
			int deleteCount = productSizeMappingMapper.deleteProductSizeMappingByProductId(piId);
			if (deleteCount > 0) {
				System.out
						.println(deleteCount + " rows deleted from product_size_mapping table for product ID: " + piId);
			}

			for (ProductSizeVO size : newSizes) {
				ProductSizeMappingVO mapping = new ProductSizeMappingVO();
				mapping.setPiId(piId);
				mapping.setPsId(size.getPsId());
				int insertCount = productSizeMappingMapper.insertProductSizeMapping(mapping);
				if (insertCount > 0) {
					System.out
							.println("Inserted size mapping for product ID: " + piId + ", size ID: " + size.getPsId());
				}
			}
		}
	}

	private boolean areSizeListsEqual(List<ProductSizeVO> list1, List<ProductSizeVO> list2) {
		if (list1.size() != list2.size()) {
			return false;
		}
		for (int i = 0; i < list1.size(); i++) {
			if (list1.get(i).getPsId() != list2.get(i).getPsId()) {
				return false;
			}
		}
		return true;
	}

	public int deleteProductSizeMapping(int piId) {
		return productSizeMappingMapper.deleteProductSizeMappingByProductId(piId);
	}

	// 사이즈 매핑 저장
	public int saveSizeMapping(int productId, int sizeId) {
		ProductSizeMappingVO sizeMapping = new ProductSizeMappingVO();
		sizeMapping.setPiId(productId);
		sizeMapping.setPsId(sizeId);
		return productSizeMappingMapper.insertProductSizeMapping(sizeMapping);
	}

}
