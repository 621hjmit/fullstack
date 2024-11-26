package com.shop.fullstack.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.category.service.DetailCategoryService;
import com.shop.fullstack.category.vo.CategoryVO;

@RestController
public class DetailCategoryController {
	
	@Autowired
	private DetailCategoryService detailCategoryService;

	@GetMapping("/detailCategories")
	public List<CategoryVO> getDetailCategories() {
		List<CategoryVO> detailCategories = detailCategoryService.selectAllDetailCategories();
		return detailCategories;
	}

	@GetMapping("/detailCategories/{detailCategoryId}")
	public CategoryVO getDetailCategory(@PathVariable int detailCategoryId) {
		CategoryVO detailCategory = detailCategoryService.selectDetailCategory(detailCategoryId);
		return detailCategory;
	}
	
	// 메인 카테고리 ID로 서브 카테고리 조회
    @GetMapping("/subDetailCategories")
    public List<CategoryVO> getDetailCategoriesBySubCategoryId(@RequestParam int subCategoryId) {
        return detailCategoryService.findBySubCategoryId(subCategoryId);
    }

	@PostMapping("/detailCategories")
	public int insertDetailCategory(@RequestBody CategoryVO detailCategory) {
		int result = detailCategoryService.insertDetailCategory(detailCategory);
		return result;
	}

	@PutMapping("/detailCategories/{detailCategoryId}")
	public int updateDetailCategory(@PathVariable int detailCategoryId, @RequestBody CategoryVO detailCategory) {
		int result = detailCategoryService.updateDetailCategory(detailCategory);
		System.out.println(detailCategory);
		return result;
	}
	
	@DeleteMapping("/detailCategories/{detailCategoryId}")
    public int deleteDetailCategory(@PathVariable int detailCategoryId) {
        int result = detailCategoryService.deleteDetailCategory(detailCategoryId);
        return result;
	}
}
