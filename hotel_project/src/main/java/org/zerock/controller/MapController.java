package org.zerock.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;

import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.SAXException;
import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;
import org.zerock.service.MapService;
import org.zerock.util.HotelInfoExplorer;



import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/map/*")
@AllArgsConstructor
@Log4j
public class MapController {
	@Autowired
	private MapService service;
	
	
	@GetMapping("/mapside")
	public void mapList(Model model,@RequestParam("state") String state){
		
		
		log.info("state>>>>>>>>>>>>"+state);
		model.addAttribute("getmap",service.mapSelect(state));
		
		log.info("model>>>>>>>>>>>>"+model);
		
		
	
	
}
	
	
	
	@GetMapping("/searchList")
	public void searchInfo(Model model) throws IOException, ParserConfigurationException, SAXException {
		
		HotelInfoExplorer apiExplorer = new HotelInfoExplorer();
		
		
		List<HotelApiVO> list =apiExplorer.parsingData();
		
		//log.info("list>>>>>>>>>>>>"+list);
		
		for(HotelApiVO dataDTO : list) {
			
			service.insertInfo(dataDTO);
			
		}
		
		
		
		model.addAttribute("hotelList",service.hotelList());
		
		//log.info("model>>>>>>>>>>>>"+model);
		
	}
	
	
	
//	@RequestMapping(value="/api",produces="application/json;charset=UTF-8",method = RequestMethod.GET )
//	@ResponseBody
//	public String callApi(String searchName) throws IOException {
//		StringBuilder result = new StringBuilder();
//		
//		
//		
//		String urlStr ="https://openapi.gg.go.kr/StayingGeneralHotel?"
//				+"key=2724ed9fee134abaae0f2ca829ebb101"+
//				"&type=json"+
//				"&pindex=1"+
//				"&pSize=2"+
//				URLEncoder.encode("wkpl_nm", "UTF-8")+ "="+ URLEncoder.encode(searchName, "UTF-8");
//				
//		
//		
//		URL url = new URL(urlStr);
//		
//		HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
//		
//		urlConnection.setRequestMethod("GET");
//		
//		BufferedReader br;
//		
//		br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
//		
//		String returnLine;
//		
//		while((returnLine=br.readLine()) !=null) {
//			result.append(returnLine+"\n\r");
//			
//		}
//	
//		/* System.out.println(""+result.toString()); */
//		
//		
//	//	JSONParser parser = new JSONParser();
//	
////	URL url = new URL(urlStr);
//		
////		Reader reader = new InputStreamReader(url.openStream());
////		
////		BufferedReader bufferedReader = new BufferedReader(reader);
////		
////		String returnLine;
////		
////		StringBuilder hotelList = new StringBuilder();
////		
////		while ((returnLine = bufferedReader.readLine()) != null) {
////			hotelList.append(returnLine);
////		}
//		
//		System.out.println("hotelList>>>>>>>>>>>>"+result);
//		
//		
//		Gson gson = new Gson();
//		
//		Map<String, Object> map = gson.fromJson(result.toString(), Map.class);
//		System.out.println("map>>>>>>>>>>>>"+map);
//
////		Map<String, Object> map2 = (Map<String, Object>) map.get("StayingGeneralHotel");
////		
////		System.out.println("map2>>>>>>>>>>>>>"+map2);
//		
//		 ArrayList  list =(ArrayList) map.get("StayingGeneralHotel");
//	
//		 System.out.println("list>>>>>>>>>>"+list.get(1));
//
//		
////		List<HotelApiVO> hotel_list = new ArrayList<>();
//	
//		
//		
////		for (int i = 0; i < list.size(); i++) {
////			Map mMap = (Map) list.get(i);
////			String state = (String) mMap.get("SIGUN_NM");
////			String realhotelname = (String) mMap.get("BIZPLC_NM");
////			String wstroom = (String) mMap.get("WSTROOM_CNT");
////			String korroom = (String) mMap.get("KORROOM_CNT");
////			String roadaddr = (String) mMap.get("REFINE_ROADNM_ADDR");
////			String lotnoaddr = (String) mMap.get("REFINE_LOTNO_ADDR");
////			String lat = (String) mMap.get("REFINE_WGS84_LAT");
////			String logt = (String) mMap.get("REFINE_WGS84_LOGT");
////		
////			HotelApiVO mi = new HotelApiVO(state, realhotelname, Integer.parseInt(wstroom),Integer.parseInt(korroom),
////					roadaddr,lotnoaddr,
////					Double.parseDouble(lat), Double.parseDouble(logt));
////			System.out.println("mi>>>>>>>>>>>>>> " + mi);
////			hotel_list.add(mi);
////		}
//
//		
//
//	
//		
//		return null;
//		
//		
//		
//		
//		
//		
//		
//		//urlConnection.disconnect();
//		
//	
//		
//		
//		
//		
//	}
	
	
	

	
	

}
