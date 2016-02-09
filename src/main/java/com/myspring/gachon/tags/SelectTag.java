package com.myspring.gachon.tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import net.sf.json.JSONArray;

import com.myspring.gachon.common.code.CodeVO;

public class SelectTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -19742161028859224L;

	private static StringBuffer sb = null;

	private String id = "";
	private String code = "";
	private String onChange = "";
	private String className = "";
	private String required = "";
	private String initValue = "";
	private String initLabel = "";
	private String selected = "";

	@Override
	public int doStartTag() throws JspException {
		try {
			JspWriter out = pageContext.getOut();
			sb = new StringBuffer();

			sb.append("<select ");
			if (!this.id.isEmpty()) {
				sb.append("id='" + this.id + "' name='" + this.id + "' ");
			}
			if (!this.className.isEmpty()) {
				sb.append("class='form-control " + this.className + "'");
			} else {
				sb.append("class='form-control'");
			}
			if (!this.onChange.isEmpty()) {
				sb.append("onChange='" + this.onChange + "' ");
			}
			sb.append(">");

			if (!this.required.equals("required")) {
				sb.append("<option value='");
				if (!this.initValue.isEmpty()) {
					sb.append(this.initValue);
				}
				sb.append("'>");
				if (!this.initLabel.isEmpty()) {
					sb.append(this.initLabel);
				}

				sb.append("</option>");
			}
			

			if (!this.code.isEmpty()) {
				JSONArray jsonArray = JSONArray.fromObject(this.code);
				for (int i = 0; i < jsonArray.size(); i++) {
					sb.append("<option value='" + jsonArray.getJSONObject(i).getString("value") + "'");
					if (!this.selected.isEmpty() && this.selected.equals(jsonArray.getJSONObject(i).getString("value"))) {
						sb.append(" selected");
					}
					sb.append(">" + jsonArray.getJSONObject(i).getString("label") + "</option>");
				}
			}
			
			appendln("</select>");
			appendln("");

			out.print(sb.toString());

		} catch (IOException ioe) {
			throw new JspException("Error: " + ioe.getMessage());
		}
		return EVAL_BODY_INCLUDE;
	}

	void appendln(String str) {
		sb.append(str).append("\n");
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOnChange() {
		return onChange;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getInitValue() {
		return initValue;
	}

	public void setInitValue(String initValue) {
		this.initValue = initValue;
	}

	public String getInitLabel() {
		return initLabel;
	}

	public void setInitLabel(String initLabel) {
		this.initLabel = initLabel;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

}
