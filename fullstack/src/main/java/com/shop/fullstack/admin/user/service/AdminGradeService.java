package com.shop.fullstack.admin.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

import com.shop.fullstack.admin.user.mapper.AdminGradeMapper;
import com.shop.fullstack.user.vo.GradeInfoVO;
@Service
public class AdminGradeService {
  @Autowired
  AdminGradeMapper adminGradeMapper;
  
  public List<GradeInfoVO> getGradesName() {
      return adminGradeMapper.getGradesName();
    }
  public List<GradeInfoVO> getGrade() {
    return adminGradeMapper.getGrade();
  }
  public int insertGrade(GradeInfoVO gradeInfoVO) {
    return adminGradeMapper.insertGrade(gradeInfoVO);
  }
  public int deleteGrades(List<Integer> giNums) {
    if (giNums == null || giNums.isEmpty()) {
      return 0;
    }
    return adminGradeMapper.deleteGrades(giNums);
  };
  public int updateGrades(List<GradeInfoVO> grades) {
    return adminGradeMapper.updateGrades(grades);
  };
  
}
