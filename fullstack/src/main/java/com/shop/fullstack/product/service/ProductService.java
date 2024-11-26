package com.shop.fullstack.product.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.fullstack.product.mapper.ProductImgMapper;
import com.shop.fullstack.product.mapper.ProductMapper;
import com.shop.fullstack.product.vo.ProductColorMappingVO;
import com.shop.fullstack.product.vo.ProductColorVO;
import com.shop.fullstack.product.vo.ProductDetailInfoVO;
import com.shop.fullstack.product.vo.ProductImgVO;
import com.shop.fullstack.product.vo.ProductMainInfoVO;
import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;
import com.shop.fullstack.product.vo.ProductSizeMappingVO;
import com.shop.fullstack.product.vo.ProductSizeVO;
import com.shop.fullstack.product.vo.ProductStockInfoVO;
import com.shop.fullstack.product.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductService {
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private ProductImgService productImgService;
	@Autowired
	private ProductColorMappingService productColorMappingService;
	@Autowired
	private ProductSizeMappingService productSizeMappingService;
	@Autowired
	private ProductMaterialMappingService productMaterialMappingService;
	@Autowired
	private ProductMainInfoService productMainInfoService;
	@Autowired
	private ProductDetailInfoService productDetailInfoService;
	@Autowired
	ProductImgMapper productImgMapper;
	@Autowired
	ColorProductLinkService colorProductLinkService;
	@Autowired
	ProductStockInfoService productStockInfoService;

	public List<ProductVO> selectPaginatedProducts(int page, int itemsPerPage) {
	    // 페이지네이션 계산
	    int offset = (page - 1) * itemsPerPage;
	    
	    // ProductVO 객체에 페이지네이션 정보 설정
	    ProductVO productVO = new ProductVO();
	    productVO.setItemsPerPage(itemsPerPage);
	    productVO.setOffset(offset);

	    // 전체 제품 수 계산
	    int totalItems = productMapper.countTotalProducts();
	    productVO.setTotalItems(totalItems);
	    return productMapper.selectProducts(productVO);
	}
	
	public int countTotalProducts() {
        return productMapper.countTotalProducts();
    }
	
	public List<ProductVO> selectProducts(ProductVO product) {
	    return productMapper.selectProducts(product);
	}

	public ProductVO selectProductById(int piId) {
		ProductVO product = productMapper.selectProductById(piId);
		if (product != null) {
			// 대표 이미지 URL 설정
			String mainImageUrl = product.getPimgUrl();
			if (mainImageUrl != null) {
				product.setPimgUrl(mainImageUrl);
			}

			// 세부 이미지 설정
			List<ProductImgVO> productImgs = productImgService.getImagesByProductId(piId);
			product.setProductImgs(productImgs);

			// 색상 정보 설정 (매핑 서비스 사용)
			List<ProductColorVO> colorList = productColorMappingService.selectProductColorsByProductId(piId);
			product.setColorList(colorList);

			// 사이즈 정보 설정 (매핑 서비스 사용)
			List<ProductSizeVO> sizeList = productSizeMappingService.selectProductSizesByProductId(piId);
			product.setSizeList(sizeList);

			// 소재 정보 설정 (매핑 서비스 사용)
			List<ProductMaterialVO> materialList = productMaterialMappingService
					.selectProductMaterialsByProductId(piId);
			product.setMaterialList(materialList);

			// 주요 정보 설정 (매핑 서비스 사용)
			List<ProductMainInfoVO> mainInfoList = productMainInfoService.selectProductMainInfoByProductId(piId);
			product.setMainInfoList(mainInfoList);

			// 제품 세부 정보 설정 (단일 객체로 할당)
			ProductDetailInfoVO productDetailInfo = productDetailInfoService.selectProductDetailInfoByProductId(piId);
			product.setProductDetailInfo(productDetailInfo);
		}
		return product;
	}

	public List<String> getProductCareDescriptions(int piId) {
		return productMapper.selectProductCareDescriptions(piId);
	}

	public List<ProductVO> selectProductsByDetailCategoryId(Integer detailCategoryId) {
		List<ProductVO> products = productMapper.selectProductsByDetailCategoryId(detailCategoryId);
		log.info("Retrieved products: {}", products); // 여기서 쿼리 결과 확인
		for (ProductVO product : products) {
			List<ProductImgVO> images = productImgMapper.selectImagesByProductId(product.getPiId());
			product.setProductImgs(images);
			log.info("Product ID: {}, Images: {}", product.getPiId(), product.getProductImgs());
		}
		return products;
	}

	@Transactional
	public int insertProductWithDetails(ProductVO product, List<MultipartFile> images, List<ProductColorVO> colors,
			List<ProductSizeVO> sizes, List<ProductMaterialVO> materials, List<ProductMainInfoVO> mainInfos,
			ProductDetailInfoVO productDetailInfo) throws IOException {
		if (productDetailInfo == null || productDetailInfo.getPdiHeight() == null
				|| productDetailInfo.getPdiSize() == null) {
			throw new IllegalArgumentException("제품 세부 정보의 필수 값이 누락되었습니다. (높이, 사이즈 등)");
		}

		int result = productMapper.insertProduct(product);
		if (result > 0) {
			int productId = product.getPiId();

			// product_online_mapping에 데이터 삽입
			productMapper.insertProductOnlineMapping(productId);

			// 이미지 저장
			if (!images.isEmpty()) {
				productImgService.saveProductImages(productId, images);
			}

			// 색상 매핑 저장
			for (ProductColorVO color : colors) {
				ProductColorMappingVO colorMapping = new ProductColorMappingVO();
				colorMapping.setPiId(productId);
				colorMapping.setPcId(color.getPcId());
				productColorMappingService.addProductColorMapping(colorMapping);
			}

			// 사이즈 매핑 저장
			for (ProductSizeVO size : sizes) {
				ProductSizeMappingVO sizeMapping = new ProductSizeMappingVO();
				sizeMapping.setPiId(productId);
				sizeMapping.setPsId(size.getPsId());
				productSizeMappingService.addProductSizeMapping(sizeMapping);
			}

			// 소재 매핑 저장
			for (ProductMaterialVO material : materials) {
				ProductMaterialMappingVO materialMapping = new ProductMaterialMappingVO();
				materialMapping.setPiId(productId);
				materialMapping.setPmId(material.getPmId());
				productMaterialMappingService.addProductMaterialMapping(materialMapping);
			}

			// 주요 정보 저장
			for (ProductMainInfoVO mainInfo : mainInfos) {
				mainInfo.setPiId(productId);
				productMainInfoService.addProductMainInfo(mainInfo);
			}

			// 제품 세부 정보 저장
			productDetailInfo.setPiId(productId); // 반드시 productId가 설정된 후에 저장
			productDetailInfoService.insertproductDetailInfo(productDetailInfo);
			
			//재고 정보 삽입
            ProductStockInfoVO productStockInfo = new ProductStockInfoVO();
            productStockInfo.setPiId(productId);
            productStockInfoService.insertProductStockInfo(productStockInfo);
		}

		return result;
	}

	// 제품 업데이트 메서드
	public void updateProduct(int piId, ProductVO product) {
		// ProductVO 객체에 piId 설정 (혹시 VO 객체에 이미 설정되어 있지 않은 경우를 대비)
		product.setPiId(piId);

		// ProductMapper 호출하여 제품 정보 업데이트
		productMapper.updateProduct(product);
	}

	public int deleteProduct(int pId) {
		return productMapper.deleteProduct(pId);
	}
	
	public List<ProductVO> selectFilteredProducts(Map<String, Object> filters, Integer page, Integer itemsPerPage) {
        int offset = 0;
        if (page != null && itemsPerPage != null) {
            offset = (page - 1) * itemsPerPage;
            filters.put("offset", offset);
            filters.put("itemsPerPage", itemsPerPage);
        }
        return productMapper.selectProductsWithFilters(filters);
    }

    public int countFilteredProducts(Map<String, Object> filters) {
        return productMapper.countProductsByFilters(filters);
    }
}
