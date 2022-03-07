<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제 처리</title>
</head>
<body>

<jsp:useBean id="dao" class="bbs.BoardDao"/>

<%
	request.setCharacterEncoding("UTF-8");

	try{
		
		String num =  request.getParameter("num"); 
		dao.delete(Integer.parseInt(num));
		
   	}catch(Exception e){e.printStackTrace();}
    
   pageContext.forward("bbs_list.jsp");
%>

</body>
</html>