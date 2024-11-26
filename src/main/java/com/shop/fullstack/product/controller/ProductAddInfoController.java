package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductAddInfoService;
import com.shop.fullstack.product.vo.ProductAddInfoVO;

@RestController
public class ProductAddInfoController {

	@Autowired
	ProductAddInfoService productAddInfoService;
	
	@GetMapping("/productAddInfo")
	public List<ProductAddInfoVO> getProductAddInfos(@RequestParam int paiId){
		return productAddInfoService.selectProductAddInfos(paiId);
	}
	
	@PostMapping("/productAddInfo")
	public int addProductAddInfo(@RequestBody ProductAddInfoVO productAddInfo){
		return productAddInfoService.insertProductAddInfo(productAddInfo);
	}
	
	@PutMapping("/productAddInfo")
	public int modifyProductAddInfo(@RequestBody ProductAddInfoVO productAddInfo) {
		return productAddInfoService.updateProductAddInfo(productAddInfo);
	}
	
	@DeleteMapping("/productAddInfo")
	public int removeProductAddInfo(int paiId) {
		return productAddInfoService.deleteProductAddInfo(paiId);
	}
}
