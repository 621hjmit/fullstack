package com.shop.fullstack.category.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.category.vo.CategoryVO;

@Mapper
public interface MainCategoryMapper {
    List<CategoryVO> selectAllMainCategories();
    List<CategoryVO> selectAllMainCategoriesWithSubCategories();
    CategoryVO selectMainCategory(int mcId);
    int insertMainCategory(CategoryVO mainCategory);
    int updateMainCategory(@Param("mainCategoryId") Integer mainCategoryId, @Param("mainCategoryName") String mainCategoryName);
    int deleteMainCategory(int mcId);
}