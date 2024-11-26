package com.shop.fullstack.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.user.service.NewsletterService;
import com.shop.fullstack.user.vo.NewsletterInfoVO;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class NewsletterInfoController {
    @Autowired
    private NewsletterService newsletterService;
    
    @PostMapping("/newsletter2")
    public int checkEmailForSubscribe(@RequestBody NewsletterInfoVO newsletter) {
        return newsletterService.checkEmail(newsletter);
    }
    @PostMapping("/newsletter3")
    public int subscribeAsGuest(@RequestBody NewsletterInfoVO newsletter) {
        return newsletterService.subscribeAsGuest(newsletter);
    }
    @PostMapping("/newsletter4")
    public int unsubscribeAsGuest(@RequestBody NewsletterInfoVO newsletter) {
        if (newsletter == null || newsletter.getUnEmail() == null) {
          throw new IllegalArgumentException("Invalid newsletter information");
        }
        return newsletterService.unsubscribeAsGuest(newsletter);
    }
    
}
