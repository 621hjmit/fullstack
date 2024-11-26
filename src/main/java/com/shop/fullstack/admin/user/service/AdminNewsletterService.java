package com.shop.fullstack.admin.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.fullstack.admin.user.mapper.AdminNewsletterMapper;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.NewsletterInfoVO;

@Service
public class AdminNewsletterService {
    @Autowired
    private AdminNewsletterMapper adminNewsletterMapper;
    
    public ResultCountVO<NewsletterInfoVO> getAllSubscribers(NewsletterInfoVO userNewsletterInfoVO) {
      if(userNewsletterInfoVO.getCount()==0) {
        userNewsletterInfoVO.setCount(10);
      }
      if(userNewsletterInfoVO.getPage()!=0) {
        int start = (userNewsletterInfoVO.getPage()-1)*userNewsletterInfoVO.getCount();
        userNewsletterInfoVO.setStart(start);
      }
      ResultCountVO rcv = new ResultCountVO();
      rcv.setList(adminNewsletterMapper.getAllSubscribers(userNewsletterInfoVO));
      rcv.setCount(adminNewsletterMapper.getAllSubscribersTotal(userNewsletterInfoVO));
      return rcv;
    }
    
    public int addSubscribers(List<NewsletterInfoVO> subscribers) {
      int result = 0;
      
      for(NewsletterInfoVO subscriber:subscribers) {
        subscriber.setUnStatus("active");
        result += adminNewsletterMapper.addSubscriber(subscriber); //0
      }
      if(subscribers.size() != result) {
        throw new RuntimeException("오류가 발생하였습니다.");
      }
      return result;
    }
    
    public int deleteSubscribers(List<NewsletterInfoVO>  subscribers) {
        
      int result = 0;
      
      for(NewsletterInfoVO subscriber:subscribers) {
        subscriber.setUnStatus("unsubscribed");
        result += adminNewsletterMapper.deleteSubscriber(subscriber);
      }
      
      if(subscribers.size() != result) {
        throw new RuntimeException("오류가 발생하였습니다.");
      }
      
      return result;
    }
}
