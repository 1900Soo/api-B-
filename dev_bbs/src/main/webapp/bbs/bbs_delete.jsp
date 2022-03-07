<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>
<body>

<div style="margin-top: 50px"><h3>글 삭제</h3></div>
   
<form action="bbs_deletePro.jsp">

   <input type="hidden" name="num" value="<%=request.getParameter("num") %>"/>

<table>
	<tr>
		<th bgcolor="#FFFFB4">정말 글삭제를 하시겠습니까?</th>
	</tr>
	<tr>
		<td>
			<input type="submit" value="삭제하기"/>&nbsp; | &nbsp;
			<input type="button" value="목록보기" onclick="window.location='bbs_list.jsp' "/>
		</td>
	</tr>
</table>

</form>

</body>
</html>