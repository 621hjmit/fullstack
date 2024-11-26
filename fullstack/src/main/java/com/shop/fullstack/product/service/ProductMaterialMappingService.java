package com.shop.fullstack.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.fullstack.product.mapper.ProductMaterialMappingMapper;
import com.shop.fullstack.product.vo.ProductColorMappingVO;
import com.shop.fullstack.product.vo.ProductColorVO;
import com.shop.fullstack.product.vo.ProductMaterialMappingVO;
import com.shop.fullstack.product.vo.ProductMaterialVO;

@Service
public class ProductMaterialMappingService {

    @Autowired
    private ProductMaterialMappingMapper productMaterialMappingMapper;

    // Get all product material mappings
    public List<ProductMaterialMappingVO> getAllProductMaterialMappings() {
        return productMaterialMappingMapper.selectAllProductMaterialMappings();
    }

    // Get product material mapping by product ID
    public List<ProductMaterialVO> selectProductMaterialsByProductId(int piId) {
        return productMaterialMappingMapper.selectProductMaterialsByProductId(piId);
    }

    // Add product material mapping
    public int addProductMaterialMapping(ProductMaterialMappingVO productMaterialMapping) {
        return productMaterialMappingMapper.insertProductMaterialMapping(productMaterialMapping);
    }

    @Transactional
    public int updateProductMaterialMapping(ProductMaterialMappingVO material) {
       return productMaterialMappingMapper.updateProductMaterialMapping(material);
    }

    // Delete product material mapping by product ID
    public int deleteProductMaterialMapping(int piId) {
        return productMaterialMappingMapper.deleteProductMaterialMappingByProductId(piId);
    }
    
    // 소재 매핑 저장
    public int saveMaterialMapping(int productId, int materialId) {
        ProductMaterialMappingVO materialMapping = new ProductMaterialMappingVO();
        materialMapping.setPiId(productId);
        materialMapping.setPmId(materialId);
        return productMaterialMappingMapper.insertProductMaterialMapping(materialMapping);
    }
    
}
