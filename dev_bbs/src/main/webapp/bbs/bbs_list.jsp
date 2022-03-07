<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List, bbs.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글목록</title>
 
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>

</head>
<body>
<jsp:useBean id="dao" class="bbs.BoardDao" />
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int listSize = 5;//화면에 표시할 게시글 숫자
    int totalNum = dao.countArticles();//DB에 저장된 총 게시글 숫자
    
    int currPageNum = Integer.parseInt(pageNum);//현재 페이지의 네비게이션 번호
	int startRow = (currPageNum - 1) * listSize + 1;//게시글 출력시 시작번호
    int endRow = currPageNum * listSize;//게시글 출력시 끝번호
    int number = 0;//화면에 표시할 글번호
    
    List<BoardDto> articleList = null;
    
    if (totalNum > 0) {
        articleList = dao.getArticles(startRow, listSize * currPageNum);
    }
    
    number = totalNum - (currPageNum - 1) * listSize;
%>


<div style="margin-top:50px"><h3>글목록</h3></div>

<div style="width:70%">
<a href="bbs_write.jsp"><h4 class="list-write-link">글쓰기</h4></a>
</div>

<table style="width:700px" style="height:700px">
	<tr bgcolor="#FFFFB4">
		<th>글번호</th>
		<th>글제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>


<%

if(articleList == null){
%>	
	<tr>
		<td colspan="5">게시판에 올린 글이 없습니다. 글을 올려 주세요..</td>
	</tr>

<%
}else{
	
	for(BoardDto dto : articleList){
	   String reg_date = sdf.format(dto.getReg_date());
%>
    <tr>
    	<td><%=number-- %></td>
    	<td><a href="bbs_content.jsp?num=<%=dto.getNum() %>"><%=dto.getSubject() %></a></td>
    	<td><%=dto.getWriter() %></td>
    	<td><%=reg_date %></td>
    	<td><%=dto.getReadCount() %></td>
    </tr>
<%
	}//for문의 닫힘 괄호
%>
</table>

<center><br/>
<%
	int navSize = 5;//화면에 표시할 페이지 네비게이션 숫자
	int startNum = (currPageNum/navSize)*navSize + 1;//페이지 네비이션 시작 번호
	int endNum = 5;//페이지 네비게이션 끝 번호
	int totalNavNum = ((totalNum % listSize) == 0)? (totalNum/listSize):(totalNum/listSize)+1;//총 네비게이션 번호
	
    if(totalNavNum < 6){//총 네비게이션 번호가 5이하인 경우
        for (int i = startNum; i <= totalNavNum; i++){
%>
        <a href="bbs_list.jsp?pageNum=<%=i%>"> [<%=i%>] </a>&nbsp;
<%
        }
    }else{//총 네비게이션 번호가 6 이상인 경우

    	if((startNum + navSize) <= totalNavNum){//네비게이션 시작번호와 네비게이션 표시 개수를 더한 값이 네비게이션 총 개수보다 작거나 같은 경우 
    		endNum = startNum + navSize-1;
    	}else{ endNum = totalNavNum; }	
    	
        if(startNum > navSize){
%>
        	<a href="bbs_list.jsp?pageNum=<%= (startNum-navSize) %>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = startNum; i <= endNum; i++){
%>        
           <a href="bbs_list.jsp?pageNum=<%= i %>"> [<%= i %>] </a>&nbsp;
<%
        }
        
        if(endNum < totalNavNum){
%>
            <a href="bbs_list.jsp?pageNum=<%= (endNum+1) %>"> 다음&gt; </a>
<% 
         }
    }
}//else문의 닫힘 괄호
%>


</body>
</html>