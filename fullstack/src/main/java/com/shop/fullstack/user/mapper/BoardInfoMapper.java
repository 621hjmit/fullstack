package com.shop.fullstack.user.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.shop.fullstack.user.vo.BoardInfoVO;

@Mapper
public interface BoardInfoMapper {
    
    public int insertContact(BoardInfoVO board);
    public List<BoardInfoVO> selectContacts(int uiNum);
    public int deleteContact(int ubNum);
    public BoardInfoVO getOneContact(BoardInfoVO board) ;
    public List<BoardInfoVO> getContactSubjectList();
    public int updateContact(BoardInfoVO board);
    
}