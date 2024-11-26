package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AddressInfoVO {
    private int aiNum;
    private String aiPlaceName;
    private String aiRecipentName;
    private String aiCountryCode;
    private String aiPhone;
    private String aiZipcode;
    private String aiAddress1;
    private String aiAddress2;
    private String aiDefault;
    private int uiNum;
}
