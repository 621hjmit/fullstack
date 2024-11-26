package com.shop.fullstack.admin.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.shop.fullstack.user.vo.MemoInfoVO;

@Mapper
public interface AdminMemoMapper {
    public int saveMemo(MemoInfoVO memo);
    public MemoInfoVO readRecentOneMemo(MemoInfoVO memo);
    public int updateMemo(MemoInfoVO memo);
    public int deleteMemo(MemoInfoVO memo) ;
}
