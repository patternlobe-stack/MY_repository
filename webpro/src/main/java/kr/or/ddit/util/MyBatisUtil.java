package kr.or.ddit.util;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * SqlSession 객체를 제공하기 위한 팩토리 클래스
 */
public class MyBatisUtil {

	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		
		try {
			// 1-1. xml문서 읽어오기
			// 설정파일의 인코딩 설정(한글처리를 위해서...)
			//Charset charset = Charset.forName("UTF-8");
			//Resources.setCharset(charset);
			
			
			Reader rd = Resources.getResourceAsReader("kr/or/ddit/mybatis/config/mybatis-config.xml");
			
			// 1-2. 위에서 생성한 Reader객체를 이용하여 
			//     SqlSessionFactory 객체 생성하기
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);
			
			rd.close();
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * SqlSession 객체를 제공하기 위한 팩토리 메서드
	 * @return SqlSession 객체
	 */
	public static SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}
	
	/**
	 * SqlSession 객체를 제공하기 위한 팩토리 메서드
	 * @param autoCommit 오토커밋 여부
	 * @return SqlSession 객체
	 */
	public static SqlSession getSqlSession(boolean autoCommit) {
		return sqlSessionFactory.openSession(autoCommit);
	}
	
}
