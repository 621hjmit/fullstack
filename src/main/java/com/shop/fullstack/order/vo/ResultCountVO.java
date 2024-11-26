package com.shop.fullstack.order.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ResultCountVO<T> {

	private List<T> List;
	private int count;
	private int resultCount;
}
