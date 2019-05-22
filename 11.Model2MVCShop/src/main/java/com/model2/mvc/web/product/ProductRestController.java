package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Qualifier("productServiceImpl")
	@Autowired
	private ProductService productService;
	
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "json/addProduct", method = RequestMethod.POST)
	public void addProduct( @RequestBody Product product) throws Exception{
		
		System.out.println("json/addProduct////////////");
		
		System.out.println(product);
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		productService.addProduct(product);		
		
	}
	
	@RequestMapping(value = "json/getProduct/{prodNo}" ,method = RequestMethod.GET)
	public Product getProduct(@PathVariable("prodNo") int prodNo) throws Exception {
		
		System.out.println("json/getProduct/{prodNo}/////////");
				
		return productService.getProduct(prodNo);
	}
		
	
	@RequestMapping(value = "json/Autocomplete" ,method = RequestMethod.GET)
	public List<String> Autocomplete() throws Exception {
		System.out.println("json/Autocomplete/////////");
				
		List<String> data = productService.getTagName();
		
		System.out.println(data);
		
		return data;
	}
	
	@RequestMapping(value = "json/listProduct" ,method = RequestMethod.POST)
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception {
		
		System.out.println("json/listProduct////////////");
		search.setPageSize(3);
		System.out.println(search);
				
		Map<String, Object> map = productService.getProductList(search);
		String message = "ok";
		List<Product> list = (List<Product>) map.get("list");
		if(list.size()<1) {
			message = "no";
		}
		map.put("message", message);
		System.out.println(map);		
		
		return map;
	}
	
	@RequestMapping(value = "json/getReview/{tranNo}" ,method = RequestMethod.GET)
	public Review getReview( @PathVariable("tranNo") int tranNo) throws Exception {
		
		System.out.println("json/getReview////////////");
			
		System.out.println(productService.getReview(tranNo));
		
		return productService.getReview(tranNo);
	}
	
	@RequestMapping(value="json/listReview/{prodNo}",method = RequestMethod.GET)
	public Map<String, Object> listReview(@PathVariable("prodNo") int prodNo) throws Exception {
		
		System.out.println("JSONlistReview///////////////////");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> smap = new HashMap<String,Object>();
		smap.put("product", prodNo);
		smap.put("search", search);
				
		return productService.getReviewList(smap);		
	}
}
