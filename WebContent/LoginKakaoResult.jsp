<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String retCmd = request.getParameter("ret_cmd");
	if(retCmd==null)
		retCmd = "Ozip_main";
%>

<script>
	alert("<%=retCmd%>");
	location.href="Controller?command=<%=retCmd%>";  // ---> @WebServlet("/o_main") 이라고 시작되는 서블릿을 실행할 것. doGet()... get방식이니까.
</script>
	
