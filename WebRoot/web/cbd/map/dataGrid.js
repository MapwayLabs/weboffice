Ext.onReady(function() {
			// 地块数据表格
			var dkForm = getDKForm();
			// 项目数据表格
			var xmForm = getXMForm();
			// TAB
			var tabs = new Ext.TabPanel({
						renderTo : Ext.getBody(),
						width : 295,
						activeTab : 0,
						frame : true,
						defaults : {
							autoHeight : true
						},
						items : [dkForm, xmForm]
					});
		});

// 地块表格
function getXMForm() {
	var myData = [
			[
					'联合大学商学院项目',
					6,
					'{\"rings\":[[[116.46359855661164,39.91159999740073],[116.46486455929028,39.91158926856447],[116.46495038998036,39.910688046318654],[116.46357709893911,39.910730961663695]]]}'],
			[
					'国华热电厂项目一期',
					4,
					'{\"rings\":[[[116.46585161222619,39.91092408071634],[116.46629149451284,39.9109348095526],[116.4663022233491,39.91070950399115],[116.46585161222619,39.91070950399115]]]}'],
			[
					'首经贸大学项目',
					8,
					'{\"rings\":[[[116.46585161222619,39.91092408071634],[116.46629149451284,39.9109348095526],[116.4663022233491,39.91070950399115],[116.46585161222619,39.91070950399115]]]}'],
			[
					'国华热电厂项目二期',
					7.5,
					'{\"rings\":[[[116.46359855661164,39.91159999740073],[116.46486455929028,39.91158926856447],[116.46495038998036,39.910688046318654],[116.46357709893911,39.910730961663695]]]}'],
			[
					'公交总公司项目',
					4,
					'{\"rings\":[[[116.46359855661164,39.91159999740073],[116.46486455929028,39.91158926856447],[116.46495038998036,39.910688046318654],[116.46357709893911,39.910730961663695]]]}']];
	var store = new Ext.data.ArrayStore({
				fields : [{
							name : 'c1'
						}, {
							name : 'c2'
						}, {
							name : 'c3'
						}]
			});
	store.loadData(myData);
	var grid = new Ext.grid.GridPanel({
				store : store,
				title : '项目数据',
				width : 300,
				columns : [{
							id : 'id',
							header : '项目名称',
							width : 160,
							sortable : true,
							dataIndex : 'c1'
						}, {
							header : '规划数据(公顷、万㎡)',
							width : 160,
							sortable : true,
							dataIndex : 'c2'
						}],
				listeners : {
					rowclick : function(grid, rowIndex, e) {
						// showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
						// viewDetail(grid.getStore().getAt(rowIndex).data.RUNNUM1);
						locator(grid.getStore().getAt(rowIndex).data.c3);
						// locator();
					}
				},
				stripeRows : true,
				stateful : true,
				stateId : 'grid'
			});
	return grid;
}
// 项目表格
function getDKForm() {
	var myData = [
			[
					'C1区',
					1,
					'{\"rings\":[[[116.46359855661164,39.91159999740073],[116.46486455929028,39.91158926856447],[116.46495038998036,39.910688046318654],[116.46357709893911,39.910730961663695]]]}'],
			[
					'D2区（联大）',
					3,
					'{\"rings\":[[[116.45682796760855,39.931685736385006],[116.45781502054443,39.93171792289379],[116.45780429170817,39.93164282103997],[116.45681723877229,39.931578448022414]]]}'],
			[
					'SE10-1',
					2,
					'{\"rings\":[[[116.46585161222619,39.91092408071634],[116.46629149451284,39.9109348095526],[116.4663022233491,39.91070950399115],[116.46585161222619,39.91070950399115]]]}'],
			[
					'A1区',
					3,
					'{\"rings\":[[[116.45682796760855,39.931685736385006],[116.45781502054443,39.93171792289379],[116.45780429170817,39.93164282103997],[116.45681723877229,39.931578448022414]]]}'],
			[
					'SE10-1',
					4,
					'{\"rings\":[[[116.46585161222619,39.91092408071634],[116.46629149451284,39.9109348095526],[116.4663022233491,39.91070950399115],[116.46585161222619,39.91070950399115]]]}']];
	var store = new Ext.data.ArrayStore({
				fields : [{
							name : 'c1'
						}, {
							name : 'c2'
						}, {
							name : 'c3'
						}]
			});
	store.loadData(myData);
	var grid = new Ext.grid.GridPanel({
				store : store,
				title : '地块数据',
				width : 300,
				columns : [{
							id : 'id',
							header : '地块名称',
							width : 160,
							sortable : true,
							dataIndex : 'c1'
						}, {
							header : '规划数据(公顷、万㎡)',
							width : 160,
							sortable : true,
							dataIndex : 'c2'
						}],
				listeners : {
					rowclick : function(grid, rowIndex, e) {
						// showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
						// viewDetail(grid.getStore().getAt(rowIndex).data.RUNNUM1);
						locator(grid.getStore().getAt(rowIndex).data.c3);
						// locator();
					}
				},
				stripeRows : true,
				stateful : true,
				stateId : 'grid'
			});
	return grid;
}
// 定位
function locator(json) {
	// "{\"rings\":[[[116.46359855661164,39.91159999740073],[116.46486455929028,39.91158926856447],[116.46495038998036,39.910688046318654],[116.46357709893911,39.910730961663695]]]}"
	parent.frames["center"].frames["lower"].swfobject.getObjectById("FxGIS")
			.doLocation(json);
}
