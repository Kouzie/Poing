package admin.display.gallery.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.mvc.CommandHandler;

public class DisplayAdminGalleryPage implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DisplayAdminMainPage process");
		
		return "gallery";
	}

}