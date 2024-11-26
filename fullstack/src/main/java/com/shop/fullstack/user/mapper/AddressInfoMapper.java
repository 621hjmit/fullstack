package com.shop.fullstack.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

@Mapper
public interface AddressInfoMapper {
    public List<AddressInfoVO> selectAddress(int uiNum);
    public AddressInfoVO selectOne(int aiNum);
    public AddressInfoVO selectUserAddressUiNum(int uiNum);
    public AddressInfoVO selectUser(AddressInfoVO addressInfoVO);
    public int updateAddress(AddressInfoVO addressInfoVO);
    public int updateAddressDefault(UserInfoVO uservo);
    public int updateDefault(int uiNum);
    public int insertAddress(AddressInfoVO addressInfoVO);
    public int insertAddressAtJoin(UserInfoVO uservo);
    public int deleteAddress(int aiNum);
}
