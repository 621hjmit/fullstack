package com.shop.fullstack.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.user.vo.NewsletterInfoVO;
import com.shop.fullstack.user.vo.UserInfoVO;
@Mapper
public interface NewsletterMapper {
    int insertSubscriber(NewsletterInfoVO subscriber);
    int updateSubscription(UserInfoVO userInfoVO);//유저 번호랑 uiNews가져온다.
    int checkEmail(NewsletterInfoVO newsletter);
    int subscribeAsGuest(NewsletterInfoVO newsletter);
    int unsubscribeAsGuest(NewsletterInfoVO newsletter);
}
