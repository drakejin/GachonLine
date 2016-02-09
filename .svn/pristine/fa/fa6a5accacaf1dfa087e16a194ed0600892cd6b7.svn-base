package com.myspring.gachon.content;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

//
public class ContentListener extends ContextLoaderListener  {
/*
import javax.servlet.ServletContextListener;
이것을 사용했을 경우
 

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		ServletContext app = sce.getServletContext();
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		System.out.println("초기화");
		
		app.setAttribute("ACTION_ID", ContentKey.ACTION_ID);
		app.setAttribute("RESULT_DATA", ContentKey.RESULT_DATA);
		app.setAttribute("RESULT_DATA_2", ContentKey.RESULT_DATA_2);
		app.setAttribute("RESULT_DATA_3", ContentKey.RESULT_DATA_3);
		app.setAttribute("RESULT_DATA_4", ContentKey.RESULT_DATA_4);
		app.setAttribute("RESULT_DATA_5", ContentKey.RESULT_DATA_5);
		app.setAttribute("RESULT_DATA_6", ContentKey.RESULT_DATA_6);
		app.setAttribute("RESULT_DATA_7", ContentKey.RESULT_DATA_7);
		app.setAttribute("RESULT_DATA_8", ContentKey.RESULT_DATA_8);
		app.setAttribute("RESULT_DATA_9", ContentKey.RESULT_DATA_9);

		app.setAttribute("RESULT_LIST_DATA", ContentKey.RESULT_LIST_DATA);
		app.setAttribute("RESULT_LIST_DATA_2", ContentKey.RESULT_LIST_DATA_2);
		app.setAttribute("RESULT_LIST_DATA_3", ContentKey.RESULT_LIST_DATA_3);
		app.setAttribute("RESULT_LIST_DATA_4", ContentKey.RESULT_LIST_DATA_4);
		app.setAttribute("RESULT_LIST_DATA_5", ContentKey.RESULT_LIST_DATA_5);
		app.setAttribute("RESULT_LIST_DATA_6", ContentKey.RESULT_LIST_DATA_6);
		app.setAttribute("RESULT_LIST_DATA_7", ContentKey.RESULT_LIST_DATA_7);
		app.setAttribute("RESULT_LIST_DATA_8", ContentKey.RESULT_LIST_DATA_8);
		app.setAttribute("RESULT_LIST_DATA_9", ContentKey.RESULT_LIST_DATA_9);

		app.setAttribute("INFO_DATA", ContentKey.INFO_DATA);
		app.setAttribute("INFO_DATA_2", ContentKey.INFO_DATA_2);
		app.setAttribute("INFO_DATA_3", ContentKey.INFO_DATA_3);
		app.setAttribute("INFO_DATA_4", ContentKey.INFO_DATA_4);
		app.setAttribute("INFO_DATA_5", ContentKey.INFO_DATA_5);
		app.setAttribute("INFO_DATA_6", ContentKey.INFO_DATA_6);
		app.setAttribute("INFO_DATA_7", ContentKey.INFO_DATA_7);
		app.setAttribute("INFO_DATA_8", ContentKey.INFO_DATA_8);
		app.setAttribute("INFO_DATA_9", ContentKey.INFO_DATA_9);

		app.setAttribute("KEY_YES", ContentKey.KEY_YES);
		app.setAttribute("KEY_NO", ContentKey.KEY_NO);
		app.setAttribute("KEY_Y", ContentKey.KEY_Y);
		app.setAttribute("KEY_N", ContentKey.KEY_N);

		app.setAttribute("INSERT_MODE", ContentKey.INSERT_MODE);
		app.setAttribute("UPDATE_MODE", ContentKey.UPDATE_MODE);
		app.setAttribute("DELETE_MODE", ContentKey.DELETE_MODE);

		app.setAttribute("RESULT_CODE", ContentKey.RESULT_CODE);
		app.setAttribute("RESULT_MSG", ContentKey.RESULT_MSG);
		app.setAttribute("RESULT_SUCCESS", ContentKey.RESULT_SUCCESS);
		app.setAttribute("RESULT_FAIL", ContentKey.RESULT_FAIL);
		app.setAttribute("SYMBOLIC_LINK", ContentKey.SYMBOLIC_LINK);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		System.out.println("안녕안녕");
	}
 */

	
//import org.springframework.web.context.ContextLoaderListener; 이녀석을 사용해야한다.
// spring 에서는 jspServlet 객체가 잘 안돌아간다.
	@Override
	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		super.contextInitialized(event);
		ServletContext app = event.getServletContext();
		
		app.setAttribute("ACTION_ID", ContentKey.ACTION_ID);
		app.setAttribute("RESULT_DATA", ContentKey.RESULT_DATA);
		app.setAttribute("RESULT_DATA_2", ContentKey.RESULT_DATA_2);
		app.setAttribute("RESULT_DATA_3", ContentKey.RESULT_DATA_3);
		app.setAttribute("RESULT_DATA_4", ContentKey.RESULT_DATA_4);
		app.setAttribute("RESULT_DATA_5", ContentKey.RESULT_DATA_5);
		app.setAttribute("RESULT_DATA_6", ContentKey.RESULT_DATA_6);
		app.setAttribute("RESULT_DATA_7", ContentKey.RESULT_DATA_7);
		app.setAttribute("RESULT_DATA_8", ContentKey.RESULT_DATA_8);
		app.setAttribute("RESULT_DATA_9", ContentKey.RESULT_DATA_9);

		app.setAttribute("RESULT_LIST_DATA", ContentKey.RESULT_LIST_DATA);
		app.setAttribute("RESULT_LIST_DATA_2", ContentKey.RESULT_LIST_DATA_2);
		app.setAttribute("RESULT_LIST_DATA_3", ContentKey.RESULT_LIST_DATA_3);
		app.setAttribute("RESULT_LIST_DATA_4", ContentKey.RESULT_LIST_DATA_4);
		app.setAttribute("RESULT_LIST_DATA_5", ContentKey.RESULT_LIST_DATA_5);
		app.setAttribute("RESULT_LIST_DATA_6", ContentKey.RESULT_LIST_DATA_6);
		app.setAttribute("RESULT_LIST_DATA_7", ContentKey.RESULT_LIST_DATA_7);
		app.setAttribute("RESULT_LIST_DATA_8", ContentKey.RESULT_LIST_DATA_8);
		app.setAttribute("RESULT_LIST_DATA_9", ContentKey.RESULT_LIST_DATA_9);

		app.setAttribute("INFO_DATA", ContentKey.INFO_DATA);
		app.setAttribute("INFO_DATA_2", ContentKey.INFO_DATA_2);
		app.setAttribute("INFO_DATA_3", ContentKey.INFO_DATA_3);
		app.setAttribute("INFO_DATA_4", ContentKey.INFO_DATA_4);
		app.setAttribute("INFO_DATA_5", ContentKey.INFO_DATA_5);
		app.setAttribute("INFO_DATA_6", ContentKey.INFO_DATA_6);
		app.setAttribute("INFO_DATA_7", ContentKey.INFO_DATA_7);
		app.setAttribute("INFO_DATA_8", ContentKey.INFO_DATA_8);
		app.setAttribute("INFO_DATA_9", ContentKey.INFO_DATA_9);

		app.setAttribute("KEY_YES", ContentKey.KEY_YES);
		app.setAttribute("KEY_NO", ContentKey.KEY_NO);
		app.setAttribute("KEY_Y", ContentKey.KEY_Y);
		app.setAttribute("KEY_N", ContentKey.KEY_N);

		app.setAttribute("INSERT_MODE", ContentKey.INSERT_MODE);
		app.setAttribute("UPDATE_MODE", ContentKey.UPDATE_MODE);
		app.setAttribute("DELETE_MODE", ContentKey.DELETE_MODE);

		app.setAttribute("RESULT_CODE", ContentKey.RESULT_CODE);
		app.setAttribute("RESULT_MSG", ContentKey.RESULT_MSG);
		app.setAttribute("RESULT_SUCCESS", ContentKey.RESULT_SUCCESS);
		app.setAttribute("RESULT_FAIL", ContentKey.RESULT_FAIL);
		app.setAttribute("SYMBOLIC_LINK", ContentKey.SYMBOLIC_LINK);
		
		
		app.setAttribute("JDBC_CONNECTION_ERROR", ContentKey.JDBC_CONNECTION_ERROR);
		
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
		super.contextDestroyed(event);
		System.gc();
		System.out.println("안녕안녕");
	}
	


	

	




	
}
