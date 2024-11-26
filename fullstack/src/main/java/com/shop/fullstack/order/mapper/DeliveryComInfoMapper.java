package com.shop.fullstack.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.order.vo.DeliverycomInfoVO;

public interface DeliveryComInfoMapper {

	
	List<DeliverycomInfoVO> selectDeliveryComs(DeliverycomInfoVO deliveryCom);
	DeliverycomInfoVO selectDeliveryCom(int dciNum);
	int insertDeliveryCom(DeliverycomInfoVO deliveryCom);
	int updateDeliveryCom(DeliverycomInfoVO deliveryCom);
	int deleteDeliveryCom(int dciNum);
	
	int insertDeliveryComs(@Param("deliveryComs")List<DeliverycomInfoVO> deliveryComs);
	int updateDeliveryComs(@Param("deliveryComs")List<DeliverycomInfoVO> deliveryComs);
	int selectRowCount();
}
