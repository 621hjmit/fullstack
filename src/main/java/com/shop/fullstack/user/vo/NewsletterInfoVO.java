package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NewsletterInfoVO {
    private int unNum;
    private String unEmail;
    private String unSubscriptionDate;
    private String unStatus;
    private String unUnsubscribeDate;
    private String unSource;
    private String unLastName;
    private String unFirstName;
    private int uiNum;
    private String unStartDate;
    private String unEndDate;
    private String uiPhone;
    private int start;
    private int count;
    private int page;
}
