package org.zerock.util;

import java.io.File;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

public class FileController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\hotel\\file_repo";
	
	

	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("hotelFileName") String hotelFileName,
                            	@RequestParam("hotelNo") String hotelNo,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+hotelNo+"\\"+hotelFileName;
		File image=new File(filePath);
		
		int lastIndex = hotelFileName.lastIndexOf(".");
		String imageFileName = hotelFileName.substring(0,lastIndex);
		if (image.exists()) { 
			Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

}
