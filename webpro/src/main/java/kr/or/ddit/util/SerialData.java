package kr.or.ddit.util;

import java.io.BufferedReader;

import jakarta.servlet.http.HttpServletRequest;

public class SerialData {

	
	public static  String changeData(HttpServletRequest  request) {
		
		StringBuffer  strbuf = new StringBuffer();
		String line = null;

		try {
			BufferedReader  br = request.getReader();

			while(true){
				line = br.readLine();
				if(line == null) break;
				strbuf.append(line);
			}
		} catch (Exception e) {
			// TODO: handle exception
				e.printStackTrace();
		}
			

		 String reqData = strbuf.toString();
		 System.out.println(reqData);
		 
		 return reqData;
	 
	}
}
