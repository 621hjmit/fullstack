package com.shop.fullstack.product.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.fullstack.product.mapper.ProductImgMapper;
import com.shop.fullstack.product.vo.ProductImgVO;

@Service
public class ProductImgService {
    private static final Logger logger = LoggerFactory.getLogger(ProductImgService.class);

    @Value("${file.upload.path}")
    private String uploadPath;

    @Autowired
    private ProductImgMapper productImgMapper;

    public List<ProductImgVO> selectProductImgs(ProductImgVO productImg) {
        logger.info("Selecting all product images");
        return productImgMapper.selectProductImgs(productImg);
    }

    public List<ProductImgVO> getImagesByProductId(int piId) {
        List<ProductImgVO> images = productImgMapper.selectImagesByProductId(piId);
        logger.info("Retrieved images for Product ID {}: {}", piId, images);
        return images;
    }

    public int insertProductImg(ProductImgVO productImg) {
        logger.info("Inserting product image: {}", productImg);
        return productImgMapper.insertProductImg(productImg);
    }

    public int deleteProductImg(int piId) {
        logger.info("Deleting product image with ID: {}", piId);
        return productImgMapper.deleteProductImg(piId);
    }

    public int saveProductImages(int productId, List<MultipartFile> imageFiles) throws IOException {
        // 절대 경로로 가져오기
        String uploadDir = new File(uploadPath + "/product/images/").getAbsolutePath();
        File directory = new File(uploadDir);

        // 디렉토리 확인 및 생성
        if (!directory.exists()) {
            directory.mkdirs();  // 디렉토리 생성
        }

        int result = 0;

        for (int i = 0; i < imageFiles.size(); i++) {
            MultipartFile imageFile = imageFiles.get(i);
            String prefix = (i == 0) ? "main_" : "detail_";
            String fileName = prefix + System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            File file = new File(directory, fileName);

            // 파일 저장
            imageFile.transferTo(file);

            // 데이터베이스에 파일 정보 저장
            ProductImgVO productImg = new ProductImgVO();
            productImg.setPiId(productId);
            productImg.setPimgName(fileName);
            productImg.setPimgUrl("product/images/" + fileName);  // 상대 경로 설정
            productImg.setPimgCredat(Timestamp.valueOf(LocalDateTime.now()));

            result += productImgMapper.insertProductImg(productImg);
        }

        return result;
    }

    // 제품 이미지 수정 메서드 추가
    @Transactional
    public void updateProductImages(int piId, MultipartFile mainImage, List<MultipartFile> detailImages) throws IOException {
        // 1. 기존 이미지 삭제
        productImgMapper.deleteProductImg(piId);

        // 2. 새로운 리스트로 이미지 파일 모으기
        List<MultipartFile> allImages = new ArrayList<>();
        if (mainImage != null && !mainImage.isEmpty()) {
            allImages.add(mainImage);
        }
        if (detailImages != null && !detailImages.isEmpty()) {
            allImages.addAll(detailImages);
        }

        // 3. 새로운 이미지를 추가
        if (!allImages.isEmpty()) {
            saveProductImages(piId, allImages);  // 기존 saveProductImages 메서드 재사용
        }
    }

    // 기존 이미지 삭제 메서드
    private void deleteExistingImagesByProductId(int piId) {
        String productImageDir = uploadPath.endsWith(File.separator) ?
            uploadPath + "product" + File.separator + "images" :
            uploadPath + File.separator + "product" + File.separator + "images";

        List<ProductImgVO> existingImages = productImgMapper.selectImagesByProductId(piId);
        for (ProductImgVO img : existingImages) {
            File file = new File(productImageDir, img.getPimgName());
            if (file.exists() && file.delete()) {
                logger.info("Deleted file: {}", file.getName());
            } else {
                logger.warn("Failed to delete file or file does not exist: {}", file.getName());
            }
        }
        productImgMapper.deleteProductImg(piId);
        logger.info("Deleted image records for Product ID: {}", piId);
    }
}


