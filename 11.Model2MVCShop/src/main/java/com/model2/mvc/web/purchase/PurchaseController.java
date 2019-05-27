package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	@Qualifier("productServiceImpl")
	@Autowired
	private ProductService productService;
	
	@Qualifier("userServiceImpl")
	@Autowired
	private UserService userService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping("addPurchase")
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,@ModelAttribute("product") Product product,HttpSession session,Model model) throws Exception {
		
		System.out.println("addPurchase.do////////");
		System.out.println(purchase);
		int prodNo = product.getProdNo();
		System.out.println(product);
		User buyer = (User)session.getAttribute("user");		
		
		Map<String,Object> prod = new HashMap<String,Object>();
		prod.put("amount", Integer.parseInt(purchase.getAmountPur()));
		prod.put("prodNo", prodNo);
		
		productService.updateAmount(prod);
		
		int amountPur = Integer.parseInt(purchase.getAmountPur());
				
		int mileage = buyer.getMileage()+(int)(product.getPrice()*amountPur*0.03)-purchase.getUseMileage();
		buyer.setMileage(mileage);
		userService.updateUser(buyer);
		
		product = productService.getProduct(prodNo);
				
		purchase.setPurchaseProd(product);
		purchase.setBuyer(buyer);
		
		model.addAttribute("purchase", purchase);
		
		purchaseService.addPurchase(purchase);
		System.out.println(purchase);
		
		
		return "forward:/purchase/addPurchaseViewResult.jsp";
	}
	
	@RequestMapping("addCart")
	public String addCart(@ModelAttribute("purchase") Purchase purchase,@ModelAttribute("product") Product product,HttpSession session,Model model) throws Exception {
		
		System.out.println("addCart.do////////");
		
		int prodNo = product.getProdNo();
		System.out.println(product);
		User buyer = (User)session.getAttribute("user");		
				
		product = productService.getProduct(prodNo);
				
		purchase.setPurchaseProd(product);
		purchase.setBuyer(buyer);
		purchase.setAmountPur("1");
		purchase.setTranCode("0");
		
		purchaseService.addPurchase(purchase);
		
		System.out.println(purchase);
		
		
		return "redirect:/purchase/listPurchase?menu=cart";
	}
	
	@RequestMapping("addPurchaseView")
	public String addPurchaseView(@RequestParam("prodNo") int prodNo,Model model) throws Exception {
		
		System.out.println("addPurchaseView.do////////");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping("getPurchase")
	public String getPurchase(@RequestParam("tranNo") int tranNo,Model model) throws Exception {
		
		System.out.println("getPurchase.do////////");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		if(purchase.getDivyDate()!=null) {
			purchase.setDivyDate(purchase.getDivyDate().substring(0,10));
		}
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
	}
	
	@RequestMapping("listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search , Model model ,HttpSession session ) throws Exception {
		
		System.out.println("listPurchase.do////////");
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		String result = "forward:/purchase/listPurchase.jsp";
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		if(search.getMenu().equals("cart")) {
			search.setTranWhere("0");
			result = "forward:/purchase/listCart.jsp";
		}
		
		
		Map<String , Object> smap = new HashMap<String,Object>();
		smap.put("buyer", userId);
		smap.put("search", search);
		
		Map<String , Object> map= purchaseService.getPurchaseList(smap);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListPurchaseAction ::"+resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return result;
	}
	
	@RequestMapping("updatePurchase")
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		System.out.println("updatePurchase.do////////");
		
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	
	@RequestMapping("updatePurchaseView")
	public String updatePurchaseView(@RequestParam("tranNo") String tmp,Model model) throws Exception {
		
		System.out.println("updatePurchaseView.do/////////////");
		
		int tranNo = Integer.parseInt(tmp);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setDivyDate(purchase.getDivyDate().substring(0,10).replace("-", ""));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping("updateTranCode")
	public String updateTranCode(@RequestParam("tranNo") int tranNo,@RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("updateTranCode.do/////////////");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranceCode(purchase);
		
		return "redirect:/purchase/listPurchase?menu=user";
		
	}
	
	@RequestMapping("updateTranCodeByProdNo")
	public String updateTranCodeByProdNo(@RequestParam("tranNo") int tranNo,@RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("updateTranCodeByProd.do/////////////");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranceCode(purchase);
		
		return "redirect:/purchase/listPurchase?menu=manage";
		
	}
	
}
