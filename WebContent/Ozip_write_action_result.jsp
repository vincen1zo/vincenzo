<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<% 
	int ozipIdx = (Integer)request.getAttribute("ozipIdx");
	 //request.getRequestDispatcher("o_main").forward(request, response);
%>
<script>location.href="Controller?command=Ozip_main";</script>