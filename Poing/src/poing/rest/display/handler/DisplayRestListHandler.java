package poing.rest.display.handler;

import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import poing.member.MemberDTO;
import poing.mvc.CommandHandler;
import poing.rest.RestListDTO;
import poing.rest.display.service.RestListService;

public class DisplayRestListHandler implements CommandHandler
{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			RestListService service = new RestListService();

			
//			pop=2&add=104,107&searchWord=고기&foodType=11,55
					
			
			String pop = request.getParameter("pop");
			String loc_code = request.getParameter("loc_code");
			String food_type = request.getParameter("food_type");
			String searchWord = request.getParameter("searchWord");
			List<RestListDTO> list = null;
			MemberDTO mdto = (MemberDTO)request.getSession().getAttribute("authUser");
			int member_num;
			int current_page = request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page"));
			if(mdto==null) {
				if(pop!=null || loc_code!=null || food_type!=null || searchWord!=null ) list = service.select(pop, loc_code, food_type, searchWord, current_page);
				else list = service.select(current_page);				
			} else {
				member_num = mdto.getM_no(); 
				if(pop!=null || loc_code!=null || food_type!=null || searchWord!=null ) list = service.select(pop, loc_code, food_type, searchWord, member_num, current_page);
				else list = service.select(member_num, current_page);
			}
			
			request.setAttribute("list", list);
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return "rest/restList";
	}
}
