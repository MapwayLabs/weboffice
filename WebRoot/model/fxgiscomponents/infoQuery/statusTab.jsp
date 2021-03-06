﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
    String myData = request.getParameter("myData");
    myData = UtilFactory.getStrUtil().unescape(myData); 
    myData = UtilFactory.getStrUtil().escape(UtilFactory.getStrUtil().escape(myData));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	<%@ include file="/base/include/ext.jspf" %>
   <style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
   </style>
   <script>
   Ext.onReady(function(){ 
    var scrHeight= document.body.offsetHeight;
        var statusTab = new Ext.Panel({
            renderTo:"hello",
            width:350,
            height:300, 
            layout:"accordion",
            layoutConfig: {animate: true }, 
            items:[{
              title:"查询结果",
               html: "<iframe style='height:"+(scrHeight-95)+"PX; width:350px;' src='queryData.jsp?myData=<%=myData%>' />"
            },{
              title:"基本属性",
               html: "<iframe style='height:"+(scrHeight-95)+"PX; width:350px;' src='jbsxList.jsp' />"
            },{
              title:"现状分析",
              html: "<iframe style='height:"+(scrHeight-95)+"PX; width:350px' src='xzdlList.jsp' />"    
            },{
              title:"规划分析",
              html: "<iframe style='height:"+(scrHeight-95)+"PX; width:350px' src='ghList.jsp' />"
            }]
          }); 
        }); 
  
   </script>
  </head>
	<body >
		<div id="hello" style='height:400px;width:100%;'></div>	
	</body>
</html>
