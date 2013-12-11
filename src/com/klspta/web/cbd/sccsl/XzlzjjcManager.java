package com.klspta.web.cbd.sccsl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.xml.crypto.Data;

import com.klspta.base.AbstractBaseBean;

public class XzlzjjcManager extends AbstractBaseBean {

	public List<Map<String,Object>> getXZLData(){
		String sql = "select t.*,k.zj,k.sj from xzlxx t left join xzlzjqk k on t.bh=k.bh and k.year=? and k.month=? ";
		Calendar cal = Calendar.getInstance();
	    String month = cal.get(Calendar.MONTH) + 1+"";
	    String year = cal.get(Calendar.YEAR)+"";
		List<Map<String,Object>> result = query(sql, YW,new Object[]{year,month});
		return result;
	}
	
	public Map<String,Object> getXZLData(String bh){
		List<Map<String,Object>> result = null;
		Calendar cal = Calendar.getInstance();
		String month = cal.get(Calendar.MONTH) + 1+"";
	    String year = cal.get(Calendar.YEAR)+"";
		String sql = "select * from xzlzjqk where bh='"+bh +"' and year='"+year+"' and month='"+month+"'";
		if(query(sql, YW).size()>0){
			sql = "select t.*,k.zj,k.sj from xzlxx t , xzlzjqk k where " +
				" t.bh=k.bh and k.year=? and k.month=? and  t.bh='"+bh+"'";
			result = query(sql, YW,new Object[]{year,month});
		}else {
			sql = "select * from xzlxx where bh='"+bh+"'";
			result = query(sql, YW);
			for (int i = 0; i < result.size(); i++) {
				 result.get(i).put("ZJ", null);
				 result.get(i).put("SJ", null);
		    }
		}
		
		if(result.size()>0){
			return result.get(0);
		}
		return null;
	}
	
	
	public void getXZL(){
		List<Map<String,Object>> result = getXZLData();
		for (int i = 0; i < result.size(); i++) {
			 result.get(i).put("XIANGXI", i);
	    }
		response(result);
	}
	
	
	public void saveXzlzj(){
		String zj = request.getParameter("zj");
		String sj = request.getParameter("sj");
		String bh =request.getParameter("bh");
		String xzlmc =request.getParameter("xzlmc");
		StringBuffer sql = new StringBuffer();
		String year = Calendar.getInstance().get(Calendar.YEAR)+"";
		String month = Calendar.getInstance().get(Calendar.MONTH)+1+"";
		sql.append("merge into xzlzjqk j using(select distinct '");
		sql
				.append(year)
				.append("' as nd,'")
				.append(month)
				.append(
						"' as jd from xzlzjqk t ) t2 on (j.year=t2.nd and j.month = t2.jd and j.bh=?) when matched then ");
		sql
				.append("update set j.zj=? , j.sj =? when not matched then insert(j.bh,j.xzlmc,j.year, j.month, j.zj,j.sj)");
		sql.append(" values(?,?,?, ?, ?,?)");
		update(sql.toString(), YW, new Object[] {bh, zj,sj,bh,xzlmc, year, month, zj,sj });
		response("true");
	}
}