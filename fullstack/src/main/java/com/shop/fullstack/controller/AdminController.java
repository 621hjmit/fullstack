package com.shop.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	@GetMapping("/admin")
	public String goAdminIndex() {
		return "admin/order/order-dashboard";
	}
	@GetMapping("/admin/**")
	public void goAdmin() {}
	
}