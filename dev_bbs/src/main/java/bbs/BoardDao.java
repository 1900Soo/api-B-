package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
	
	//DBCP를 이용한 데이터베이스 연결객체 얻기
	public Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();//톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context)initCtx.lookup("java:comp/env");//java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");//context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();//ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}
	
	public int insert(BoardDto dto){
		int result = 0;//0:게시글 입력 실패, 1:게시글 입력 성공
		//게시글을 입력하는 SQL문을 작성하시오.
		String sql="insert into basic_bbs_tb"
				+ "(bbs_num, bbs_writer, bbs_subject, bbs_content) "
				+ "values(basic_bbs_seq.nextval,?,?,?)";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){

			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			
			pstmt.executeUpdate();
			result=1;//1:게시글 입력 성공
     
		}catch(Exception e){ e.printStackTrace(); }
		
        return result;
	}
	

	public int countArticles(){
		int count=0;
		//게시판의 총 게시글 수를 조회하는 SQL문을 작성하시오.
		String sql = "select count(bbs_num) from basic_bbs_tb";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql);
				ResultSet rs= pstmt.executeQuery()){
				
				if(rs != null) 
					rs.next();

				count=rs.getInt(1);
				
			}catch(Exception e){ e.printStackTrace(); }
			
			return count;
		}
	
	
	public List<BoardDto> getArticles(int start, int end){
		List<BoardDto> articleList=null;
		String sql =  "SELECT * FROM ("
				+ "	select ROWNUM r, bbs_num, bbs_writer, bbs_subject, bbs_content, reg_date, readcount"
				+ "	from basic_bbs_tb order by bbs_num DESC)"
				+ " where r >= ?  and r <= ? ";
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				ResultSet rs= pstmt.executeQuery();
				
				if(rs != null) 
					articleList = new ArrayList<BoardDto>();
				
				while(rs.next()){
					BoardDto dto = new BoardDto();	
					dto.setNum(rs.getInt("bbs_num"));
					dto.setWriter(rs.getString("bbs_writer"));
					dto.setSubject(rs.getString("bbs_subject"));
					dto.setContent(rs.getString("bbs_content"));
					dto.setReg_date(rs.getDate("reg_date"));
					dto.setReadCount(rs.getInt("readcount"));				
					articleList.add(dto);
				}
				
				rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return articleList;
		}
	
	
	public BoardDto getArticle(int num){
		BoardDto dto = null;
		
		//글번호에 대한 게시글 데이터를 가져오는 SQL문을 작성하시오.
		String sql = "select * from basic_bbs_tb where bbs_num =?";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){

				pstmt.setInt(1, num);
				ResultSet rs= pstmt.executeQuery();
							
				while(rs.next()){
					dto = new BoardDto();
					dto.setNum(rs.getInt("bbs_num"));
					dto.setWriter(rs.getString("bbs_writer"));
					dto.setSubject(rs.getString("bbs_subject"));
					dto.setContent(rs.getString("bbs_content"));
					dto.setReg_date(rs.getDate("reg_date"));
					dto.setReadCount(rs.getInt("readcount"));
				}
				
				rs.close();
			}catch(Exception e){e.printStackTrace();}
			
			return dto;
		}
	
	
	public void update(BoardDto dto){
		String sql = "update basic_bbs_tb set bbs_writer=?, bbs_subject=?, bbs_content=? where bbs_num=?";
		//글번호에 대한 게시글을 업데이트하는 SQL문을 작성하시오.
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
			
				pstmt.setString(1, dto.getWriter());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());
				pstmt.setInt(4, dto.getNum());
				
	        pstmt.executeUpdate();
	        
			}catch(Exception e){e.printStackTrace();}
		}
	
	public void delete(int num){
		
		//글번호에 대한 게시글을 삭제하는 SQL문을 작성하시오.
		String sql = "delete from basic_bbs_tb where bbs_num =?";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, num);
		
		
		/* PreparedStatement객체는 미완성의 SQL문을 가지고 객체가 만들어지므로
		 * 미완성된 부분(?로 표시됨)을 객체생성 이후에 완성시켜서 실행을 해야합니다.
		 * 각 필드에 들어가는 데이터 영역과 맞는 데이터형으로 setXXX(XXX:데이터형)를
		 * 가지고 각각의 ?를 순서에 맞추어 값을 설정합니다.
		 */
			pstmt.executeUpdate();
	        
		}catch(Exception e){e.printStackTrace();}
	}
	
	
	public void updateReadCount(int num) {
		//게시글의 조회수를 증가시키는 SQL문을 작성하시오.
		String sql = "update basic_bbs_tb set readcount=(readcount+1) where bbs_num =?";
		
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, num);
			
	        pstmt.executeUpdate();
	        
			}catch(Exception e){e.printStackTrace();}
		}
		
	}









