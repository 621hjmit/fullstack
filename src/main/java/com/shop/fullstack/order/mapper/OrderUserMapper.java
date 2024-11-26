package com.shop.fullstack.order.mapper;

import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

public interface OrderUserMapper {

	UserInfoVO selectOrderUser(UserInfoVO orderUser);
	AddressInfoVO selectOrderAddr(AddressInfoVO orderAddr);
}
