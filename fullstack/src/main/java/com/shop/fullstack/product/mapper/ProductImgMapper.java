package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.product.vo.ProductImgVO;

@Mapper
public interface ProductImgMapper {

	List<ProductImgVO> selectProductImgs(ProductImgVO productImg);

	ProductImgVO selectProductImg(ProductImgVO productImg);

	int insertProductImg(ProductImgVO productImg);
	
	int updateProductImg(ProductImgVO productImg);

	int deleteProductImg(int piId);
	
	List<ProductImgVO> selectImagesByProductId(@Param("piId") int piId); // 특정 제품의 이미지 조회
}