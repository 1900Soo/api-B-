<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 처리</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
%>
<!-- 
1. 위의 SQL문을 이용하요 basic_bbs_tb테이블과 basic_bbs_seq 시퀀스를 생성하시오.
2. bbs.BoardDto클래스를 정의하고 자바빈 액션태그를 이용해서 dto로 객체생성하고 bbs_write.jsp에서
   입력된 값들로 dto의 멤버변수를 세팅하시오.
3. dto를 이용하여 데이터베이스에 접속하여 작업할 bbs.BoardDao클래스를 정의하고 자바빈 액션태그를 
   이용해서 dao로 객체생성하시오.
4. BoardDao클래스에 접근지정자는 public으로 하고 반환형은 int형이고 BoardDto를 매개변수로 하는
   메소드 insert를 선언하고 매개변수로 들어오는 dto객체를 이용해서 데이터베이스에 데이터를 추가하도록
   내용을 구현하시오.
5. insert메소드의 반환값이 1이면 '게시글이 정상적으로 입력되었습니다'라고 출력하고 '글 목록'에 <a>태그로
   'bbs_list.jsp'를 링크 주소로 정의하시오.        
-->

<jsp:useBean id="dto" class="bbs.BoardDto" />
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="bbs.BoardDao" />
<%
	int result = dao.insert(dto);
	if(result == 1){
		out.println("게시글이 정상적으로 입력되었습니다.&nbsp;&nbsp;<a href='bbs_list.jsp'>글 목록</a>");
	}else{
		out.println("<script>");
		out.println("alert('게시글 입력 실패');");
		out.println("history.back();");
		out.println("</script>");

	}
%>
</body>
</html>