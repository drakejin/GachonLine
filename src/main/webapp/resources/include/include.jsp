<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/WEB-INF/tld/GachonLineTag.tld" prefix="gachonTag"%>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>

<c:set var="CONTEXT_PATH" value="<%=request.getContextPath() %>" />
<c:set var="PATH_JS" value="${CONTEXT_PATH }/resources/js" />
<c:set var="PATH_IMAGES" value="${CONTEXT_PATH }/resources/image" />
<c:set var="PATH_JQUERY" value="${CONTEXT_PATH }/resources/plugin/jquery" />
<c:set var="PATH_CSS" value="${CONTEXT_PATH }/resources/css" />
<c:set var="PATH_PLUGIN" value="${CONTEXT_PATH }/resources/plugin" />
