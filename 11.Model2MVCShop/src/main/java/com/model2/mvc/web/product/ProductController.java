package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Qualifier("productServiceImpl")
	@Autowired
	private ProductService productService;
	
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile[] file) throws Exception{
		
		System.out.println("addProduct////////////");
		System.out.println(uploadPath);
		String MultifileName = "";
				
		
		for(int i=0; i<file.length ; i++) {
			UUID uuid = UUID.randomUUID();
			String fileName = uuid.toString()+"_"+file[i].getOriginalFilename();
			File saveFile = new File(uploadPath, fileName);
			file[i].transferTo(saveFile);
			if(i==0) {
				MultifileName += fileName;
			}else {
				MultifileName += ","+fileName;
			}
			
		}
		System.out.println(MultifileName);
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		product.setFileName(MultifileName);
		product.setProTranCode("1");
		System.out.println(product);
		productService.addProduct(product);
		
		return "redirect:/product/listProduct?menu=manage";
	}
//	public String addCart( HttpSession session, @RequestParam("prodNo") int prodNo) throws Exception {
//		
//		Product product = productService.getProduct(prodNo);
//		
//		List<Product> cart = new ArrayList<Product>();
//		
//		if(session.getAttribute("cart") != null) {
//			cart = (List<Product>) session.getAttribute("cart");
//		}
//		
//		cart.add(product);
//		
//		session.setAttribute("cart", cart);
//		
//		return null;
//		
//	}
	@RequestMapping("getProduct")
	public String getProduct(HttpServletResponse response,@CookieValue(value="history",required=false) Cookie cookie ,  @RequestParam("menu") String menu,
							@RequestParam("prodNo") int prodNo , Model model) throws Exception {
		
		System.out.println("getProduct.do/////////");
		
		String result = "forward:/product/getProductDetail.jsp";
		
		Product product = productService.getProduct(prodNo);
		
		String[] multifileName = null;
		
		if(product.getFileName() != null) {
			if(product.getFileName().contains(",")) {
				
				multifileName = product.getFileName().split(",");
				System.out.println(multifileName);			
				model.addAttribute("multifileName", multifileName);
			}
		}
		
		System.out.println(product);
		
		model.addAttribute("product", product);
		
		if(cookie !=null) {
			cookie.setValue(cookie.getValue()+","+Integer.toString(prodNo));
		}else {
			cookie = new Cookie("history", Integer.toString(prodNo));
		}
		cookie.setPath("/");
		response.addCookie(cookie);
		
		if(menu.equals("manage")){
			result = "forward:/product/updateProductView.jsp";
		}
		
		return result;
	}
	
	@RequestMapping("listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception {
		
		System.out.println("listProduct.do////////////");
		System.out.println(search.getMenu());
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
				
		Map<String , Object> map= productService.getProductList(search);
				
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
				
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct",method = RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile[] file) throws Exception {
		
		System.out.println("updateProduct.do/////////////");
		System.out.println(uploadPath);
		String MultifileName = "";
				
		if(file[0].getOriginalFilename() != "") {
			for(int i=0; i<file.length ; i++) {
				System.out.println("fileChange");
				UUID uuid = UUID.randomUUID();
				String fileName = uuid.toString()+"_"+file[i].getOriginalFilename();
				File saveFile = new File(uploadPath, fileName);
				file[i].transferTo(saveFile);
				if(i==0) {
					MultifileName += fileName;
				}else {
					MultifileName += ","+fileName;
				}				
			}
			product.setFileName(MultifileName);
			System.out.println("파일이미지변경 : "+MultifileName);
		}else {
			product.setFileName(productService.getProduct(product.getProdNo()).getFileName());
		}
		
		
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		
		System.out.println(product);
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=up";
	}
		
	@RequestMapping("reviewProductView")
	public String reviewProductView( @RequestParam("tranNo") int tranNo, @RequestParam("prodNo") int prodNo , Model model) throws Exception {
		
		Product product = productService.getProduct(prodNo);
		
		product.setProTranNo(tranNo);
		model.addAttribute("product", product);
		System.out.println(product);
		
		return "forward:/product/reviewProductView.jsp";
	}
	
	@RequestMapping("addReview")
	public String addReview( @ModelAttribute("review") Review review) throws Exception {
		
		System.out.println("/addReview.do////////////");
		System.out.println(review);
		
		productService.addReview(review);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(review.getReviewTranNo());
		purchase.setTranCode("4");
		purchaseService.updateTranceCode(purchase);
		
		
		return "redirect:/product/listReview?prodNo="+review.getReviewProdNo();
	}
	
	@RequestMapping("listReview")
	public String listReview(@ModelAttribute("search") Search search,@RequestParam("prodNo") int prodNo
							, Model model) throws Exception {
		
		System.out.println("listReview///////////////////");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> smap = new HashMap<String,Object>();
		smap.put("product", prodNo);
		smap.put("search", search);
		
		
		Map<String , Object> map= productService.getReviewList(smap);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListReviewAction ::"+resultPage);
		
		Product reviewProd = productService.getProduct(prodNo);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("product", reviewProd);
		
		return "forward:/product/listReview.jsp";		
	}
	
	@RequestMapping("listReviewByUser")
	public String listReviewByUser(@ModelAttribute("search") Search search, HttpSession session
							, Model model) throws Exception {
		
		System.out.println("listReviewByUser///////////////////");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> smap = new HashMap<String,Object>();
		String userId = ((User)session.getAttribute("user")).getUserId();
		smap.put("userId", userId);
		smap.put("search", search);
		
		
		Map<String , Object> map= productService.getReviewListByUser(smap);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListReviewActionByUser ::"+resultPage);
				
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listReviewByUser.jsp";		
	}
}
