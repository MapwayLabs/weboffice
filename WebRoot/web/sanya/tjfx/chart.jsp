<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.sanya.tjfx.TJFX"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String xml=request.getParameter("xml");
new TJFX().init(xml);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>统计分析</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/thirdres/anyChart/binaries/js/AnyChart.js"></script>
  </head>
      <script type="text/javascript" language="javascript">
      
    </script>
  
<body leftmargin="0" topmargin="0"  > 

    <script type="text/javascript" language="javascript"> 
    var chart = new AnyChart('<%=basePath%>/base/thirdres/anyChart/binaries/swf/AnyChart.swf');
    chart.initText ="加载中........." 
    chart.setXMLFile('<%=basePath%>web/sanya/tjfx/chartxml/<%=xml%>'); 
		chart.width = '100%';
		chart.height = '100%';
    chart.write(); 
   // chart.Refresh();
    </script> 
</body> 
</html>
