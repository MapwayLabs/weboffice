package com.klspta.model.mapconfig;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

@Component
public class MapConfig extends AbstractBaseBean {
    
    public MapConfig(){
    }
    
    public void getMapServices(){
        String sql = "select t.*,w.* from gis_mapservices t, gis_wmts_info w where t.format = w.wmts_id(+) and t.flag=1 order by  t.ranking";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getMapProperties(){
    	String sql = "select t.treename as text,t.serverid||'@'||t.layerid||'@'||t.queryfields||'@'||t.queryfieldsinfo as value from GIS_MAPTREE t where t.parenttreeid not like '0'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getMapExtent(){
        String sql = "select t.*, t.rowid from gis_extent t where t.flag = '1'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getGeometryServices(){
        String sql = "select * from gis_geometryservice t where t.flag = '1'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    private static Map<String, String> wmts = new HashMap<String, String>();
    public void getWMTSServer(){
        String name = request.getParameter("name");
        if(wmts.size() == 0){
            try {
                String sql = "select t.* from gis_wmts_info t";
                List<Map<String,Object>> list = query(sql, CORE);
                Iterator<Map<String, Object>> it = list.iterator();
                while(it.hasNext()){
                    Map<String, Object> map = it.next();
                    wmts.put((String)map.get("WMTS_ID"), UtilFactory.getJSONUtil().objectToJSON(wmts.get(name)));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response(wmts.get(name));
    }
    
    private static Map<String, List<Map<String,Object>>> wmtsinfo = new HashMap<String, List<Map<String,Object>>>();
    public void getWMTSInfo(){
        String name = request.getParameter("name");
        if(wmtsinfo.get(name) == null){
            String sql = "select * from gis_wmts_lods_info t where t.wmts_id = ? order by t.wmts_level";
            List<Map<String,Object>> list = query(sql, CORE, new Object[] {name});
            wmtsinfo.put(name, list);
        }
        try {
            response(UtilFactory.getJSONUtil().objectToJSON(wmtsinfo.get(name)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void getInitMapService(){
    	String enterFlag = request.getParameter("enterFlag");
    	String sql = "";
    	if("map_tree".equals(enterFlag)){
    		sql = "select t.serverid,t.layerid,t.type, (case t.checked  when '1' then 'true' when '0' then 'false' end) flag from GIS_MAPTREE t where t.parenttreeid not like '0' and t.flag = '1'";
    	}
    	if("map_monitor".equals(enterFlag)){
    		sql = "select t.serverid,t.layerid,t.type, (case g.opacity  when '1' then 'true' when '0' then 'false' end) flag from GIS_MAPSERVICES g,GIS_MAPTREE t "+
    			"where t.parenttreeid not like '0' and t.flag = '1' and g.id = t.serverid";
    	}
        List<Map<String,Object>> list = query(sql,CORE);
        response(list);
    }
}
