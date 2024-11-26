package com.shop.fullstack.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.user.service.BoardInfoService;
import com.shop.fullstack.user.vo.BoardInfoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class BoardInfoController {
    
    @Autowired
    private BoardInfoService boardInfoService;
    
    @PostMapping("/contact")
    public int insertContact(@RequestBody BoardInfoVO board) {
      log.info("board: "+board);
      return boardInfoService.insertContact(board);
    }
    
    @PostMapping("/board-contact")
    public List<BoardInfoVO> selectContacts(@RequestBody BoardInfoVO board) {
      log.info("board.getUiNum: "+board.getUiNum());
      return boardInfoService.selectContacts(board.getUiNum());
    }
    @GetMapping("/user-contact")
    public List<BoardInfoVO> getContactSubjectList () {
      return boardInfoService.getContactSubjectList();
    }
    
    @PutMapping("/contact")
    public int updateContact(@RequestBody BoardInfoVO board) {
      return boardInfoService.updateContact(board);
    }
    
    @PostMapping("/board-contact2")
    public int deleteContacts(@RequestBody List<BoardInfoVO> boards) {
      return boardInfoService.deleteContacts(boards);
    }
    
    @PostMapping("/board-contact-view")
    public BoardInfoVO getOneContact(@RequestBody BoardInfoVO board) {
      return boardInfoService.getOneContact(board);
    }
    
    @DeleteMapping("/board-contact/{ubNum}")
    public int deleteContact(@PathVariable int ubNum) {
      return boardInfoService.deleteContact(ubNum);
    }
}