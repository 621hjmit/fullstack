package com.shop.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewsController {
	@GetMapping("/")
	public String home() {
		return "views/index";
	}

	@GetMapping("/views/**")
	public void goPage() {
	}
	
	
	/*
	@GetMapping("/product/images/{filename:.+}")
	public ResponseEntity<Resource> serveImage(@PathVariable String filename) throws FileNotFoundException {
	    Path imagePath = Paths.get("src/main/resources/static/product/images/" + filename);
	    Resource resource;
	    try {
	        resource = new UrlResource(imagePath.toUri());
	        if (resource.exists() || resource.isReadable()) {
	            return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, Files.probeContentType(imagePath)).body(resource);
	        } else {
	            throw new FileNotFoundException("Could not read file: " + filename);
	        }
	    } catch (IOException e) {
	        throw new RuntimeException("Error: " + e.getMessage());
	    }
	}
	*/
}