<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		boolean result = (boolean)request.getAttribute("result");
		String retCmd = request.getParameter("ret_cmd");
		String conName = request.getParameter("conName");

		int ozipIdx = -1;
		if(request.getParameter("ozip_idx")!=null) {
			ozipIdx = Integer.parseInt(request.getParameter("ozip_idx"));
		}
		if("null".equals(retCmd)) {
			retCmd = "Ozip_main";
		}
%>

<% 		if(result) { %>
<% 			session.setAttribute("loginEmail", request.getParameter("email")); 
			/* session.setAttribute("memberId", request.getParameter("memberId")); */
%>
		<script>
			let new_location = "Controller?command=<%=retCmd%>";  // ---> @WebServlet("/o_main") 이라고 시작되는 서블릿을 실행할 것. doGet()... get방식이니까.
			if(<%=ozipIdx%>!=-1)
				new_location += "&ozip_idx=<%=ozipIdx%>";
			if("<%=conName%>"!="null")
				new_location += "&conName=<%=conName%>";
			location.href= new_location;
		</script>
	
<% 		} else { 	%>
		<script>
			alert("아이디나 비번이 틀렸습니다.");
			location.href = "Controller?command=login_form";
		</script>
<% 		}  %>