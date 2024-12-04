package com.shop.fullstack.configurer;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // /static/ 경로로 접근 시 classpath:/static/ 폴더의 파일을 제공
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");

        // /uploads/ 경로로 접근 시 file:/var/www/uploads/ 폴더의 파일을 제공
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:/var/www/uploads/");
    }
}
