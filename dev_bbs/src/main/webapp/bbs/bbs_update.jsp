<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정</title>

<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>
<body>

<jsp:useBean id = " dao"  class="bbs.BoardDao"/>
<jsp:useBean id = " dto"  class="bbs.BoardDto"/>
<%
	String pageNum = request.getParameter("pageNum");	
	String num = request.getParameter("num");
   	dto = dao.getArticle(Integer.parseInt(num));

%>

<div style="margin-top: 100px">
	<form method="post" action="bbs_updatePro.jsp">
	
			<input type="hidden" name="num" value="<%=num %>"/>
			<input type="hidden" name="pageNum" value="<%=pageNum %>"/>
	
		<table style="width:480px">
			<tr>
			    <th colspan="2" bgcolor="#FFFFB4">글수정</th>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text"  name="writer" size="50" value="<%=dto.getWriter() %>"/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="subject" size="50" value="<%=dto.getSubject() %>"/></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" cols="52" rows="15"><%=dto.getContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정하기"/> &nbsp; | &nbsp;
					<input type="button" value="글삭제" onclick="window.location='bbs_delete.jsp?num=<%=num %>' "/>&nbsp; | &nbsp;
					<input type="button" value="목록보기" onclick="window.location='bbs_list.jsp&num=<%=num %>' "/>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>