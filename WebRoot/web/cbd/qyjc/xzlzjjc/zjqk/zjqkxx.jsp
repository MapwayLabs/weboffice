<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.qyjc.common.ModelFactory"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String list = ModelFactory.getZjqk();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<base href="<%=basePath%>">
<title>写字楼租金监测</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	 text-align:center;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}
  .tr01{
  	background-color: #C0C0C0;
  	font-weight:bold;
    line-height: 30px;
    text-align:center;
  }
  .tr02{
  	background-color: #FCFCFC;
  }
   .tr03{
  	background-color: #FCFCFC;
  }
</style>
</head>
<script type="text/javascript">
var  date_id_cols_value="";	
	function save() {
       date_id_cols_value= escape(escape(date_id_cols_value));
		putClientCommond("qyjcManager", "Save_ZjqkXX");
		putRestParameter("date_id_cols_value", date_id_cols_value);
		var reslut = restRequest();
		if (reslut == 'success') {
			alert('保存成功！');
		}
	}

	function chang(dom){
	if(date_id_cols_value!=null&&date_id_cols_value!=""){
	date_id_cols_value=date_id_cols_value+"@"+dom.id+"_"+dom.value;
	}else{
	date_id_cols_value=dom.id+"_"+dom.value;
	}
	}
	
</script>
<body>
	<div align="center">
		<button onClick='save()' id='addButton'>保存</button>
		<button onClick="javascript:window.location.href='zjqknd_pjlm.jsp'" id='addButton1'>平均楼面均价录入</button>
	   <button onClick="javascript:window.location.href='zjqknd_pjzj.jsp'" id='addButton2'>平均租金录入</button>
	</div>
	<%=list%>
</body>
</html>
