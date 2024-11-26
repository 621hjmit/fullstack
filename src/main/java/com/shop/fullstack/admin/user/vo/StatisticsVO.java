package com.shop.fullstack.admin.user.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StatisticsVO {
    private String description;
    private int count;
}
