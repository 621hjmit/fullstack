package com.shop.fullstack.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.order.vo.DeliveryInfoVO;

@Mapper
public interface DeliveryInfoMapper {
	
	
	List<DeliveryInfoVO> selectDeliveryInfos(DeliveryInfoVO deliveryInfo);
	DeliveryInfoVO selectDeliveryInfo(int deiNum);
	int insertDeliveryInfo(DeliveryInfoVO deliveryInfo);
	int updateDeliveryInfo(DeliveryInfoVO deliveryInfo);
	int deleteDeliveryInfo(int deiNum);

}
