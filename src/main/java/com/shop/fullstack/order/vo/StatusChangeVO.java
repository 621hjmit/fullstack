package com.shop.fullstack.order.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StatusChangeVO<T> {

	private List<Integer> list;
	private String status;
	
}
