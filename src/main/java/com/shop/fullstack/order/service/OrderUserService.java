package com.shop.fullstack.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrderUserMapper;
import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

@Service
public class OrderUserService {

	@Autowired 
	private OrderUserMapper orderUserMapper;
	
	public UserInfoVO selectOrderUser(UserInfoVO orderUser) {
		return orderUserMapper.selectOrderUser(orderUser);
	}
	
	public AddressInfoVO selectOrderAddr(AddressInfoVO orderAddr) {
		return orderUserMapper.selectOrderAddr(orderAddr);
	}
	
}
