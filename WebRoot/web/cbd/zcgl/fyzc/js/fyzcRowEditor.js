var dkmc = "";
var num = 0;

var table = new tableoper();
//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("FYZC"));
	}
	//alert("showMap");
	var key = objid.cells[1].innerText;
	table.addAnnotation(objid.rowIndex);
	
}

//双击编辑地图
function editMap(objid){
	
	if(table.element == undefined){
		table.init(document.getElementById("FYZC"));
	}
	var key = objid.cells[1].innerText;
	dkmc = key;
	var array = paneloper2.getElements();
	for(var i = 0; i < objid.cells.length; i++){
		var value = objid.cells[i].innerText;	
		paneloper2.insertValue(array[i], value);
	}
	paneloper2.show();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("FYZC"); 
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
	showWindow();
}

function dele(){
	showWindow_del();
//	Ext.MessageBox.confirm('确认', '系统将删除所有选中房源资产，确定?', function(btn,text){
//		if(btn == 'yes'){
//			var choseValue = table.getAnnotations();
//			var choseString = '';
//			while(choseValue.length != 0){
//				var row = choseValue.pop();
//				var col = (table.element.rows[row].cells.length-1)+"";
//				//var rows = table.element.rows[row];
//				
//				//alert(rows.length);
//				//choseString += table.element.rows[row].cells[col].innerText + ",";
//				choseString += table.getValue(row,col)+ ",";
//			}
//			//alert(choseString);
//			putClientCommond("fyzcHandle","delByYwGuid");
//			putRestParameter("yw_guid",escape(escape(choseString)));
//			myData = restRequest();
//			if(myData){
//				Ext.MessageBox.alert('提醒', '删除成功！', function(btn, text){
//					document.location.reload();
//					return;
//				});
//			}else{
//				Ext.MessageBox.alert('提醒', '删除失败，请联系管理员或重试', function(btn, text){
//					return;
//				});
//			}
//			
//		}
//	});
}

//根据用地单位和关键字作过滤
function queryZrb(keyword){
	putClientCommond("fyzcHandle","quryKeyWord");
	putRestParameter("keyword",escape(escape(keyword)));
	//putRestParameter("type","reader");
	var thisData = restRequest();
  	document.getElementById("show").innerHTML = thisData;
}

function modify(){
	showModifyWindow();
}


