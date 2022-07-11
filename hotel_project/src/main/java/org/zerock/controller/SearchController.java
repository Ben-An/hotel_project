package org.zerock.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.SearchVO;
import org.zerock.service.HotelSearchService;

import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/hotel/*")
@AllArgsConstructor

public class SearchController {
	
	@Autowired
	private HotelSearchService service;


	@PostMapping("/search_normal")
//	public void list(Criteria cri, Model model){
		public void list(@RequestParam Map<String, Object> filterMap, Model model){
		
//		Map<String, Object> filterMap = new HashMap<String, Object>();
//		filterMap.put("pageNum", cri.getPageNum());
//		filterMap.put("amount", cri.getAmount());
//		filterMap.put("keyword", cri.getKeyword());
	System.out.println("filterMap >>>>" +  filterMap);
		model.addAttribute("list",service.listHotels(filterMap));
		
//		int total = service.getTotal(cri);
//		
//		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		System.out.println("model>>>>>>"+model);
	}
	
	@PostMapping("/search_filter")
	public @ResponseBody List<SearchVO> list(@RequestBody Map<String, Object> filterMap, Criteria cri, Model model){
		System.out.println("filterMap >>>>>>>>>>>>> " + filterMap);
		System.out.println("filterMap checkArray >>>>>>>>>>>>> " + filterMap.get("checkArray"));
		filterMap.put("pageNum", cri.getPageNum());
		filterMap.put("amount", cri.getAmount());
		
		List list = service.listHotels(filterMap);
		
		int total = service.getTotal(cri);
		
		//model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		System.out.println("list>>>>>>"+list);
		
		return list;

	}
}
