package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
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
		
		Map<String, Object> map = new HashMap<String,Object>();
		
		List<Purchase> purchaseList = purchaseService.getPurchaseListByUserId(userId);
		
		int totalCount = purchaseService.getCountPurchase(userId);
		int cancelCount = purchaseService.getCountCancelPurchase(userId);
		
		map.put("purchaseList", purchaseList);
		map.put("totalCount", totalCount);
		map.put("cancelCount", cancelCount);
		map.put("cancelList", purchaseService.getCancelListByUserId(userId));
		map.put("userId", userId);
		
	
		System.out.println("RestController map :: "+purchaseList.get(0).getTranNo());
		
		request.setAttribute("map", map);
		
		return "/purchase-component/getUserHistory.jsp";
	}
	
	

}
