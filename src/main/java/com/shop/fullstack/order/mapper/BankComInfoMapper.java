package com.shop.fullstack.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.order.vo.BankcomInfoVO;


public interface BankComInfoMapper {
	
	List<BankcomInfoVO> selectBankcoms(BankcomInfoVO bankcom);
	BankcomInfoVO selectBankcom(int bciNum);
	int insertBankcom(BankcomInfoVO bankcom);
	int updateBankcom(BankcomInfoVO bankcom);
	int deleteBankcom(int bciNum);
	
	int insertBankComs(@Param("bankComs")List<BankcomInfoVO> bankComs);
	int updateBankComs(@Param("bankComs")List<BankcomInfoVO> bankComs);
	int selectRowCount();
}
