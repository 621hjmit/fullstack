package com.shop.fullstack.controller;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/upload")
public class FileUploadController {

    @Value("${file.upload.path}")
    private String uploadDir; // application.yml에서 설정한 경로를 자동으로 주입받음

    // 파일 업로드 처리
    @PostMapping("/file")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            // 업로드할 파일의 경로를 설정
            Path uploadPath = Paths.get(uploadDir, "product/images");

            // 디렉토리가 존재하지 않으면 생성
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // 파일을 지정된 경로에 저장
            Path filePath = uploadPath.resolve(file.getOriginalFilename());
            file.transferTo(filePath);

            return new ResponseEntity<>("파일 업로드 성공", HttpStatus.OK);
        } catch (IOException e) {
            return new ResponseEntity<>("파일 업로드 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
