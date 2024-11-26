package com.shop.fullstack.user.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.user.mapper.AddressInfoMapper;
import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AddressInfoService {
    
    @Autowired
    AddressInfoMapper addressInfoMapper;
    public List<AddressInfoVO> selectAddress(UserInfoVO userVO){
        int uiNum = userVO.getUiNum();
        return addressInfoMapper.selectAddress(uiNum);
    }
    public AddressInfoVO selectAddress(AddressInfoVO addressInfoVO){
        int aiNum = addressInfoVO.getAiNum();
        return addressInfoMapper.selectOne(aiNum);
    }
    public AddressInfoVO selectOne(int aiNum){
        return addressInfoMapper.selectOne(aiNum);
    }
    
    //마이페이지에서 하나의 주소를 가져온다. 
    public AddressInfoVO selectUserAddressUiNum(UserInfoVO userVO) {
        log.info("getUiNum: "+userVO.getUiNum());
        return addressInfoMapper.selectUserAddressUiNum(userVO.getUiNum());
    }
    public int updateAddress(AddressInfoVO addressInfoVO){
        int result = 0;
        int uiNum = addressInfoVO.getUiNum();
        String defaultCheck = addressInfoVO.getAiDefault();
        if(defaultCheck.equals("1")) {
            result += addressInfoMapper.updateDefault(uiNum);
            log.info("updateDefault: "+result);
        }
        result += addressInfoMapper.updateAddress(addressInfoVO);
        log.info("updateAddress: "+result);
        return result;
    }
    public int insertAddress(AddressInfoVO addressInfoVO){
        int result = 0;
        int uiNum = addressInfoVO.getUiNum();
        String defaultCheck = addressInfoVO.getAiDefault();
        if(defaultCheck.equals("1")) {
            result += addressInfoMapper.updateDefault(uiNum);
            log.info("updateDefault: "+result);
        }
        result += addressInfoMapper.insertAddress(addressInfoVO);
        return result;
    }
    public int deleteAddress(int aiNum){
        return addressInfoMapper.deleteAddress(aiNum);
    }
}
