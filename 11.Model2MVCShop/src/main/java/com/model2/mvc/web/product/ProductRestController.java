package com.model2.mvc.web.product;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	
	@RequestMapping(value = "json/Kakaopay/{prodNo}" ,method = RequestMethod.GET)
	public String Kakaopay(@PathVariable("prodNo") int prodNo , HttpSession session) throws Exception {
		
		System.out.println("json/Kakaopay/{prodNo}/////////");
		
		Product product = productService.getProduct(prodNo);
		
        String daumOpenAPIURL = "https://kapi.kakao.com/v1/payment/ready";
    	
        // java API 를 이용 HttpRequest
        URL url = new URL(daumOpenAPIURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Authorization", "KakaoAK 593d683e10b73b905dfb5f56dbd9782d");
        con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        
        con.setDoOutput(true);
        
        String jsonInputString = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name="+product.getProdName()
        		+"&quantity=1&total_amount="+product.getPrice()+"&tax_free_amount=0&approval_url=http://192.168.0.45:8080/kakaoSuccess.jsp?prodNo="+prodNo+"&fail_url=http://192.168.0.45:8080/"
        		+"&cancel_url=http://192.168.0.45:8080/";
       
        System.out.println("String : "+jsonInputString);
        
        byte[] input = jsonInputString.getBytes("utf-8");
        
        con.getOutputStream().write(input); // POST 호출
        
        int responseCode = con.getResponseCode();
        
        BufferedReader br = null;
        
        if(responseCode==200) { 
            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
        }
        
        
        //JSON Data 읽기
        String jsonData = "";
        StringBuffer response = new StringBuffer();
        
        while ((jsonData = br.readLine()) != null) {
            response.append(jsonData);
        }
        
        br.close();
        
        // Console 확인
        System.out.println("code : "+responseCode);
        System.out.println(response.toString());
		
        if(responseCode==200) {
        	
        	session.setAttribute("kakaoProd", prodNo);
        	
		}
        
		return response.toString();
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
