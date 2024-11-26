package com.shop.fullstack.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.order.vo.CardcomInfoVO;

public interface CardComInfoMapper {
	
	
	List<CardcomInfoVO> selectCardcoms(CardcomInfoVO cardcom);
	CardcomInfoVO selectCardcom(int cciNum);
	int insertCardcom(CardcomInfoVO cardcom);
	int updateCardcom(CardcomInfoVO cardcom);
	int deleteCardcom(int cciNum);
	
	int insertCardComs(@Param("cardComs")List<CardcomInfoVO> cardComs);
	int updateCardComs(@Param("cardComs")List<CardcomInfoVO> cardComs);
	int selectRowCount();
}
