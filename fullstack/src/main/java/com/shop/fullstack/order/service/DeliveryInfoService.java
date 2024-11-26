package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.DeliveryInfoMapper;
import com.shop.fullstack.order.vo.DeliveryInfoVO;

@Service
public class DeliveryInfoService {

	
	@Autowired
	private DeliveryInfoMapper deliveryInfoMapper;
	
	public List<DeliveryInfoVO> selectDeliveryInfos(DeliveryInfoVO deliveryInfo){
		return deliveryInfoMapper.selectDeliveryInfos(deliveryInfo);
	}
	public DeliveryInfoVO selectDeliveryInfo(int deiNum) {
		return deliveryInfoMapper.selectDeliveryInfo(deiNum);
	}
	public int insertDeliveryInfo(DeliveryInfoVO deliveryInfo) {
		return deliveryInfoMapper.insertDeliveryInfo(deliveryInfo);
	}
	public int updateDeliveryInfo(DeliveryInfoVO deliveryInfo) {
		return deliveryInfoMapper.updateDeliveryInfo(deliveryInfo);
	}
	public int deleteDeliveryInfo(int deiNum) {
		return deliveryInfoMapper.deleteDeliveryInfo(deiNum);
	}
}
