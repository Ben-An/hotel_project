package org.zerock.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class RequestWrapper extends HttpServletRequestWrapper{

	public RequestWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }
 
    public String[] getParameterValues(String parameter) {
 
      String[] values = super.getParameterValues(parameter);
      if (values==null)  {
                  return null;
          }
      int count = values.length;
      String[] encodedValues = new String[count];
      for (int i = 0; i < count; i++) {
                 encodedValues[i] = XSSFilter(values[i]);
       }
      return encodedValues;
    }
 
    public String getParameter(String parameter) {
          String value = super.getParameter(parameter);
          if (value == null) {
                 return null;
                  }
          return XSSFilter(value);
    }
 
    public String getHeader(String name) {
        String value = super.getHeader(name);
        if (value == null)
            return null;
        return XSSFilter(value);
 
    }
 
    private String XSSFilter(String value) {
    	System.out.println("XSS Filter before : " + value);
    	value = value
    			.replaceAll("&#", "");
    			//.replaceAll("&", "& amp;")
    			//.replaceAll("<", "& lt;")
    			//.replaceAll(">", "& gt;")
    			//.replaceAll("\"", "& quot;")
    			//.replaceAll("\'", "&# x27;")
    			//.replaceAll("/", "&# x2F;");
    	System.out.println("XSS Filter after : " + value);		

    			return value;
    }
}

