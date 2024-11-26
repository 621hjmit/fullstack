package com.shop.fullstack.admin.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.user.mapper.OutInfoMapper;
import com.shop.fullstack.user.vo.OutTypeInfoVO;

@Service
public class OutInfoService {
	@Autowired
	private OutInfoMapper outInfoMapper;
	
	public List<OutTypeInfoVO> getOutTypeInfos(){
		return outInfoMapper.getOutTypeInfos();
	}
}
