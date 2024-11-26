package com.shop.fullstack.category.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.category.service.SubCategoryService;
import com.shop.fullstack.category.vo.CategoryVO;

@RestController
public class SubCategoryController {

    @Autowired
    private SubCategoryService subCategoryService;

    // 모든 서브 카테고리 조회
    @GetMapping("/subCategories")
    public List<CategoryVO> getSubCategories() {
        return subCategoryService.selectAllSubCategories();
    }

    // 특정 서브 카테고리 조회
    @GetMapping("/subCategories/{subCategoryId}")
    public ResponseEntity<CategoryVO> getSubCategory(@PathVariable int subCategoryId) {
        CategoryVO subCategory = subCategoryService.selectSubCategory(subCategoryId);
        if (subCategory != null) {
            return ResponseEntity.ok(subCategory);
        } else {
            return ResponseEntity.notFound().build(); // 서브 카테고리가 없을 경우 404 응답
        }
    }
    
    // 메인 카테고리 ID로 서브 카테고리 조회
    @GetMapping("/mainSubCategories")
    public List<CategoryVO> getSubCategoriesByMainCategoryId(@RequestParam int mainCategoryId) {
        return subCategoryService.findByMainCategoryId(mainCategoryId);
    }

    @PostMapping("/subCategories")
    public ResponseEntity<Integer> addSubCategory(@RequestBody CategoryVO newSubCategory) {
        
        if (newSubCategory.getForeignMainCategoryId() == null) {
            System.out.println("foreignMainCategoryId is null");
            return ResponseEntity.badRequest().body(null); // Bad Request 응답
        }

        // 서브 카테고리 추가
        int result = subCategoryService.insertSubCategory(newSubCategory);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    // 서브 카테고리 수정
    @PutMapping("/subCategories/{subCategoryId}")
    public ResponseEntity<Integer> updateSubCategory(@PathVariable int subCategoryId, @RequestBody CategoryVO subCategory) {
        subCategory.setSubCategoryId(subCategoryId); // ID를 서브 카테고리 객체에 설정
        int result = subCategoryService.updateSubCategory(subCategory);
        return ResponseEntity.ok(result);
    }

    // 서브 카테고리 삭제
    @DeleteMapping("/subCategories/{subCategoryId}")
    public ResponseEntity<Void> deleteSubCategory(@PathVariable int subCategoryId) {
        int result = subCategoryService.deleteSubCategory(subCategoryId);
        if (result > 0) {
            return ResponseEntity.noContent().build(); // 204 No Content 응답
        } else {
            return ResponseEntity.notFound().build(); // 서브 카테고리가 없을 경우 404 응답
        }
    }
}


