package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.DeliveryComInfoMapper;
import com.shop.fullstack.order.vo.DeliverycomInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DeliveryComInfoService {

	
	@Autowired
	private DeliveryComInfoMapper deliveryComInfoMapper;
	
	public List<DeliverycomInfoVO> selectDeliveryComs(DeliverycomInfoVO deliveryCom){
		return deliveryComInfoMapper.selectDeliveryComs(deliveryCom);
	}
	
	public DeliverycomInfoVO selectDeliveryCom(int dciNum) {
		return deliveryComInfoMapper.selectDeliveryCom(dciNum);
	}
	
	public int insertDeliveryCom(DeliverycomInfoVO deliveryCom) {
		return deliveryComInfoMapper.insertDeliveryCom(deliveryCom);
	}
	
	public int updateDeliveryCom(DeliverycomInfoVO deliveryCom) {
		return deliveryComInfoMapper.updateDeliveryCom(deliveryCom);
	}
	
	public int deleteDeliveryCom(int dciNum) {
		return deliveryComInfoMapper.deleteDeliveryCom(dciNum);
	}
	
	public int saveDeliveryComs(List<DeliverycomInfoVO> deliveryComs){
		int result = 0;
		for(DeliverycomInfoVO deliveryCom:deliveryComs) {
			if(deliveryCom.getDciNum()==0) {
				result += deliveryComInfoMapper.insertDeliveryCom(deliveryCom);
			}else {
				result += deliveryComInfoMapper.updateDeliveryCom(deliveryCom);
			}
		}
		int tempResult = deliveryComInfoMapper.selectRowCount();
		log.info("result=>{}", result);
		log.info("tempResult=>{}", tempResult);
		if(deliveryComs.size() != result) {
			throw new RuntimeException("오류가 발생하였습니다.");
		}
		return result;
	}
	
	public int deleteDeliveryComs(List<Integer> dciNums) {
		int result = 0;
		for(int dciNum:dciNums) {
			result += deliveryComInfoMapper.deleteDeliveryCom(dciNum);
		}
		return result;
	}
}
