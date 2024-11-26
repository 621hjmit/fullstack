package com.shop.fullstack.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shop.fullstack.product.service.ProductMaterialMappingService;
import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;

@RestController
public class ProductMaterialMappingController {

    @Autowired
    private ProductMaterialMappingService productMaterialMappingService;

    // Get all product material mappings
    @GetMapping("/productMaterialMapping")
    public List<ProductMaterialMappingVO> getAllProductMaterialMappings() {
        return productMaterialMappingService.getAllProductMaterialMappings();
    }

	
	  // Get product material mapping by product ID
	  
	  @GetMapping("/productMaterialMapping/{piId}")
	  public List<ProductMaterialVO> getProductMaterialMappingByProductId(int piId){
		  return productMaterialMappingService.selectProductMaterialsByProductId(piId);
	  }
	 

    // Add product material mapping
    @PostMapping("/productMaterialMapping")
    public int addProductMaterialMapping(@RequestBody ProductMaterialMappingVO productMaterialMapping) {
        return productMaterialMappingService.addProductMaterialMapping(productMaterialMapping);
    }

    // Update product material mapping
    @PutMapping("/productMaterialMapping/{piId}")
    public ResponseEntity<String> updateProductMaterialMapping(@PathVariable int piId, @RequestBody ProductMaterialMappingVO productMaterialMapping) {
        productMaterialMapping.setPiId(piId);
        int result = productMaterialMappingService.updateProductMaterialMapping(productMaterialMapping);
        
        if (result > 0) {
            return ResponseEntity.ok("Product material mapping updated successfully");
        } else {
            return ResponseEntity.badRequest().body("Failed to update product material mapping");
        }
    }

    // Delete product material mapping by product ID
    @DeleteMapping("/productMaterialMapping/{piId}")
    public int deleteProductMaterialMapping(@PathVariable int piId) {
        return productMaterialMappingService.deleteProductMaterialMapping(piId);
    }
    
}
