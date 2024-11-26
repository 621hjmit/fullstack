package com.shop.fullstack.user.dto;

import com.shop.fullstack.user.vo.AddressInfoVO;
import com.shop.fullstack.user.vo.NewsletterInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CombinedRequestDto {
    private UserInfoVO user;
    private AddressInfoVO address;
    private NewsletterInfoVO newsletter;
}