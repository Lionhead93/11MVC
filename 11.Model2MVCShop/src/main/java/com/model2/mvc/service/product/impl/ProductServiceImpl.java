package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.addProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Product> list= productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct(product);
		
	}

	@Override
	public void updateAmount(Map<String,Object> prod) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateAmount(prod);		
		
	}


	@Override
	public Map<String, Object> getReviewList(Map<String,Object> map) throws Exception {
		
		List<Review> list= productDao.getReviewList(map);
		int totalCount = productDao.getTotalReviewCount(map);
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("list", list );
		map2.put("totalCount", new Integer(totalCount));
		
		return map2;		
	}

	@Override
	public Map<String, Object> getReviewListByUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Review> list= productDao.getReviewListbyUser(map);
		int totalCount = productDao.getTotalReviewCountbyUser(map);
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("list", list );
		map2.put("totalCount", new Integer(totalCount));
		
		return map2;
	}

	@Override
	public void addReview(Review review) throws Exception {
		productDao.addReview(review);
		
	}


	@Override
	public Review getReview(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getReview(tranNo);
	}


	@Override
	public List<String> getTagName() throws Exception {
		// TODO Auto-generated method stub
		
	    List<Product> proList = productDao.getTagName();
	    List<String> tagList = new ArrayList<String>();
	    
	    for(int i=0;i<proList.size();i++) {
	    	tagList.add(proList.get(i).getProdName());
	    }
	    
	    System.out.println(tagList);
		
		return tagList;
	}
	
}
