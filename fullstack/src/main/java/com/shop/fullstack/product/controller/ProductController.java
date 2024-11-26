package com.shop.fullstack.product.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.fullstack.product.service.ProductImgService;
import com.shop.fullstack.product.service.ProductService;
import com.shop.fullstack.product.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired
	private ProductService productService;
	
	@Autowired
    private ProductImgService productImgService;

	//어드민 페이지에서 아이디에 해당하는 제품 로드
	@GetMapping("/product/{piId}")
	public ResponseEntity<ProductVO> getProductById(@PathVariable int piId) {
	    ProductVO product = productService.selectProductById(piId);
	    if (product != null) {
	        return ResponseEntity.ok(product);
	    } else {
	        return ResponseEntity.notFound().build();
	    }
	}
	
	//어드민 리스트에서 뭐 찍는거였는데 까먹음
	@GetMapping("/products")
	public ResponseEntity<List<ProductVO>> getProducts(@RequestParam(required = false) Integer piDetailCategoryId) {
	    List<ProductVO> products;

	    if (piDetailCategoryId != null) {
	        products = productService.selectProductsByDetailCategoryId(piDetailCategoryId);
	    } else {
	        ProductVO product = new ProductVO();
	        products = productService.selectProducts(product);
	    }

	    return ResponseEntity.ok(products);
	}
	
	//페이지 네이션에 쓰는거
	@GetMapping("/product-pagination")
	public ResponseEntity<Map<String, Object>> getProducts(
	    @RequestParam(required = false) Integer piDetailCategoryId,
	    @RequestParam(required = false) Integer page,
	    @RequestParam(required = false) Integer itemsPerPage,
	    @RequestParam(required = false) String piName,
	    @RequestParam(required = false) String piCode,
	    @RequestParam(required = false) Integer piMainCategoryId,
	    @RequestParam(required = false) Integer piSubCategoryId
	) {
	    // 필터링 조건을 담기 위한 Map 생성
	    Map<String, Object> filters = new HashMap<>();
	    filters.put("piDetailCategoryId", piDetailCategoryId);
	    filters.put("piName", piName);
	    filters.put("piCode", piCode);
	    filters.put("piMainCategoryId", piMainCategoryId);
	    filters.put("piSubCategoryId", piSubCategoryId);

	    List<ProductVO> products;
	    int totalItems = 0;

	    // 필터 조건이 있는 경우
	    if (filters.values().stream().anyMatch(val -> val != null && !(val instanceof Integer && (Integer) val == 0))) {
	        products = productService.selectFilteredProducts(filters, page, itemsPerPage);
	        totalItems = productService.countFilteredProducts(filters);
	    } 
	    // 상세 카테고리 ID가 있는 경우
	    else if (piDetailCategoryId != null) {
	        products = productService.selectProductsByDetailCategoryId(piDetailCategoryId);
	        totalItems = products.size();
	    } 
	    // 페이지네이션을 위한 경우
	    else if (page != null && itemsPerPage != null) {
	        products = productService.selectPaginatedProducts(page, itemsPerPage);
	        totalItems = productService.countTotalProducts();
	    } 
	    // 필터 조건이나 페이지네이션 없이 전체 목록 조회
	    else {
	        ProductVO product = new ProductVO();
	        products = productService.selectProducts(product);
	        totalItems = products.size();
	    }

	    // 응답 데이터를 Map에 담아 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("list", products);
	    response.put("totalItems", totalItems);

	    return ResponseEntity.ok(response);
	}
	
	//어드민 페이지 상품 리스트
	@GetMapping("/products-full-info")
	public List<ProductVO> getProducts(ProductVO product) {
		return productService.selectProducts(product);
	}
	
	//유저 페이지 상품 리스트->그냥 어드민 페이지 상품 리스트도 같이
	@GetMapping("/products/detail/{detailCategoryId}")
	public ResponseEntity<List<ProductVO>> getProductsByDetailCategoryId(@PathVariable Integer detailCategoryId) {
		log.info("Request received for products with detailCategoryId: {}", detailCategoryId);
		List<ProductVO> products = productService.selectProductsByDetailCategoryId(detailCategoryId);

		if (products == null || products.isEmpty()) {
			log.warn("No products found for detailCategoryId: {}", detailCategoryId);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.emptyList());
		}
		return ResponseEntity.ok(products);
	}
	
	//소재정보 매핑
	@GetMapping("product/care-desc/{piId}")
    public ResponseEntity<List<String>> getProductCareDescriptions(@PathVariable int piId) {
        List<String> careDescriptions = productService.getProductCareDescriptions(piId);
        if (careDescriptions != null && !careDescriptions.isEmpty()) {
            return ResponseEntity.ok(careDescriptions);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Collections.emptyList());
        }
    }
	
	@PostMapping("/product")
	public ResponseEntity<ProductVO> addProduct(@RequestPart("productData") String productData,
	                                            @RequestPart("images") List<MultipartFile> images) {
	    try {
	        // 제품 정보 파싱
	        ObjectMapper objectMapper = new ObjectMapper();
	        ProductVO productVO = objectMapper.readValue(productData, ProductVO.class);

	        // 제품과 이미지를 저장하는 서비스 호출
	        productService.insertProductWithDetails(
	                productVO, 
	                images, 
	                productVO.getColorList(), 
	                productVO.getSizeList(), 
	                productVO.getMaterialList(), 
	                productVO.getMainInfoList(), 
	                productVO.getProductDetailInfo()
	        );

	        // 제품 등록 후, 생성된 piId를 포함한 productVO를 반환
	        return ResponseEntity.ok(productVO);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
	@PutMapping("/product/{piId}")
	public ResponseEntity<String> updateProduct(@PathVariable int piId, @RequestBody ProductVO product) {
        try {
            // 서비스 호출로 제품 업데이트 처리
            productService.updateProduct(piId, product);
            return ResponseEntity.ok("Product updated successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update product: " + e.getMessage());
        }
    }

	@DeleteMapping("/product/{piId}")
	public int deleteProduct(@PathVariable int piId) {
		return productService.deleteProduct(piId);
	}
}
