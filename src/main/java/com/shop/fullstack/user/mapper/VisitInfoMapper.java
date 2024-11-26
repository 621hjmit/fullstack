package com.shop.fullstack.user.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.shop.fullstack.user.vo.VisitInfoVO;

@Mapper
public interface VisitInfoMapper {
    
    public int insertVisit(VisitInfoVO visitInfoVO);
    
    
    public List<VisitInfoVO> selectVisits(VisitInfoVO visitInfoVO);
    public VisitInfoVO selectVisit(VisitInfoVO visitInfoVO);
    public int updateVisit(VisitInfoVO visitInfoVO);
    
    public int deleteVisit(int uiNum);
}
