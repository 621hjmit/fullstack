package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardInfoVO {
    private Integer ubNum;
    private String ubFirstName;
    private String ubLastName;
    
    private String uiFirstName;
    private String uiLastName;
    
    private String ubEmail;
    private String ubCountryCode;
    private String ubPhone;
    private String ucNum;
    private String ucTitle;
    private String ubTitle;
    private String ubMessage;
    private String ubCredat;
    private String ubReplyCredat;
    private String ubReply;
    private String ubReplyMessage;
    private Integer uiNum;
    private Integer ubRowNumber;
    private int start;
    private int count;
    private int page;
    private int resultCont;
    private String ubStartDate;
    private String ubEndDate;
}
