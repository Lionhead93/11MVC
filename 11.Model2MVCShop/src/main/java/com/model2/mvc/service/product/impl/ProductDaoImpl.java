package com.model2.mvc.service.product.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl(){
		System.out.println(this.getClass());
	}

	@Override
	public void addProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.addProduct", product);
	}
	
	@Override
	public void addReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ReviewMapper.addReview", review);
	}
	
	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}

	@Override
	public List<Product> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}
	
	@Override
	public List<Review> getReviewList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReviewMapper.getReviewList", map);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct", product);
	}

	@Override
	public void updateAmount(Map<String, Object> prod) throws Exception {
		sqlSession.update("ProductMapper.updateAmount", prod);		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	@Override
	public int getTotalReviewCount(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReviewMapper.getTotalCount", map);
	}

	@Override
	public List<Review> getReviewListbyUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReviewMapper.getReviewListbyUser", map);
	}

	@Override
	public int getTotalReviewCountbyUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReviewMapper.getTotalCountbyUser", map);
	}

	@Override
	public Review getReview(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReviewMapper.getReview", tranNo);
	}

	@Override
	public List<Product> getTagName() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProductMapper.tagList");
	}	
}
