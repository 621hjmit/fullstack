package com.shop.fullstack.controller;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/uploads")
public class FileController {

    // 파일이 저장된 기본 경로
    private final String baseDir = "/var/www/uploads";

    @GetMapping("/product/images/{filename:.+}")
    public ResponseEntity<Resource> serveImage(@PathVariable String filename) {
        try {
            // 요청된 파일 경로를 생성
            Path filePath = Paths.get(baseDir, "product/images").resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists() || !resource.isReadable()) {
                return ResponseEntity.notFound().build(); // 파일이 없거나 읽을 수 없는 경우
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "image/webp") // 이미지 파일임을 명시
                    .body(resource);

        } catch (MalformedURLException e) {
            return ResponseEntity.badRequest().build(); // 잘못된 경로 요청
        }
    }
}