package com.shop.fullstack.user.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.user.mapper.NewsletterMapper;
import com.shop.fullstack.user.vo.NewsletterInfoVO;

@Service
public class NewsletterService {
  @Autowired
  private NewsletterMapper newsletterMapper;
   
  public int checkEmail(NewsletterInfoVO newsletterInfoVO){
      return newsletterMapper.checkEmail(newsletterInfoVO);
  }
  public int subscribeAsGuest(NewsletterInfoVO newsletterInfoVO){
      return newsletterMapper.subscribeAsGuest(newsletterInfoVO);
  }
  public int unsubscribeAsGuest(NewsletterInfoVO newsletterInfoVO){
      return newsletterMapper.unsubscribeAsGuest(newsletterInfoVO);
  }
}
