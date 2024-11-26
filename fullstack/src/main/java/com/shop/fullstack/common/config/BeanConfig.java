package com.shop.fullstack.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.siot.IamportRestClient.IamportClient;


@Configuration
public class BeanConfig {
	@Value("${pay.imp-key}")
	private String payKey;
	@Value("${pay.imp-secret}")
	private String paySecret;
	
	@Bean
	IamportClient iamportClient() {
		return new IamportClient(payKey, paySecret);
	}
}
