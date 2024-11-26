package com.shop.fullstack.product.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductImgVO;
import com.shop.fullstack.product.vo.ProductVO;

@Mapper
public interface ProductMapper {
	int countTotalProducts();
	List<ProductVO> selectProducts(ProductVO productVO);
    ProductVO selectProductById(int piId);  // 수정된 부분
    List<ProductImgVO> selectProductImages(int piId);
    int insertProduct(ProductVO product);
    int updateProductWithDetails(ProductVO product);
    int updateProductImageUrl(@Param("piId") int piId, @Param("imageUrl") String imageUrl);
    int deleteProduct(int pId);
    int updateProduct(ProductVO product);
    List<ProductVO> selectProductsByDetailCategoryId(Integer detailCategoryId);
    List<String> selectProductCareDescriptions(@Param("piId") int piId);
    int insertProductOnlineMapping(int piId);
    
    // 필터링 기능을 위한 새로운 메서드 추가
    List<ProductVO> selectProductsWithFilters(Map<String, Object> filters);
    int countProductsByFilters(Map<String, Object> filters);
}