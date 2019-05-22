package com.model2.mvc.web.product;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.board.product.ProductBoardService;
import com.model2.mvc.service.domain.Discount;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductBoard;
import com.model2.mvc.service.domain.ProductInfo;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productBoardServiceImpl")
	private ProductBoardService productBoardService;
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	

	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/addProduct")
	public Map<String, Object> addProduct(@RequestBody ProductInfo productInfo) throws Exception{
		System.out.println("json/addProduct");
		
		Product product = productInfo.getProduct();
		ProductBoard productBoard = productInfo.getProductBoard();
		
		System.out.println("RestController :: "+product);
		System.out.println("RestController :: "+productBoard);
		
		productBoardService.addProductBoard(productBoard);
		
		String manuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(manuDate);
		
		for(int i=0;i<productBoard.getQuantity();i++) {
			productService.addProduct(product);			
		}
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("product", product);
		map.put("productBoard", productBoard);
		
		return map;
	}
	
	@RequestMapping(value="json/getProduct/{boardNo}/{search}")
	public Map<String,Object> getProduct(@PathVariable int boardNo,
											@PathVariable String search,
											HttpServletRequest request,
											HttpServletResponse response,
											HttpSession session
											) throws Exception {
		System.out.println("json/getProduct");
		
		User user=(User)session.getAttribute("user");
		
		if(search.equals("search")) {
			productBoardService.addViewCount(boardNo);
		}
		
		Map<String,Object> map = productBoardService.getProductBoardByBoardNo(boardNo);
		ProductBoard productBoard = (ProductBoard)map.get("productBoard");
		Discount discount = (Discount)map.get("discount");
		
		Product product = productService.getProductByBoardNo(boardNo);
		
		int purchaseCount = purchaseService.getCountPurchase(user.getUserId());
		int price=product.getPrice();
		if(productBoard.getBoardNo()==discount.getDiscountBoard()) {
			price=(int)(product.getPrice()*0.75);
		}
		if(purchaseCount % 4 == 0) {
			price=(int)(price*0.9);
		}
		product.setResultPrice(price);
		
		if(product.getFileName() == null) {
			product.setFileName("no_detail_img.gif");
		}
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("productBoard", productBoard);
		resultMap.put("product", product);
		resultMap.put("discount", discount);
		//resultMap.put("user", user);
		//resultMap.put("purchaseCount", purchaseCount);
		
		return resultMap;

	}
	
	@RequestMapping(value="json/listProduct/{boardNo}/{menu}",method=RequestMethod.POST)
	public Map<String,Object> getListProduct(@PathVariable("boardNo") int boardNo,
												@PathVariable("menu") String menu){
		System.out.println("json/listProduct");
		
				
		return null;
	}
	
	@RequestMapping(value="json/getProductBoardTitle/{searchKeyword}",method=RequestMethod.GET)
	public String[] getProductBoardTitle(@PathVariable("searchKeyword") String searchKeyword) throws Exception{
		System.out.println("json/getProductBoardTitle");
		System.out.println("searchKeyword :: "+URLDecoder.decode(searchKeyword, "UTF-8"));
		
		List<ProductBoard> boardList = productBoardService.getTitleByKeyword(searchKeyword);
		String[] titleArray = new String[boardList.size()];
		
		for(int i=0;i<boardList.size();i++) {
			titleArray[i] = boardList.get(i).getTitle();
		}
		

		return titleArray;
	}
	
	@RequestMapping(value="json/getProductBoardTitle/",method=RequestMethod.POST)
	public String[] getProductBoardTitlePost(@RequestBody String searchKeyword) throws Exception{
		System.out.println("json/getProductBoardTitlePost");
		
		List<ProductBoard> boardList = productBoardService.getTitleByKeyword(URLDecoder.decode(searchKeyword, "UTF-8"));
		String[] titleArray = new String[boardList.size()];
		
		System.out.println("boardList size :: "+boardList.size());
		System.out.println("boardList title :: "+boardList.get(0).getTitle());
		
		for(int i=0;i<boardList.size();i++) {
			titleArray[i] = boardList.get(i).getTitle();
			System.out.println("titleArray :: "+titleArray[i]);
		}
		

		return titleArray;
	}
		
	
}
