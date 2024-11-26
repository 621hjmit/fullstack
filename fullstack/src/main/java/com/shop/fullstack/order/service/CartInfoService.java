package com.shop.fullstack.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.CartInfoMapper;
import com.shop.fullstack.order.vo.CartInfoVO;
import com.shop.fullstack.order.vo.ResultCountVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CartInfoService {
	
	
	@Autowired
	private CartInfoMapper cartInfoMapper;
	
	public ResultCountVO<CartInfoVO> getMyCart(CartInfoVO cart){
		ResultCountVO<CartInfoVO> resultCount = new ResultCountVO<>();
		resultCount.setList(cartInfoMapper.selectMyCart(cart));
		resultCount.setCount(cartInfoMapper.selectMyCartTotal(cart));
		return resultCount;
	}
	
	public CartInfoVO selectCart(int ciNum) {
		return cartInfoMapper.selectCart(ciNum);
	}
	
	public int insertCart(CartInfoVO cart) {
		return cartInfoMapper.insertCart(cart);
	}
	
	public int updateCart(CartInfoVO cart) {
		return cartInfoMapper.updateCart(cart);
	}
	
	public int deleteCart(int ciNum) {
		return cartInfoMapper.deleteCart(ciNum);
	}
}
