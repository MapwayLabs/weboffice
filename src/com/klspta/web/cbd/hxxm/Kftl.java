package com.klspta.web.cbd.hxxm;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:开发体量
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-10
 */
@Component
public class Kftl extends AbstractBaseBean {
    /**
     * 
     * <br>Description:新增开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void add() {
        String xmbh = request.getParameter("xmbh");
        String xmmc = request.getParameter("xmmc");
        String year = request.getParameter("year");
        String season = request.getParameter("season");
        String hs = request.getParameter("hs");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String tz = request.getParameter("tz");
        String z = request.getParameter("z");
        String q = request.getParameter("q");
        String lm = request.getParameter("lm");
        String cj = request.getParameter("cj");
        String sql = "insert into hx_kftl(xmmc,nd,jd,hs,dl,gm,tz,zhu,qi,lm,cj,xmguid) values(?,?,?,?,?,?,?,?,?,?,?,?)";
        int flag = update(sql, YW, new Object[] { xmmc, year, season, hs, dl, gm, tz, z, q,lm,cj,xmbh});
        if (flag == 1) {
            sql = "select kftl from hx_sssx where nd=? and jd=?";
            List<Map<String, Object>> list = query(sql, YW, new Object[] { year, season });
            if (list.size() > 0) {
                String kftls=list.get(0).get("kftl").toString();
                if(kftls.indexOf(xmbh)<0){
                    StringBuffer sb=new StringBuffer(kftls);
                    sql="update hx_sssx set kftl =? where nd=?,jd=?";
                    if(sb.length()>0){
                        sb.append(",").append(xmbh);
                    }else{
                        sb.append(xmbh);
                    }
                     update(sql,YW,new Object[]{sb.toString(),year,season}); 
                }
            }else{
                sql="insert into hx_sssx(nd,jd,kftl) values(?,?,?)";
                update(sql,YW,new Object[]{year,season,xmbh});
            }
        }
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:更新开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void update() {
        String kfbh = request.getParameter("kfbh");
        String year = request.getParameter("year");
        String season = request.getParameter("season");
        String hs = request.getParameter("hs");
        String dl = request.getParameter("dl");
        String gm = request.getParameter("gm");
        String tz = request.getParameter("tz");
        String z = request.getParameter("z");
        String q = request.getParameter("q");
        String lm = request.getParameter("lm");
        String cj = request.getParameter("cj");
        String sql = "update hx_kftl set nd=?,jd=?,hs=?,dl=?,gm=?,tz=?,zhu=?,qi=?,lm=?,cj=? where yw_guid=?";
        int flag = update(sql, YW, new Object[] { year, season, hs, dl, gm, tz, z, q,lm,cj, kfbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:删除开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void delete() {
        String kfbh = request.getParameter("kfbh");
        String sql = "delete from hx_kftl where yw_guid=?";
        int flag = update(sql, YW, new Object[] { kfbh });
        if (flag == 0) {
            response("{success:false}");
        } else {
            response("{success:true}");
        }
    }

    /**
     * 
     * <br>Description:开发体量查询
     * <br>Author:陈强峰
     * <br>Date:2013-10-11
     */
    public void query() {
        String xmbh = request.getParameter("xmbh");  
        String sql="select xmmc,nd||'-'||jd as sx,dl,hs,gm,tz,zhu as z,qi as q,lm,cj,rownum-1 as mod,rownum-1 as del,yw_guid  as kfbh from hx_kftl where xmguid=?";
        List<Map<String,Object>> list=query(sql,YW,new Object[]{xmbh});
        response(list);
     }
}
