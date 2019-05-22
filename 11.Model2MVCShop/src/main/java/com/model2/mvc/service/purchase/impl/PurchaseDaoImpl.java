package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
		// TODO Auto-generated constructor stub
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		
		return sqlSession.selectOne("PurchaseMapper.getPurchaseByTranNo", tranNo);
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		
	}

	@Override
	public List<Purchase> getPurchaseList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}

	@Override
	public void updateTranceCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTranceCode", purchase);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	@Override
	public int getTotalCount(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
	}

}
