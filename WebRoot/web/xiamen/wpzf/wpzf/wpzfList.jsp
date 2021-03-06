<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>土地变更调查全部数据</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript">
		var myData;
		var width;
		var height;
		var store;
		var grid;
		var limitNum;
		Ext.onReady(function(){
	  		putClientCommond("tdbgdc","getqb");
			myData = restRequest();			
			width = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			limitNum = parseInt(height/24);			
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
						{name:'YW_GUID'},
						{name:'XZDM'},
						{name:'TBBH'},
						{name:'TBLX'},
						{name:'XZB'},
						{name:'YZB'},
						{name:'QSX'},
						{name:'HSX'},
						{name:'JCMJ'},
						{name:'YGSPMJ'},
						{name:'YGSPBL'},
						{name:'YGGDMJ'},
						{name:'YGGDBL'},
						{name:'NYDMJ'},
						{name:'GDMJ'},
						{name:'JSYDMJ'},
						{name:'WLYDMJ'},
						{name:'YXJSQ'},
						{name:'YTJJSQ'},
						{name:'XZJSQ'},
						{name:'JZJSQ'},
						{name:'FHGHMJ'},
						{name:'BFHGHMJ'},
						{name:'ZYJBNTMJ'}												
					]
			});
			store.load({params:{start:0, limit:limitNum}});
			sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
			var districtStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '350200'
						},{
							name : '350201'
						},{
							name : '350202'
						}]
			});
			var tblxStore = new Ext.data.JsonStore({
				fields : ['name'],
				data : [{
							name : '1'
						},{
							name : '2'
						},{
							name : '3'
						}]
			});	
				
			grid = new Ext.grid.GridPanel({
		        store: store,
		        sm:sm,
		        columns: [
		        new Ext.grid.RowNumberer(),
		        sm,
		        {header: '业务编号', dataIndex:'YW_GUID', width: width*0.1 , sortable: true,hidden:true},
				{header: '行政代码', dataIndex:'XZDM', width: width*0.1 , sortable: true},		
				{header: '图斑编号', dataIndex:'TBBH', width: width*0.1, sortable: true},
				{header: '图斑类型', dataIndex:'TBLX', width: width*0.1,sortable: true},
				{header: '中心X坐标', dataIndex:'XZB', width: width*0.1, sortable: true},		
				{header: '中心Y坐标', dataIndex:'YZB', width: width*0.1, sortable: true},
				{header: '前时相', dataIndex:'QSX', width: width*0.1,sortable: true},
				{header: '后时相', dataIndex:'HSX', width: width*0.1, sortable: true},		
				{header: '监测面积', dataIndex:'JCMJ', width: width*0.1, sortable: true},
				{header: '压盖审批面积', dataIndex:'YGSPMJ', width: width*0.1,sortable: true},
				{header: '压盖审批比率', dataIndex:'YGSPBL', width: width*0.1, sortable: true},		
				{header: '压盖供地面积', dataIndex:'YGGDMJ', width: width*0.1, sortable: true},
				{header: '压盖供地比率', dataIndex:'YGGDBL', width: width*0.1, sortable: true},
				{header: '农用地面积', dataIndex:'NYDMJ', width: width*0.1, sortable: true},		
				{header: '耕地面积', dataIndex:'GDMJ', width: width*0.1, sortable: true},
				{header: '建设用地面积', dataIndex:'JSYDMJ', width: width*0.1,sortable: true},
				{header: '未利用地面积', dataIndex:'WLYDMJ', width: width*0.1, sortable: true},		
				{header: '允许建设区', dataIndex:'YXJSQ', width: width*0.1, sortable: true},
				{header: '有条件建设区', dataIndex:'YTJJSQ', width: width*0.1,sortable: true},
				{header: '限制建设区', dataIndex:'XZJSQ', width: width*0.1, sortable: true},		
				{header: '禁止建设区', dataIndex:'JZJSQ', width: width*0.1, sortable: true},
				{header: '符合规划面积', dataIndex:'FHGHMJ', width: width*0.1,sortable: true},
				{header: '不符合规划面积', dataIndex:'BFHGHMJ', width: width*0.1, sortable: true},		
				{header: '占用基本农田面积', dataIndex:'ZYJBNTMJ', width: width*0.1, sortable: true}																										
		        ],  
		        tbar:[
	    			   {
							xtype : 'label',
							text : '行政区：'
						}, {
							id : 'district',
							xtype : 'combo',
							width :80,
							store : districtStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						}, '-',{
							xtype : 'label',
							text : '图斑类型：'
						}, {
							id : 'tblx',
							xtype : 'combo',
							width :80,
							store : tblxStore,
							displayField : 'name',
							typeAhead : true,
							mode : 'local',
							triggerAction : 'all',
							selectOnFocus : true
						},'-',{
							xtype : 'label',
							text : '监测面积：'
						},{xtype:'textfield',id:'jcmj1',width:50},{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'jcmj2',width:50},						
						'-',{
							xtype : 'label',
							text : '压盖审批面积：'
						},{xtype:'textfield',id:'ygspmj1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'ygspmj2',width:50},																
						'-',{
							xtype : 'label',
							text : '压盖供地面积：'
						},{xtype:'textfield',id:'yggdmj1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'yggdmj2',width:50}
			    ], 
			    listeners:{
		  			rowclick : function(grid, rowIndex, e)
					{
						
					}
        		},
		        stripeRows: true,
		        width:width,
		        height: height-30 ,
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'right',
		        bbar: new Ext.PagingToolbar({
			        pageSize: limitNum,
			        store: store,
			        displayInfo: true,
			            displayMsg: '共{2}条，当前为：{0} - {1}条',
			            emptyMsg: "无记录",
			        plugins: new Ext.ux.ProgressBarPager()
		        }),
		        buttons: [{
		        	text:'导出Excel',
		        	handler: expExcel
		        }]
        	});         	 				
			grid.render('mygrid_container');
			this.tb = new Ext.Toolbar({
				renderTo : grid.tbar,
				items : [{
							xtype : 'label',
							text : '压盖审批比率：'
						},{xtype:'textfield',id:'ygspbl1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'ygspbl2',width:50},																
						'-',{
							xtype : 'label',
							text : '压盖供地比率：'
						},{xtype:'textfield',id:'yggdbl1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'yggdbl2',width:50},
						'-',{
							xtype : 'label',
							text : '农用地面积：'
						},{xtype:'textfield',id:'nydmj1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'nydmj2',width:50},
						'-',{
							xtype : 'label',
							text : '符合规划面积：'
						},{xtype:'textfield',id:'fhghmj1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'fhghmj2',width:50},																		
						'-',{
							xtype : 'label',
							text : '不符合规划面积：'
						},{xtype:'textfield',id:'bfhghmj1',width:50},
						{
							xtype : 'label',
							text : '—'
						},{xtype:'textfield',id:'bfhghmj2',width:50},																		
						'-',
	    			{xtype: 'button',text:'查询',handler: query}
	    			]

			});	 			
	});

	//导出Excel
	function expExcel(){
		downloadViewData(grid);	
	}
	
	function downloadViewData(grid){
	try {
		var xls = new ActiveXObject("Excel.Application");
		} catch (e) {
			alert("要打印该表，您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。 请点击【帮助】了解浏览器设置方法！");
			return "";  
		}
		var cm = grid.getColumnModel();
   		var colCount = cm.getColumnCount();   
   		//alert('总列数：'+colCount);
   		xls.visible = true; // 设置excel为可见
   		var xlBook = xls.Workbooks.Add;
   		var xlSheet = xlBook.Worksheets(1);    
   		var temp_obj = [];
   		// 只下载没有隐藏的列(isHidden()为true表示隐藏,其他都为显示)    
   		for (i = 2; i < colCount; i++) {
    		if (cm.isHidden(i) == true) {
    		} else {
     		temp_obj.push(i);   
     		}
   		}
   			for (l = 1; l <= temp_obj.length; l++) {
    			xlSheet.Cells(1, l).Value = cm.getColumnHeader(temp_obj[l-1]); 
   			}
    			var store = grid.getStore();
   				var recordCount = store.getCount();
   				//alert("记录总数："+recordCount);
   				//alert('总列数：'+temp_obj.length);
   				var view = grid.getView();
   				for (k = 1; k <= recordCount; k++) {
   					//alert('k-'+k);
    				for (j = 1; j <= temp_obj.length; j++) {
     				// EXCEL数据从第二行开始,故row = k + 1;
    				//alert(view.getCell(k - 1, temp_obj[j- 1]).innerText);
     				xlSheet.Cells(k + 1, j).Value = view.getCell(k - 1, temp_obj[j- 1]).innerText; 
     				}
   					
				}
				xlSheet.Columns.AutoFit;
   				xls.ActiveWindow.Zoom = 75;
   				xls.UserControl = true; // 很重要,不能省略,不然会出问题 意思是excel交由用户控制
   				xls = null;
   				xlBook = null;
   				xlSheet = null;
	}	
		
    function query(){
         //var keyWord=Ext.getCmp('keyword').getValue();
		 //putClientCommond("tdbgdc","getqb");
         //putRestParameter("keyword",escape(escape(keyWord)));
         var myData = []//restRequest(); 
         store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
			fields:[
				{name:'YW_GUID'},
				{name:'XZDM'},
				{name:'TBBH'},
				{name:'TBLX'},
				{name:'XZB'},
				{name:'YZB'},
				{name:'QSX'},
				{name:'HSX'},
				{name:'JCMJ'},
				{name:'YGSPMJ'},
				{name:'YGSPBL'},
				{name:'YGGDMJ'},
				{name:'YGGDBL'},
				{name:'NYDMJ'},
				{name:'GDMJ'},
				{name:'JSYDMJ'},
				{name:'WLYDMJ'},
				{name:'YXJSQ'},
				{name:'YTJJSQ'},
				{name:'XZJSQ'},
				{name:'JZJSQ'},
				{name:'FHGHMJ'},
				{name:'BFHGHMJ'},
				{name:'ZYJBNTMJ'}			
			]
	});
        grid.reconfigure(store, new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
		    sm,
	        {header: '业务编号', dataIndex:'YW_GUID', width: width*0.1 , sortable: true,hidden:true},
			{header: '行政代码', dataIndex:'XZDM', width: width*0.1 , sortable: true},		
			{header: '图斑编号', dataIndex:'TBBH', width: width*0.1, sortable: true},
			{header: '图斑类型', dataIndex:'TBLX', width: width*0.1,sortable: true},
			{header: '中心X坐标', dataIndex:'XZB', width: width*0.1, sortable: true},		
			{header: '中心Y坐标', dataIndex:'YZB', width: width*0.1, sortable: true},
			{header: '前时相', dataIndex:'QSX', width: width*0.1,sortable: true},
			{header: '后时相', dataIndex:'HSX', width: width*0.1, sortable: true},		
			{header: '监测面积', dataIndex:'JCMJ', width: width*0.1, sortable: true},
			{header: '压盖审批面积', dataIndex:'YGSPMJ', width: width*0.1,sortable: true},
			{header: '压盖审批比率', dataIndex:'YGSPBL', width: width*0.1, sortable: true},		
			{header: '压盖供地面积', dataIndex:'YGGDMJ', width: width*0.1, sortable: true},
			{header: '压盖供地比率', dataIndex:'YGGDBL', width: width*0.1, sortable: true},
			{header: '农用地面积', dataIndex:'NYDMJ', width: width*0.1, sortable: true},		
			{header: '耕地面积', dataIndex:'GDMJ', width: width*0.1, sortable: true},
			{header: '建设用地面积', dataIndex:'JSYDMJ', width: width*0.1,sortable: true},
			{header: '未利用地面积', dataIndex:'WLYDMJ', width: width*0.1, sortable: true},		
			{header: '允许建设区', dataIndex:'YXJSQ', width: width*0.1, sortable: true},
			{header: '有条件建设区', dataIndex:'YTJJSQ', width: width*0.1,sortable: true},
			{header: '限制建设区', dataIndex:'XZJSQ', width: width*0.1, sortable: true},		
			{header: '禁止建设区', dataIndex:'JZJSQ', width: width*0.1, sortable: true},
			{header: '符合规划面积', dataIndex:'FHGHMJ', width: width*0.1,sortable: true},
			{header: '不符合规划面积', dataIndex:'BFHGHMJ', width: width*0.1, sortable: true},		
			{header: '占用基本农田面积', dataIndex:'ZYJBNTMJ', width: width*0.1, sortable: true}			
        ]));
        	//重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);
	//重新加载数据集
	store.load({params:{start:0,limit:limitNum}}); 
   }

</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
</body>
</html>
