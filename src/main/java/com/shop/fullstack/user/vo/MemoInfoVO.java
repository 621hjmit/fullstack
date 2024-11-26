package com.shop.fullstack.user.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemoInfoVO {
    private Integer umNum;
    private Integer uiNum;
    private String umMemo;
    private String umCreatedAt;
    private String umMemoStatus;
}
