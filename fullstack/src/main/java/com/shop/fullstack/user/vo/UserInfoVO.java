package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserInfoVO {
    private int uiNum;
    private String uiFirstName;
    private String uiLastName;
    private String uiEmail;
    private String uiCountryCode;
    private String uiPhone;
    private String uiPwd;
    private String uiGender;
    private String uiBirth;
    private String uiDormant;
    private String dormdat;
    private String uiOut;
    private String outdat;
    private String uiType;
    private int    uiNews;
    private String credat;
    private String cretim;
    private String umMemo;
    private int    giNum;
    private String giName;
    private int start;
    private int count;
    private int page;
    
    private int orNum;
    private String orCredat;
    private int orAmount;
    private int orCount;
    private String orId;
    private String orRank;
    
    private String aiPlaceName, aiRecipentName, aiZipcode, aiAddress1, aiAddress2,aiCountryCode,aiPhone;
    private String uiStartDate, uiEndDate, rowNumber;

    private String otNum;
    private String uiFullname;
    
}
