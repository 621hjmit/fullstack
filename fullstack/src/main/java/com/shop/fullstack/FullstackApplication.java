package com.shop.fullstack;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan
public class FullstackApplication {
  public static void main(String[] args) {
    SpringApplication.run(FullstackApplication.class, args);
  }
}
