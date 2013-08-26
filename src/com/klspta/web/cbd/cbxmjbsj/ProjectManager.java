package com.klspta.web.cbd.cbxmjbsj;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:基本项目信息管理
 * <br>Description:基本项目信息管理
 * <br>Author:姚建林
 * <br>Date:2013-8-20
 */
public class ProjectManager extends AbstractBaseBean {
	
	String url = "";
	
	/**
	 * 
	 * <br>Title:根据项目id获得所属地块
	 * <br>Description:根据项目id获得所属地块
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public List<Map<String, Object>> getLandsByProjectID(String projectid){
		String sql = "select t.dkname,t.yw_guid from dkinfo t where t.projectid = ?";
		List<Map<String, Object>> result = query(sql, YW, new Object[]{projectid});
		return result;
	}
	
	/**
	 * 
	 * <br>Title:根据地块列表拼接json
	 * <br>Description:根据地块列表拼接json
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public String getDkJsonByList(List<Map<String, Object>> list) {
		if (list == null || list.size() == 0){
			return "[['','']]";
		}
		
		StringBuffer sb = new StringBuffer("[");
		
		for (int i = 0; i < list.size(); i++) {
			if (sb.length() > 1)
				sb.append(",");
			sb.append("['");
			sb.append(list.get(i).get("dkname"));
			sb.append("','");
			sb.append(list.get(i).get("yw_guid"));
			sb.append("']");
		}
		sb.append("]");
		return sb.toString();
	}
	
	/**
	 * 
	 * <br>Title:根据项目id获得地块
	 * <br>Description:根据项目id获得地块
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public String getSelectDkJsonByProjectID(String projectid) {
		List<Map<String, Object>> list = getLandsByProjectID(projectid);
		return getDkJsonByList(list);
	}
	
	/**
	 * 
	 * <br>Title:获得其他地块
	 * <br>Description:获得其他地块
	 * <br>Author:姚建林
	 * <br>Date:2013-8-20
	 */
	public String getDkInfoArrayJsonByProjectID() {
		//得到所有的地块信息
		String sql = "select t.dkname,t.yw_guid from dkinfo t where t.projectid is null";
		List<Map<String, Object>> result = query(sql, YW);
		return getDkJsonByList(result);
	}
	
	public void saveProject()throws Exception{
		String yw_guid = request.getParameter("yw_guid");
		String values = request.getParameter("values");
		String xmname = UtilFactory.getStrUtil().unescape(request.getParameter("xmname"));
		url = request.getHeader("referer");
		String[] tempStrings = url.split(".jsp");
		url = tempStrings[0];
		if(!"".equals(values)){//去掉最前面无用的分隔符
			if(",".equals(values.charAt(0))){//如果第一个字符为,
				values = values.substring(1, values.length());
			}
		}
		String[] strvalues = values.split(",");
		if(yw_guid == null || "null".equals(yw_guid)){
			yw_guid= UtilFactory.getStrUtil().getGuid();
			String insertSql = "insert into xminfo(yw_guid,xmname) values(?,?)";
			update(insertSql, YW, new Object[]{yw_guid,xmname});
		}
		addDkProjectMap(yw_guid,strvalues);
		response(url + ".jsp?yw_guid=" + yw_guid);
	}
	
	public boolean addDkProjectMap(String projectid, String[] values){
		// 删除原有的项目、地块关系
		String sqldel = "update dkinfo t set t.projectid = '' where t.projectid = ?";
		update(sqldel, YW, new Object[]{projectid});
		// 添加新的项目、地块关系
		String sqladd = "update dkinfo t set t.projectid = ? where t.yw_guid = ?";
		for (int i = 0; i < values.length; i++) {
			update(sqladd, YW, new Object[]{projectid,values[i]});
		}
		//更新重新确定项目、地块关系后的项目表
		String sqlupd = null;
		if(values.length == 1 && "".equals(values[0])){
			sqlupd = "update xminfo t set t.zd = '',t.gm = '',t.hs = '',t.cb = '',t.zzcqfy = '',t.qycqfy = '',t.qtfy = '',t.azftzcb = '',t.zzhbtzcb = '',t.cqhbtz = '',t.qtfyzb = '',t.lmcb = '',t.lmcjj = '',t.fwsj = '',t.zj = '',t.pgtdjz = '',t.tyl = '',t.rzss = ''where t.yw_guid = ?";
			update(sqlupd,YW,new Object[]{projectid});
		}else{
			sqlupd = "update xminfo x"+
						" set (x.zd,x.gm,x.hs,x.cb) = (select sum(t.ghzd),sum(t.ghjzgm),sum(t.cqzzzshs),sum(t.cbsykfcb) from dkinfo t where x.yw_guid = t.projectid)"+
						" where x.yw_guid in(select projectid from dkinfo)";
			update(sqlupd,YW);
		}
		return true;
	}
}
