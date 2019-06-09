package poing.product.display.handler;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import poing.member.MemberDTO;
import poing.mvc.CommandHandler;
import poing.product.ProductDTO;
import poing.product.display.service.DisplayProductDetailService;


public class DisplayProductDetailHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			DisplayProductDetailService service = new DisplayProductDetailService();
			int p_num = Integer.parseInt(request.getParameter("p_num"));
			ProductDTO dto = service.select(p_num);
			ArrayList<ProductDTO> list_qna = service.select_qna(p_num);
			MemberDTO mdto = (MemberDTO)request.getSession().getAttribute("authUser");
			int member_num;
			if(mdto==null) {dto = service.select(p_num);
			} else {
				member_num = mdto.getM_no();
				dto = service.select(p_num,member_num);
			}
			request.setAttribute("dto", dto);
			request.setAttribute("list_qna", list_qna);
		System.out.println("DisplayProductDetailHandler");	
			
		} catch (Exception e) { 
				e.printStackTrace();
		}
		return "product/productDetail";
	}

	public static void main(String[] args) {
	}

}
