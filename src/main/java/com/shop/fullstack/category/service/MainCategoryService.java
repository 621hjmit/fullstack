package com.shop.fullstack.category.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.category.mapper.MainCategoryMapper;
import com.shop.fullstack.category.vo.CategoryVO;

@Service
public class MainCategoryService {
	
	@Autowired
	private MainCategoryMapper mainCategoryMapper;
	
	public List<CategoryVO> selectAllMainCategories(){
		return mainCategoryMapper.selectAllMainCategories();
	}
	public List<CategoryVO> selectAllCategoriesWithSubCategories() {
	    return mainCategoryMapper.selectAllMainCategoriesWithSubCategories();
	}
	public CategoryVO selectMainCategory(int mcId) {
		return mainCategoryMapper.selectMainCategory(mcId);
	}
	public int insertMainCategory(CategoryVO mainCategory) {
		return mainCategoryMapper.insertMainCategory(mainCategory);
	}
	public int updateMainCategory(CategoryVO mainCategory) {
        // 입력된 ID와 카테고리 이름을 로그로 출력
        System.out.println("Updating category with ID: " + mainCategory.getMainCategoryId());

        String categoryName = mainCategory.getMainCategoryName();
        if (categoryName == null || categoryName.trim().isEmpty()) {
            System.out.println("mainCategoryName is null or empty!");
            return 0; // 또는 예외 처리
        }

        System.out.println("New category name: " + categoryName);

        // 데이터베이스 업데이트 수행
        int result = mainCategoryMapper.updateMainCategory(mainCategory.getMainCategoryId(), categoryName);

        // 업데이트 결과 로그
        System.out.println("Update result: " + result);

        return result;
    }
	
	public int deleteMainCategory(int mcId) {
		return mainCategoryMapper.deleteMainCategory(mcId);
	}
}
