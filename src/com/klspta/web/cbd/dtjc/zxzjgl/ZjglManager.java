package com.klspta.web.cbd.dtjc.zxzjgl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.web.cbd.xmgl.zjgl.ZjglData; 

public class ZjglManager extends AbstractBaseBean{
	

	private static ZjglManager zjglManager;

    public static ZjglManager getInstcne() {
        if (zjglManager == null) {
        	zjglManager = new ZjglManager();
        }
        return zjglManager;
    }
	public void getList(){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select distinct t.xmname from jc_xiangmu t left join XMZJGL_ZC j on t.yw_guid = j.yw_guid ");
		List<Map<String, Object>> list = query(sqlBuffer.toString(), YW);
		response(list);
	}
	

    public void selectYear(){
        String year = request.getParameter("year");
        StringBuffer buffer = new CBDReportManager().getReport("ZXSYQK", new Object[] { year,"false" });
        response(buffer.toString());
    }
    public void getReport(){
		String xmname = request.getParameter("xmname");
		xmname=UtilFactory.getStrUtil().unescape(xmname);
		 
			 String sql =" select t.yw_guid from jc_xiangmu t where t.xmname = '"+xmname+"'";
			 List<Map<String, Object>> list = query(sql, YW);
			 String yw_guid = (String) list.get(0).get("yw_guid");
			 String year = Calendar.getInstance().get(Calendar.YEAR) + "";
			 new ZjglData().setMXZC(yw_guid, year);
			 StringBuffer buffer = new CBDReportManager().getReport("XMCBZJ", new Object[] { xmname,"false" });
			 response(buffer.toString());
		 
	}
    
}
