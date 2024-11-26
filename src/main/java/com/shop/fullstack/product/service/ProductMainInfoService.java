package com.shop.fullstack.product.service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ProductMainInfoMapper;
import com.shop.fullstack.product.vo.ProductMainInfoVO;

@Service
public class ProductMainInfoService {
	 @Autowired
	    ProductMainInfoMapper productMainInfoMapper;
	    
	    public List<ProductMainInfoVO> selectProductMainInfos() {
	        return productMainInfoMapper.selectProductMainInfos();
	    }

	    public List<ProductMainInfoVO> selectProductMainInfoByProductId(int piId) {
	        return productMainInfoMapper.selectProductMainInfoByProductId(piId);
	    }

	    public int insertProductMainInfo(ProductMainInfoVO productMainInfo) {
	        return productMainInfoMapper.insertProductMainInfo(productMainInfo);
	    }

	    @Transactional
	    public int updateProductMainInfo(int piId, List<ProductMainInfoVO> mainInfoList) {
	        int affectedRows = 0;

	        // 기존 주요 정보 조회
	        List<ProductMainInfoVO> currentMainInfos = productMainInfoMapper.selectProductMainInfoByProductId(piId);

	        // 업데이트 또는 삽입
	        for (ProductMainInfoVO mainInfo : mainInfoList) {
	            if (mainInfo.getPmiId() != null && mainInfo.getPmiId() > 0) {
	                // 기존 데이터가 있다면 업데이트
	                affectedRows += productMainInfoMapper.updateProductMainInfo(mainInfo);
	            } else {
	                // 새롭게 추가된 데이터라면 삽입
	                mainInfo.setPiId(piId);
	                affectedRows += productMainInfoMapper.insertProductMainInfo(mainInfo);
	            }
	        }

	        // 기존 주요 정보 중 현재 리스트에 없는 것은 삭제
	        for (ProductMainInfoVO currentInfo : currentMainInfos) {
	            boolean exists = mainInfoList.stream().anyMatch(info -> info.getPmiId() != null && info.getPmiId().equals(currentInfo.getPmiId()));
	            if (!exists) {
	                affectedRows += productMainInfoMapper.deleteProductMainInfoById(currentInfo.getPmiId());
	            }
	        }

	        return affectedRows;
	    }

	    public int deleteProductMainInfo(int pmiId) {
	        return productMainInfoMapper.deleteProductMainInfoById(pmiId);
	    }
	 // 주요 정보 저장
	    public int addProductMainInfo(ProductMainInfoVO mainInfoVO) {
	        return productMainInfoMapper.insertProductMainInfo(mainInfoVO);
	    }
}
