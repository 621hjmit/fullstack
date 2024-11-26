package com.shop.fullstack.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.product.vo.ProductPaymentVO;

@Mapper
public interface ProductPaymentMapper {
    List<ProductPaymentVO> selectProductPayments();
    ProductPaymentVO selectProductPayment(int ppId);
    int insertProductPayment(ProductPaymentVO productPayment);
    int updateProductPayment(ProductPaymentVO productPayment);
    int deleteProductPayment(int ppId);
}
