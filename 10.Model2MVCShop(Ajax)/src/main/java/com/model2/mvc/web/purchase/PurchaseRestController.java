package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping("json/getPurchaseUserHistory/{userId}")
	public Map<String, Object> getPurchaseUserHistory(@PathVariable("userId") String userId) throws Exception{
		
		Search search = new Search();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, userId);
		
		return map;
	}

}
