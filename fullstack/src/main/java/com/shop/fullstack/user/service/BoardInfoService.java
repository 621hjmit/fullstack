package com.shop.fullstack.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.fullstack.user.mapper.BoardInfoMapper;
import com.shop.fullstack.user.vo.BoardInfoVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardInfoService {
    
  @Autowired
  private BoardInfoMapper boardInfoMapper;
  
  public int insertContact(BoardInfoVO board){
    return boardInfoMapper.insertContact(board);
  }
  
  public List<BoardInfoVO> selectContacts(int uiNum){
    return boardInfoMapper.selectContacts(uiNum);
  }
  
  public int deleteContacts(List<BoardInfoVO> boards) {
    int result = 0;
    for(BoardInfoVO board:boards) {
      log.info("board.getUbNum: "+board.getUbNum());
      result += boardInfoMapper.deleteContact(board.getUbNum()); //0
    }
    return result;
  }
  
  public BoardInfoVO getOneContact(BoardInfoVO board) {
    return boardInfoMapper.getOneContact(board);
  }
  
  public int deleteContact(int ubNum) {
    return boardInfoMapper.deleteContact(ubNum);
  }
  
  public List<BoardInfoVO> getContactSubjectList(){
    return boardInfoMapper.getContactSubjectList();
  }
  
  public int updateContact(BoardInfoVO board) {
    return boardInfoMapper.updateContact(board);
  }
}