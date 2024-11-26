package com.shop.fullstack.admin.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.user.mapper.AdminMemoMapper;
import com.shop.fullstack.user.vo.MemoInfoVO;

@Service
public class AdminMemoService {
    
  @Autowired
  private AdminMemoMapper adminMemoMapper;
  
  public int saveMemo(MemoInfoVO memo){
    return adminMemoMapper.saveMemo(memo);
  }
  public int updateMemo(MemoInfoVO memo){
      return adminMemoMapper.updateMemo(memo);
  }
  public MemoInfoVO readRecentOneMemo(MemoInfoVO memo){
      return adminMemoMapper.readRecentOneMemo(memo);
  }
  public int deleteMemo(MemoInfoVO memo) {
    return adminMemoMapper.deleteMemo(memo);
  }
}
