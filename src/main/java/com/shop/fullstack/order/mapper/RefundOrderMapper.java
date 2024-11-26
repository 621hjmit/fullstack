package com.shop.fullstack.order.mapper;

import java.util.List;

import com.shop.fullstack.order.vo.RefundOrderVO;

public interface RefundOrderMapper {

	
	List<RefundOrderVO> selectRefundOrders(RefundOrderVO refundOrder);
	RefundOrderVO selectRefundOrder(int rfoNum);
	int insertRefundOrder(RefundOrderVO refundOrder);
	int updateRefundOrder(RefundOrderVO refundOrder);
	int deleteRefundOrder(int rfoNum);
}
