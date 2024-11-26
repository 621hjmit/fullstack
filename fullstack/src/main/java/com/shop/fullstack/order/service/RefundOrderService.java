package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.RefundOrderMapper;
import com.shop.fullstack.order.vo.RefundOrderVO;

@Service
public class RefundOrderService {

	
	@Autowired
	private RefundOrderMapper refundOrderMapper;
	
	public List<RefundOrderVO> selectRefundOrders(RefundOrderVO refundOrder){
		return refundOrderMapper.selectRefundOrders(refundOrder);
	}
	public RefundOrderVO selectRefundOrder(int rfoNum) {
		return refundOrderMapper.selectRefundOrder(rfoNum);
	}
	public int insertRefundOrder(RefundOrderVO refundOrder) {
		return refundOrderMapper.insertRefundOrder(refundOrder);
	}
	public int updateRefundOrder(RefundOrderVO refundOrder) {
		return refundOrderMapper.updateRefundOrder(refundOrder);
	}
	public int deleteRefundOrder(int rfoNum) {
		return refundOrderMapper.deleteRefundOrder(rfoNum);
	}
}
