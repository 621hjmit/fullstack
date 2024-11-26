package com.shop.fullstack.admin.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminMemoService;
import com.shop.fullstack.user.vo.MemoInfoVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
public class AdminMemoController {
  @Autowired
  private AdminMemoService adminMemoService;
  
  @PostMapping("/memo")
  public int saveMemo(@RequestBody MemoInfoVO memo) {
      return adminMemoService.saveMemo(memo);
  }
  
  @PostMapping("/memo2")
  public MemoInfoVO readRecentOneMemo(@RequestBody MemoInfoVO memo) {
    log.info("readRecentOneMemo memo: "+memo);
    return adminMemoService.readRecentOneMemo(memo);
  }
  @PutMapping("/memo")
  public int updateMemo(@RequestBody MemoInfoVO memo) {
    return adminMemoService.updateMemo(memo);
  }

  @DeleteMapping("/memo")
  public int deleteMemo(@RequestBody MemoInfoVO memo) {
    return adminMemoService.deleteMemo(memo);
  }
}
