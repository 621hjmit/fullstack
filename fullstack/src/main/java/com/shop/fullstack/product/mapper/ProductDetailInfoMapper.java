
package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductDetailInfoVO;

@Mapper
public interface ProductDetailInfoMapper {

	List<ProductDetailInfoVO> selectProductDetailInfos(ProductDetailInfoVO productDetailInfo);
	ProductDetailInfoVO selectProductDetailInfoByProductId(int piId);
	int insertProductDetailInfo(ProductDetailInfoVO productDetailInfo);
	 int updateProductDetailInfo(ProductDetailInfoVO productDetailInfo);
	int deleteProductDetailInfo(ProductDetailInfoVO productDetailInfo);
}
