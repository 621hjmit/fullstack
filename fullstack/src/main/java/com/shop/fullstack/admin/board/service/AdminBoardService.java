package com.shop.fullstack.admin.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.board.mapper.AdminBoardMapper;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.BoardInfoVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class AdminBoardService {
    @Autowired
    private AdminBoardMapper adminBoardMapper;

    public ResultCountVO<BoardInfoVO> getBoards(BoardInfoVO boardInfoVO){
      log.info("boardInfoVO: "+boardInfoVO);
      if(boardInfoVO.getCount()==0) {
        boardInfoVO.setCount(10);;
      }
      if(boardInfoVO.getPage()!=0) {
        int start = (boardInfoVO.getPage()-1) * boardInfoVO.getCount();
        boardInfoVO.setStart(start);
      }
      ResultCountVO rcv = new ResultCountVO();
      rcv.setCount(adminBoardMapper.getBoardsTotal());
      rcv.setList(adminBoardMapper.getBoards(boardInfoVO));
      rcv.setResultCount(adminBoardMapper.getResultCount(boardInfoVO));
      return rcv;
    }

    public BoardInfoVO getPostBody(BoardInfoVO board) {
      return adminBoardMapper.getPostBody(board);
    }
    public BoardInfoVO getReplyMessage(BoardInfoVO board) {
      return adminBoardMapper.getReplyMessage(board);
    }
    
    public int insertPostBody(BoardInfoVO board) {
      return adminBoardMapper.insertPostBody(board);
    }

    public int deleteReply(int num) {
      return adminBoardMapper.deleteReply(num);
    }
    public int updateReply(BoardInfoVO board) {
      return adminBoardMapper.updateReply(board);
    }
    
    public int deletePosts(List<BoardInfoVO> boards) {
      int result = 0;
      for(BoardInfoVO board:boards) {
        result += adminBoardMapper.deletePost(board); //0
      }
      if(boards.size() != result) {
        throw new RuntimeException("오류가 발생하였습니다.");
      }
      return result;
    }
    
}
