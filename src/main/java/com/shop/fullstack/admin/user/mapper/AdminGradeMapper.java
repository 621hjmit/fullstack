package com.shop.fullstack.admin.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.fullstack.user.vo.GradeInfoVO;

public interface AdminGradeMapper {
  public List<GradeInfoVO> getGrade();
  public List<GradeInfoVO> getGradesName();
  public int insertGrade(GradeInfoVO gradeInfoVO);
  int deleteGrades(@Param("giNums") List<Integer> giNums);
  int updateGrades(@Param("grades") List<GradeInfoVO> grades);
}
