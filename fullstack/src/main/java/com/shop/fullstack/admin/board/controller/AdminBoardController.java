package com.shop.fullstack.admin.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.board.service.AdminBoardService;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.BoardInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AdminBoardController {
  @Autowired
  private AdminBoardService
  adminBoardService;
  
  @PostMapping("/boards")
  public ResultCountVO<BoardInfoVO> getBoards(@RequestBody BoardInfoVO boardInfoVO) {
    log.info("넘어온 보드:"+boardInfoVO);
    return adminBoardService.getBoards(boardInfoVO);
  }
  
  @PostMapping("/adminboard")
  public BoardInfoVO getPostBody(@RequestBody BoardInfoVO board) {
    log.info("board: "+board);
    return adminBoardService.getPostBody(board);
  }

  @PostMapping("/adminboard2")
  public int savePostBody(@RequestBody BoardInfoVO board) {
    //log.info("board.getUiNum: "+board.getUiNum());
    return adminBoardService.insertPostBody(board);
  }
  
  @PostMapping("/adminboard3")
  public BoardInfoVO getReplyMessage(@RequestBody BoardInfoVO board) {
    return adminBoardService.getReplyMessage(board);
  }

  @PutMapping("/adminboard2/{ubNum}")
  public int deleteReply(@PathVariable String ubNum) {
    log.info("Received ubNum => {}", ubNum); // 값 확인용 로그
    try {
        Integer id = Integer.parseInt(ubNum); // 변환 테스트
        return adminBoardService.deleteReply(id);
    } catch (NumberFormatException e) {
        log.error("Invalid ubNum format: {}", ubNum, e);
        throw e;
    }
  }
  
  @PutMapping("/adminboard3")
  public int updateReply(@RequestBody BoardInfoVO board) {
    log.info("Received board => {}", board); // 값 확인용 로그
    return adminBoardService.updateReply(board);
  }
  

  @DeleteMapping("/adminboard")
  public int deletePosts(@RequestBody List<BoardInfoVO> boards) {
    log.info("Received board => {}", boards); // 값 확인용 로그
    return adminBoardService.deletePosts(boards);
  }
}
