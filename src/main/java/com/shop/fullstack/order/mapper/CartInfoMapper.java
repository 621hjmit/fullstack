package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.CartInfoVO;

public interface CartInfoMapper {
	
	int selectMyCartTotal(CartInfoVO cart);
	List<CartInfoVO> selectMyCart(CartInfoVO cart);
	CartInfoVO selectCart(int ciNum);
	int insertCart(CartInfoVO cart);
	int updateCart(CartInfoVO cart);
	int deleteCart(int ciNum);
}
