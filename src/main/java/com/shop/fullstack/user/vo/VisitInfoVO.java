package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VisitInfoVO {
    private Integer viNum;
    private String viIp;
    private String viVisitDate;
    private Integer uiNum;
}
