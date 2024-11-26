package com.shop.fullstack.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.category.service.MainCategoryService;
import com.shop.fullstack.category.vo.CategoryVO;

@RestController
public class MainCategoryController {

	@Autowired
	private MainCategoryService mainCategoryService;
	
	@GetMapping("/mainCategories")
	public List<CategoryVO> getMainCategories() {
		List<CategoryVO> mainCategories = mainCategoryService.selectAllMainCategories();
		return mainCategories;
	}
	
	@GetMapping("/views/categoriesPage") // 전체 카테고리
    public List<CategoryVO> showCategories(Model model) {
        List<CategoryVO> mainCategories = mainCategoryService.selectAllCategoriesWithSubCategories();
        model.addAttribute("mainCategories", mainCategories);
        return mainCategories; 
    }

	@GetMapping("/mainCategories/{mainCategoryId}")
	public CategoryVO getMainCategory(@PathVariable int mainCategoryId) {
		CategoryVO mainCategory = mainCategoryService.selectMainCategory(mainCategoryId);
		return mainCategory;
	}

	@PostMapping("/mainCategories")
	public int insertMainCategory(@RequestBody CategoryVO mainCategory) {
		int result = mainCategoryService.insertMainCategory(mainCategory);
		return result;
	}

	 @PutMapping("/mainCategories/{mainCategoryId}")
	    public ResponseEntity<?> updateMainCategory(@PathVariable Integer mainCategoryId, @RequestBody CategoryVO mainCategory) {
	        mainCategory.setMainCategoryId(mainCategoryId); // PathVariable로 받은 ID 설정
	        int result = mainCategoryService.updateMainCategory(mainCategory);
	        return ResponseEntity.ok(result);
	    }
	
	@DeleteMapping("/mainCategories/{mainCategoryId}")
    public int deleteMainCategory(@PathVariable int mainCategoryId) {
        int result = mainCategoryService.deleteMainCategory(mainCategoryId);
        return result;
	}
}
