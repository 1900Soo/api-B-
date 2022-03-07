<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest, java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 처리</title>

<%
	String uploadPath = new File("C:/Temp/FileUpload").getAbsolutePath();
	int maxSize = 10*1024*1024;;
	MultipartRequest mr = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	//클라이언트가 업로드한  파일면을 multipartrequest 객체를 통해서 얻음
	
	//1. <form>태그의 <input type = "file"> 의 이름들(uploadfile...)을 반환받음
	Enumeration fileTypeNames = mr.getFileNames();
	
	//2. input type=file  태그의 name을 이용햏 value값(업로드할 파일명)을 얻음
	String fileName = (String)fileTypeNames.nextElement();
	
	String systemFileName = mr.getFilesystemName(fileName);//정해진경로에 실제로 정해진 이름
	String origonalFileName = mr.getOriginalFileName(fileName);//클라이언트가 올린 이름
	
	out.println("<h3>서버에 저장된 파일명: " + systemFileName + "</h3>");
	out.println("<h3>클라이언트가 업로드한 파일명: " + origonalFileName + "</h3>");
%>
</head>
<body>

	<form name="downloadForm" method="post" action="process_download.jsp">
		<input type="hidden" name="sys_file" value="<%= systemFileName%>"/>
		<button onclick="javascript:downloadForm.submit()">다운받기</button>
	</form>

</body>
</html>