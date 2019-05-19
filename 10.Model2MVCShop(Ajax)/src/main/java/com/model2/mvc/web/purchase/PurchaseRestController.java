package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping("json/getPurchaseUserHistory/{userId}")
	public String getPurchaseUserHistory(@PathVariable("userId") String userId,
										HttpServletRequest request) throws Exception{
		
		Search search = new Search();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, userId);
		
		int cancelCount = purchaseService.getCountCancelPurchase(userId);
		
		map.put("cancelCount", cancelCount);
		map.put("userId", userId);
		
		request.setAttribute("map", map);
		
		return "/purchase-component/getUserHistory.jsp";
	}
	
	

}
