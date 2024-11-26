package com.shop.fullstack.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.category.vo.CategoryVO;

@Mapper
public interface DetailCategoryMapper {
    List<CategoryVO> selectAllDetailCategories(); // 매개변수 제거
    CategoryVO selectDetailCategory(int dcId);
    List<CategoryVO> findBySubCategoryId(int subCategoryId);
    int insertDetailCategory(CategoryVO detailCategory);
    int updateDetailCategory(CategoryVO detailCategory);
    int deleteDetailCategory(int dcId);
}