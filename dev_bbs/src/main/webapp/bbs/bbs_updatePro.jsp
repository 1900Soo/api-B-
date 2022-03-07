<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
%>

<jsp:useBean id="dto" class="bbs.BoardDto"/>
<jsp:setProperty name="dto" property="*"/>
<jsp:useBean id="dao" class="bbs.BoardDao"/>

<% 
   try{
	dao.update(dto);
   }catch(Exception e){e.printStackTrace();}
    
	String url ="bbs_content.jsp?pageNum="+pageNum;
	pageContext.forward(url);
%>

</body>
</html>