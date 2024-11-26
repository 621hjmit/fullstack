package com.shop.fullstack.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.order.mapper.OrdersMapper;
import com.shop.fullstack.order.mapper.PaymentInfoMapper;
import com.shop.fullstack.order.vo.OrdersVO;
import com.shop.fullstack.order.vo.PaymentInfoVO;

@Service
public class PaymentInfoService {
	
	@Autowired
	private PaymentInfoMapper paymentInfoMapper;
	
	@Autowired
	private OrdersMapper ordersMapper;
	
	public List<PaymentInfoVO> selectPayinfos(PaymentInfoVO payinfo){
		return paymentInfoMapper.selectPayinfos(payinfo);
	}
	public PaymentInfoVO selectPayinfo(int paiNum) {
		return paymentInfoMapper.selectPayinfo(paiNum);
	}
	public int insertPayinfo(PaymentInfoVO payinfo) {
		int result = 0;
		payinfo.setPayMethod("Card");
		result += paymentInfoMapper.insertPayinfo(payinfo);
		OrdersVO order = new OrdersVO();
		order.setPayNum(payinfo.getPayNum());
		order.setPayName(payinfo.getPayName());
		order.setPayMethod(payinfo.getPayMethod());
		order.setOrStatusPay("결제완료");
		order.setOrId(payinfo.getOrId());
		result += ordersMapper.updateOrderPay(order);
		return result;
	}
	public int updatePayinfo(PaymentInfoVO payinfo) {
		return paymentInfoMapper.updatePayinfo(payinfo);
	}
	public int deletePayinfo(int paiNum) {
		return paymentInfoMapper.deletePayinfo(paiNum);
	}
}

