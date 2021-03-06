<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%@page import="com.klspta.web.jizeWW.paddata.PadDatalist"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String name = ProjectInfo.getInstance().getProjectName();
	PadDatalist padlist = new PadDatalist();
	List list = new ArrayList();
	String rows = padlist.getPADDataList(list);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Pad外业采集数据列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf"%>

		<!-- 根据办理时限不同修改数据的显示颜色 -->
		<style type="text/css">
.my_row_Green table {
	color: green
}

.my_row_Gray table {
	color: gray
}
</style>

		<script type="text/javascript">
var myData;
var win;
var store;
var grid;
var expWin;
var form;
Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
	//alert(myData);
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '任务编号'},
           {name: '所在政区'},
           {name: '项目名称'},
           {name: '任务类型'},
           {name: '是否违法'},
           {name: '巡查人'},
           {name: '巡查日期'},
           {name: '采集坐标'},
           {name: '经纬坐标'},
           {name: '图片名称'},
           {name: '详细信息'},
           {name: '删除'},
           {name: 'READFLAG'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.9;
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
            //sm,
            new Ext.grid.RowNumberer(),
            {header: '任务编号', dataIndex:'任务编号', width: width*0.1, sortable: false},
            {header: '所在政区', dataIndex:'所在政区', width: width*0.1, sortable: false},
            {header: '项目名称', dataIndex:'项目名称',width: width*0.2, sortable: false},
            {header: '任务类型', dataIndex:'任务类型',width: width*0.1, sortable: false},
            {header: '是否违法', dataIndex:'是否违法',width: width*0.1, sortable: false},
            {header: '巡查人', dataIndex:'巡查人',width: width*0.05, sortable: false},
            {header: '巡查日期', dataIndex:'巡查日期',width: width*0.1, sortable: false},
            {header: '采集坐标', dataIndex:'采集坐标',width: width*0.1, hidden:true, sortable: false},
            {header: '经纬坐标', dataIndex:'经纬坐标',width: width*0.1, hidden:true, sortable: false},
            {header: '图片名称', dataIndex:'图片名称',width: width*0.1, hidden:true, sortable: false},
            {header: '详细信息', dataIndex:'详细信息',width: width*0.1, sortable: false,renderer:view},
            {header: '删除',dataIndex:'删除',width: width*0.05, sortable: false,renderer:del}
        ],
          tbar:[
	    		 	 {xtype:'label',text:'快速查找:',width:60},
	    			 {xtype:'textfield',id:'keyword',width:240,emptyText:'请输入查询字段'},
	    			 {xtype: 'button',id:'button',text:'查询',handler: query}
	    ],
        stripeRows: true,
        listeners:{
		       rowdblclick: showDetail
        },
        height: height+40,
        width:width,
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
        
        viewConfig:{//配置GridPanel的显示样式
	    		forceFit : true,
	            getRowClass : function(record,rowIndex,rowParams,store){   
	                //设置数据的显示颜色，并弹出提示信息
	                if(record.data.READFLAG == "0"){   
	                    return 'my_row_Green';
	                }else{
	                	return 'my_row_Gray';
	                }
	            }   
	        }   
    });
     grid.render('mygrid_container'); 				      
})


function view(id){
	return "<a href='#' onclick='showDetail("+id+");return false;'><img src='web/<%=name%>/framework/images/listbutton/view.png' alt='详细信息'></a>";
}
function del(id){
 	return "<a href='#' onclick='delTask("+id+");return false;'><img src='web/<%=name%>/framework/images/listbutton/delete.png' alt='删除'></a>";
}

function delTask(id){
	Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
	  if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName ="pADDataList";
	    var actionMethod ="delPAD";
	    var yw_guid = myData[id][0].trim();
	    var parameter="yw_guid="+yw_guid;
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		document.location.reload();
		}
		else{
		return false;
		}
	});
}


function showDetail(id){
    //alert(myData[id][0]);
    var mes='任务编号：'+myData[id][0];
    mes+='<br>项目名称：'+ myData[id][2];
    mes+='<br>任务类型：'+ myData[id][3];
    mes+='<br>是否违法：'+ myData[id][4];
    mes+='<br>巡查人：'+ myData[id][5]; 
    mes+='<br>巡查日期：'+ myData[id][6];
    var info = mes;	
    var coord = myData[id][8];
    var imgurl = myData[id][9];
	  var path = "<%=basePath%>";
	  var actionName = "pADDataList";
	  var actionMethod = "checkReadFlag";
	  var parmeter="carId="+myData[id][0];
	  var res = ajaxRequest(path,actionName,actionMethod,parmeter); 
    var url = "showTab.jsp?yw_guid="+myData[id][0];     
    var scrWidth = 700;
    var scrHeight = 700;
    var parameter = "dialogWidth="+scrWidth+"px;dialogHeight="+scrHeight+"px;status=no;scroll=yes;";   
    window.showModalDialog(url, "",parameter);
}

function query(){
  var keyWord = Ext.getCmp('keyword').getValue();
    keyWord=escape(escape(keyWord));
    putClientCommond("PADDataList","getQueryData");
    putRestParameter("keyWord",keyWord);
    var myData1 = restRequest(); 
    var width=document.body.clientWidth;
 store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData1),
		remoteSort:true,
        fields: [
           {name: 'READFLAG'},
           {name: 'GUID'},
           {name: 'XZQMC'},
           {name: 'XMMC'},
           {name: 'RWLX'},
            {name: 'XCR'},
           {name: 'SFWF'},
           {name: 'XCRQ'},
           {name: 'CJZB'},
           {name: 'JWZB'},
           {name: 'IMGNAME'}
        ]
    });
    grid.reconfigure(store, new Ext.grid.ColumnModel([
           {header: '任务编号', dataIndex:'GUID', width: width*0.1, sortable: false},
           {header: '所在政区', dataIndex:'XZQMC', width: width*0.1, sortable: false},
           {header: '项目名称', dataIndex:'XMMC',width: width*0.2, sortable: false},
            {header: '任务类型', dataIndex:'RWLX',width: width*0.1, sortable: false},
            {header: '是否违法', dataIndex:'SFWF',width: width*0.1, sortable: false},
            {header: '巡查人', dataIndex:'XCR',width: width*0.05, sortable: false},
           {header: '巡查日期', dataIndex:'XCRQ',width: width*0.1, sortable: false},
            {header: '采集坐标', dataIndex:'CJZB',width: width*0.1, hidden:true, sortable: false},
            {header: '经纬坐标', dataIndex:'JWZB',width: width*0.1, hidden:true, sortable: false},
            {header: '图片名称', dataIndex:'IMGNAME',width: width*0.1, hidden:true, sortable: false},
            {header: '详细信息', dataIndex:'详细信息',width: width*0.1, sortable: false,renderer:view},
            {header: '删除',dataIndex:'删除',width: width*0.05, sortable: false,renderer:del}
        ]));
//重新绑定分页工具栏
 grid.getBottomToolbar().bind(store);
//重新加载数据集
store.load({params:{start:0,limit:15}});  
}
function changKeyword(val){
     var key=Ext.getCmp('keyword').getValue();
     if(key!=''){
       if(val.indexOf(key)>=0){
	  return val.substring(0,val.indexOf(key))+"<font color='red'><b>"+val.substring(val.indexOf(key),val.indexOf(key)+key.length)+"</b></font>"
	   +val.substring(val.indexOf(key)+key.length,val.length);
       }else{
        return val;
       }
     }else{
       return val;
    }
    } 

</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style=""></div>
		<div id="result-win" class="x-hidden">
			<div class="x-window-header">
				详细信息
			</div>
			<div id="result-tabs">
				<div id='properties' class="x-tab" title="信息列表">
				</div>
			</div>
		</div>
	</body>
</html>