package com.shop.fullstack.admin.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shop.fullstack.user.vo.NewsletterInfoVO;

@Mapper
public interface AdminNewsletterMapper {
    List<NewsletterInfoVO> getAllSubscribers(NewsletterInfoVO userNewsletterVO);
    int getAllSubscribersTotal(NewsletterInfoVO userNewsletterVO);
    int addSubscriber(NewsletterInfoVO subscriber);
    int deleteSubscriber(NewsletterInfoVO subscriber);
}
