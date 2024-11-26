package com.shop.fullstack.admin.user.vo;

import java.util.List;

import com.shop.fullstack.user.vo.NewsletterInfoVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminNewsletterList {
    private List<NewsletterInfoVO> list;
    private Boolean status;
}
