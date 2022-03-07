<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글쓰기</title>

<!--  
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
-->
</head>
<body>

<div style="margin-top: 30px"><h3>글쓰기</h3></div>
<div>
	<form method="post" action="bbs_writePro.jsp">
		<table style="width:480px">
			<tr>
				<td bgcolor="#FFFFB4">작성자</td>
				<td><input type="text"  name="writer" size="50"/></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFB4">제목</td>
				<td><input type="text" name="subject" size="50"/></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFB4">내용</td>
				<td><textarea name="content" cols="52" rows="20"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="글등록"/> &nbsp; | &nbsp;
					<input type="reset" value="다시쓰기"/>&nbsp; | &nbsp;
					<input type="button" value="목록보기" onclick="window.location='bbs_list.jsp' "/>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>