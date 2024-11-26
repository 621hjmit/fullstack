package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.fullstack.product.service.ProductService;
import com.shop.fullstack.product.vo.ProductVO;

@Controller
public class ProductPageController {
	@Autowired
    private ProductService productService;

    @GetMapping("/productList")
    public String showProductList(Model model) {
        List<ProductVO> products = productService.selectProducts(new ProductVO());
        model.addAttribute("products", products);
        return "/views/product/list"; // list.jsp 페이지로 이동
    }
}
