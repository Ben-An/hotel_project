package org.zerock.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.zerock.domain.HotelApiVO;



public class HotelInfoExplorer {
	
    private static String getTagValue(String tag, Element eElement) {
        NodeList nList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
        Node nValue = (Node) nList.item(0);
        if (nValue == null) {
            return null;
        }
        return nValue.getNodeValue();
    }

    
    public List<HotelApiVO> parsingData() throws IOException, ParserConfigurationException, SAXException{
    	
    	List<HotelApiVO> list = new ArrayList<HotelApiVO>();
    	
    	String str ="";
    	String parsingUrl ="";
    	String urlBuilder = "https://openapi.gg.go.kr/StayingGeneralHotel?"+"key=2724ed9fee134abaae0f2ca829ebb101"+
    	"&TYPE=xml"+
    	"&pindex=1"+
    	"&pSize=510";
    	//URLEncoder.encode("BSN_STATE_NM", "UTF-8")+ "="+ URLEncoder.encode(searchName, "UTF-8") ;
    	
    	
    	URL url = new URL(urlBuilder);
    	
    	 HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         conn.setRequestMethod("GET");
         conn.setRequestProperty("Content-type", "application/json");
        // System.out.println("Response code>>>>>>>>>>>>>>>>>>>>>>>>>> " + conn.getResponseCode());
         
         
         
         
         BufferedReader rd;
         if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
           rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
       } else {
           rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
       }

         
     
  
            
         
         
         StringBuilder sb = new StringBuilder();
         String line;
         while ((line = rd.readLine()) != null) {
             sb.append(line);
         }
         rd.close();
         conn.disconnect();
         //System.out.println(sb.toString());

         parsingUrl = url.toString();
        // System.out.println(parsingUrl);

         DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
         DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
         Document doc = dBuilder.parse(parsingUrl);


         doc.getDocumentElement().normalize();
        // System.out.println("Root element: " + doc.getDocumentElement().getNodeName());
         
         
         NodeList nList = doc.getElementsByTagName("row");
         System.out.println("파싱할 리스트 수 : " + nList.getLength());
         
         

         for (int i = 0; i < nList.getLength(); i++) {
             Node nNode = nList.item(i);
             if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                 Element eElement = (Element) nNode;

                 HotelApiVO dto = new HotelApiVO();
               

               //System.out.println("=================================");
                 
            // System.out.println(getTagValue("BIZPLC_NM", eElement));
            
                 
                 
                 
                 dto.setState(getTagValue("SIGUN_NM", eElement));
                 dto.setRealhotelname(getTagValue("BIZPLC_NM", eElement));
                 dto.setWstroom(getTagValue("WSTROOM_CNT", eElement));
                 dto.setKorroom(getTagValue("KORROOM_CNT", eElement));
                 dto.setRoadaddr(getTagValue("REFINE_ROADNM_ADDR", eElement));
                 dto.setLotnoaddr(getTagValue("REFINE_LOTNO_ADDR", eElement));
                 dto.setLat(getTagValue("REFINE_WGS84_LAT", eElement));
                 dto.setLogt(getTagValue("REFINE_WGS84_LOGT", eElement));
                 dto.setHotelcondition(getTagValue("BSN_STATE_NM", eElement));
                
                 
                 
              
                 //assert false;
                 list.add(dto);
             }
             
            // System.out.println("dto>>>>>>>>>"+list);
         }

         
         
		return list;
         
         
    }
}
         
         
 
   
    
