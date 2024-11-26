package com.shop.fullstack.common.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResultListVO<T> {
	private List<T> list;
	private int count;
}
