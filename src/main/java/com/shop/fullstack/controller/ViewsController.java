package com.shop.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewsController {
	@GetMapping("/")
	public String home() {
		return "views/index";
	}

	@GetMapping("/views/**")
	public void goPage() {
	}

}