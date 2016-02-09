package com.myspring.gachon.tags;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.myspring.gachon.content.ContentKey;

public class ScriptTag extends TagSupport {

	private static final long serialVersionUID = -3032480979250885081L;

	static Properties properties = new Properties();
	private static String AJAX_CONNECTION_ERROR = null;
	private static String CONTEXT_PATH = null;
	private static String PATH_RESOURCES = null;
	private static String PATH_PLUGIN = null;
	private static String PATH_JQUERY = null;
	private static String PATH_BOOTSTRAP = null;
	private static String PATH_IMAGES = null;
	private static String PATH_CSS = null;
	private static String PATH_JS = null;

	private static StringBuffer sb = null;
	private String common = "";
	private String jQuery = "";
	private String bootstrap = "";
	private String bootstrapTable = "";
	private String noty = "";
	private String select = "";

	static {
		try {
			String path = HtmlTag.class.getClassLoader().getResource("").getPath();
			String fullPath = URLDecoder.decode(path, "UTF-8");
			String pathArr[] = fullPath.split("/WEB-INF/classes/");
			fullPath = pathArr[0];
			fullPath = fullPath + "/WEB-INF/properties/enviroment_ko_KR.properties";
			properties.load(new FileInputStream(fullPath));

			CONTEXT_PATH = properties.getProperty("CONTEXT_PATH").replace("{0}", " ");
			PATH_RESOURCES = properties.getProperty("PATH_RESOURCES").replace("{0}", CONTEXT_PATH);
			PATH_PLUGIN = properties.getProperty("PATH_PLUGIN").replace("{0}", PATH_RESOURCES);
			PATH_JQUERY = properties.getProperty("PATH_JQUERY").replace("{0}", PATH_PLUGIN);
			PATH_BOOTSTRAP = properties.getProperty("PATH_BOOTSTRAP").replace("{0}", PATH_PLUGIN);
			PATH_IMAGES = properties.getProperty("PATH_IMAGES").replace("{0}", PATH_RESOURCES);
			PATH_CSS = properties.getProperty("PATH_CSS").replace("{0}", PATH_RESOURCES);
			PATH_JS = properties.getProperty("PATH_JS").replace("{0}", PATH_RESOURCES);

			AJAX_CONNECTION_ERROR = properties.getProperty("AJAX_CONNECTION_ERROR");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String contextPath = request.getContextPath();

		try {
			JspWriter out = pageContext.getOut();
			sb = new StringBuffer();
			// 각 페이지마다 필요한 기능의 자바스크립트 라이브러리를 불러와서 사용하는 방식.
			// 예를들면 파일업로드가 필요한 부분에서만 라이브러리를 부르면되는데 전역으로 다 불러서 사용할 필요는 없다 이거다.
			appendln("<script src='"+contextPath+PATH_JS+"/navBarTag.js'></script>");

			if (!this.common.equals(ContentKey.KEY_NO)) {
				appendln("<script src='" + contextPath + ScriptTag.PATH_JS + "/custom.js'></script>");
			}
			if (!this.jQuery.equals(ContentKey.KEY_NO)) {
				appendln("<script src='" + contextPath + ScriptTag.PATH_JQUERY + "/jquery-2.1.3.min.js'></script>");
			}
			if (!this.bootstrap.equals(ContentKey.KEY_NO)) {
				appendln("<script src='" + contextPath + ScriptTag.PATH_BOOTSTRAP + "/bootstrap.min.js'></script>");
			}
			if (!this.noty.equals(ContentKey.KEY_NO)) {
				appendln("<link rel='stylesheet' href='" + contextPath + ScriptTag.PATH_CSS + "/gachonCustom.noty.css'/>");
				appendln("<script src='" + contextPath + ScriptTag.PATH_JS + "/gachonCustom.noty.js'></script>");
				appendln("<script src='" + contextPath + ScriptTag.PATH_PLUGIN + "/noty/jquery.noty.packaged.min.js'></script>");
			}
			if(this.bootstrapTable.equals(ContentKey.KEY_YES)) {
				appendln("<link rel='stylesheet' href='" + contextPath + ScriptTag.PATH_PLUGIN + "/boostrap-table/bootstrap-table.min.css'/>");
				appendln("<script src='" + contextPath + ScriptTag.PATH_PLUGIN + "/boostrap-table/bootstrap-table.min.js'></script>");
			}
			if(this.getSelect().equals(ContentKey.KEY_YES)){
			appendln("<script src='"+contextPath + ScriptTag.PATH_JS+"/selectTag.js'></script>");
			}
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			appendln("");
			out.print(sb.toString());

		} catch (IOException ioe) {
			throw new JspException("Error: " + ioe.getMessage());
		}
		return EVAL_BODY_INCLUDE;
	}

	@Override
	public int doEndTag() throws JspException {
		try {
			JspWriter out = pageContext.getOut();

			sb = new StringBuffer();
			appendln("</head>");

			out.print(sb.toString());
		} catch (IOException ex) {
			throw new JspException(ex);
		}
		return EVAL_PAGE;
	}

	void appendln(String str) {
		sb.append(str).append("\n");
	}

	public String getCommon() {
		return common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public String getBootstrapTable() {
		return bootstrapTable;
	}

	public void setBootstrapTable(String bootstrapTable) {
		this.bootstrapTable = bootstrapTable;
	}

	public String getjQuery() {
		return jQuery;
	}

	public void setjQuery(String jQuery) {
		this.jQuery = jQuery;
	}

	public String getBootstrap() {
		return bootstrap;
	}

	public void setBootstrap(String bootstrap) {
		this.bootstrap = bootstrap;
	}

	public String getNoty() {
		return noty;
	}

	public void setNoty(String noty) {
		this.noty = noty;
	}

	public String getSelect() {
		return select;
	}

	public void setSelect(String select) {
		this.select = select;
	}

}
