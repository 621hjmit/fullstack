package com.shop.fullstack.admin.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.shop.fullstack.user.vo.OutTypeInfoVO;

@Mapper
public interface OutInfoMapper {
	public List<OutTypeInfoVO> getOutTypeInfos();
}
