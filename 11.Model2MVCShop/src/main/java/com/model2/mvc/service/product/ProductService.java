package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;



public interface ProductService {
	
	public void addProduct(Product product) throws Exception;

	public Product getProduct(int prodNo) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	public List<String> getTagName()throws Exception;
	
	public void updateAmount(Map<String,Object> prod)throws Exception;
	
	public Map<String,Object> getReviewList(Map<String,Object> map) throws Exception;
	
	public Review getReview(int tranNo) throws Exception;
	
	public Map<String,Object> getReviewListByUser(Map<String,Object> map) throws Exception;
	
	public void addReview(Review review) throws Exception;
	
}