package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping(value = "json/updateTranCode/{tranNo}/{tranCode}" ,method = RequestMethod.GET)
	public Map<String,Object> updateTranCode(@PathVariable("tranNo") int tranNo, @PathVariable("tranCode") String tranCode) throws Exception {
		
		System.out.println("json/updateTranCode/////////");
			
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranceCode(purchase);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String message = "";
		
		if((purchaseService.getPurchase(tranNo).getTranCode()).equals(tranCode)){
			message = "ok";
		}else {
			message = "nogood";
		}
		map.put("message", message);
		map.put("tranNo", tranNo);
		
		System.out.println(message+"///////"+tranNo);
		System.out.println("upTranCode End////////");
		
		return map;
	}	
	
}
