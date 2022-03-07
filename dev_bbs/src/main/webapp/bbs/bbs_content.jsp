<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글내용</title>

<!--  
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
-->
</head>
<body>

<jsp:useBean id = " dao"  class="bbs.BoardDao"/>
<jsp:useBean id = " dto"  class="bbs.BoardDto"/>

<%
	String pageNum = request.getParameter("pageNum");
	int num=Integer.parseInt(request.getParameter("num"));
	dao.updateReadCount(num);
	dto=dao.getArticle(num);

%>

<div style="margin-top: 100px">

		<table border="1">
			<tr>
			    <th colspan="2" bgcolor="#FFFFB4">게시글 내용</th>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=dto.getWriter() %></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=dto.getSubject() %></td>
			</tr>
			<tr>
				<td height="300px;" width="50px;">내용</td>
				<td><%=dto.getContent() %></td>
			</tr>
			<tr>
                <td>작성일</td>
                <td><%=dto.getReg_date() %></td>
            </tr>
			<tr>
				<td colspan="2">
					<button onclick="window.location='bbs_update.jsp?num=<%=num %>&pageNum=<%=pageNum %>' ">수정하기</button>&nbsp; | &nbsp;
					<button onclick="window.location='bbs_delete.jsp?num=<%=num %>' ">글삭제</button>&nbsp; | &nbsp;
					<button onclick="window.location='bbs_list.jsp?num=<%=num %>' ">글목록</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>