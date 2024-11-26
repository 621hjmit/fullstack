package com.shop.fullstack.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.category.mapper.SubCategoryMapper;
import com.shop.fullstack.category.vo.CategoryVO;

@Service
public class SubCategoryService {

	@Autowired
	private SubCategoryMapper subCategoryMapper;

	public List<CategoryVO> selectAllSubCategories() {
		return subCategoryMapper.selectAllSubCategories();
	}

	public CategoryVO selectSubCategory(int scId) {
		return subCategoryMapper.selectSubCategory(scId);
	}

	public List<CategoryVO> findByMainCategoryId(int mainCategoryId) {
		return subCategoryMapper.findByMainCategoryId(mainCategoryId);
	}

	public int insertSubCategory(CategoryVO subCategory) {
	    return subCategoryMapper.insertSubCategory(subCategory);
	}

	public int updateSubCategory(CategoryVO subCategory) {
		return subCategoryMapper.updateSubCategory(subCategory);
	}

	public int deleteSubCategory(int scId) {
		return subCategoryMapper.deleteSubCategory(scId);
	}
}
