package com.shop.fullstack.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminGradeService;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.GradeInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
public class AdminGradeController {
  
  @Autowired
  AdminGradeService adminGradeService;

  @GetMapping("/grade")
  public List<GradeInfoVO> getGrade() {
     return adminGradeService.getGrade();
  }
  
  //이름만 뽑아오는 쿼리
  @GetMapping("/grades")
  public List<GradeInfoVO> getGradesName() {
      return adminGradeService.getGradesName();
  }
  
  @PostMapping("/grade")
  public int addGrade(@RequestBody GradeInfoVO gradeInfoVO) {
    return adminGradeService.insertGrade(gradeInfoVO);
  }

  @DeleteMapping("/grades")
  public int deleteGrades(@RequestBody List<Integer> grades) {
    return adminGradeService.deleteGrades(grades);
  }
  
  

}
