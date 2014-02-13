var dkmc = "";
var num = 0;

var table = new tableoper();
//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("TDZCGL"));
	}
	//alert("showMap");
	var key = objid.cells[1].innerText;
	table.addAnnotation(objid.rowIndex);
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	
}

//双击编辑地图
function editMap(objid){
	
	if(table.element == undefined){
		table.init(document.getElementById("TDZCGL"));
	}
	var key = objid.cells[1].innerText;
	dkmc = key;
	var array = paneloper2.getElements();
	for(var i = 0; i < objid.cells.length; i++){
		var value = objid.cells[i].innerText;	
		paneloper2.insertValue(array[i+2], value);
	}
	form2.findById('xmmc').setDisabled(true);  

	//Ext.getCmp("xmmc").getEl().dom.readOnly= true;
	paneloper2.show();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("TDZCGL"); 
    try{
    	var oXL = new ActiveXObject("Excel.Application");
    }catch(err){
    	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
    	return;
    } 
    //创建AX对象excel 
    var oWB = oXL.Workbooks.Add(); 
    //获取workbook对象 
        var oSheet = oWB.ActiveSheet; 
    //激活当前sheet 
    var sel = document.body.createTextRange(); 
    sel.moveToElementText(curTbl); 
    //把表格中的内容移到TextRange中 
    sel.select(); 
    //全选TextRange中内容 
    sel.execCommand("Copy"); 
    //复制TextRange中内容  
    oSheet.Paste(); 
    //粘贴到活动的EXCEL中       
    oXL.Visible = true; 
    //设置excel可见属性 
}


function add(){
	form2.findById('xmmc').setDisabled(false);  
	form2.findById('dkmc').setDisabled(false);  
	paneloper2.show();
	var xmarray = new Array();
	putClientCommond("hxxmHandle","getHxxmmc");
	var hxxmmc = restRequest();
	if(xmarray.length>0){
		xmarray=[];
	}
	for(var i=0;i<hxxmmc.length;i++ ){
		xmarray.push(hxxmmc[i].XMNAME);
	}
	form2.findById('xmmc').store.loadData(xmarray);
	
	
	var dkarray = new Array();
	putClientCommond("hxxmHandle","getdkmc");
	hxxmmc = restRequest();
	if(dkarray.length>0){
		dkarray=[];
	}
	for(var i=0;i<hxxmmc.length;i++ ){
		dkarray.push(hxxmmc[i].DKMC);
	}
	form2.findById('dkmc').store.loadData(dkarray);
	
	if(table.element == undefined){
		table.init(document.getElementById("TDZCGL"));
	}
	
}

function dele(){
	alert("dele");
}

//根据用地单位和关键字作过滤
function queryZrb(keyword){
	putClientCommond("zrbHandle","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	putRestParameter("type","reader");
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
}

function modify(){
	var annoations = table.getAnnotations();
	if(annoations.length > 0){
		var objid = table.element.rows[annoations[0]];
		editMap(objid);
	}
}
