package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductMaterialService;
import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;

@RestController
public class ProductMaterialController {

    @Autowired
    ProductMaterialService productMaterialService;
    
    @GetMapping("/productMaterials")
    public List<ProductMaterialVO> getProductMaterials() {
        return productMaterialService.selectProductMaterials();
    }
    
    @PostMapping("/productMaterial")
    public int addProductMaterial(ProductMaterialVO productMaterial) {
        return productMaterialService.insertProductMaterial(productMaterial);
    }
    
    @GetMapping("/productMaterials/filterItemCount")
    public List<ProductMaterialVO> getMaterialFilterItemCountByDetailCategoryId(@RequestParam int detailCategoryId) {
        return productMaterialService.selectMaterialFilterItemCountByDetailCategoryId(detailCategoryId);
    }
    
}
