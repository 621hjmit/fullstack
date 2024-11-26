package com.shop.fullstack.admin.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import com.shop.fullstack.user.vo.BoardInfoVO;

@Mapper
public interface AdminBoardMapper {
    public List<BoardInfoVO> getBoards(BoardInfoVO board);
    public int getResultCount(BoardInfoVO board);
    public int getBoardsTotal();
    public BoardInfoVO getPostBody(BoardInfoVO board);
    public BoardInfoVO getReplyMessage(BoardInfoVO board);
    public int insertPostBody(BoardInfoVO board);
    public int deleteReply(@Param("ubNum") int ubNum);
    public int updateReply(BoardInfoVO board);
    public int deletePost(BoardInfoVO board);
}
