package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;

public interface ProductDao {
	
	    public void addProduct(Product product) throws Exception;
	    
	    public void addReview(Review review) throws Exception;

	    public Product getProduct(int prodNo) throws Exception;

	    public List<Product> getProductList(Search search) throws Exception;
	    
	    public List<Review> getReviewList(Map<String,Object> map) throws Exception;
	    
	    public Review getReview(int tranNo) throws Exception;
	    
	    public List<Review> getReviewListbyUser(Map<String,Object> map) throws Exception;

	    public void updateProduct(Product product) throws Exception;
	
	    public void updateAmount(Map<String,Object> prod)throws Exception;
	    
	    public List<Product> getTagName()throws Exception;
		
		// 게시판 Page 처리를 위한 전체Row(totalCount)  return
		public int getTotalCount(Search search) throws Exception ;

		public int getTotalReviewCount(Map<String,Object> map) throws Exception;
		
		public int getTotalReviewCountbyUser(Map<String,Object> map) throws Exception;
}
