package com.shop.fullstack.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.admin.user.service.AdminNewsletterService;
import com.shop.fullstack.order.vo.ResultCountVO;
import com.shop.fullstack.user.vo.NewsletterInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AdminNewsletterController {
    @Autowired
    private AdminNewsletterService adminNewsletterService;
    
    @PostMapping("/newsletter")
    public ResultCountVO<NewsletterInfoVO> getAllSubscribers(@RequestBody NewsletterInfoVO userNewsletterVO) {
      log.info("넘겨보낸 vo"+userNewsletterVO.toString());
      return adminNewsletterService.getAllSubscribers(userNewsletterVO);
    }

    @PutMapping("/add-newsletter")
    public int addSubscribers(@RequestBody List<NewsletterInfoVO> subscribers) {
        log.info("Received data: " + subscribers.toString());
        return adminNewsletterService.addSubscribers(subscribers);
    }

    @PutMapping("/delete-newsletter")
    public int deleteSubscriber(@RequestBody List<NewsletterInfoVO> subscribers) {
      return adminNewsletterService.deleteSubscribers(subscribers);
    }
}
