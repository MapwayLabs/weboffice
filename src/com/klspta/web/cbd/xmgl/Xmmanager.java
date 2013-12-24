package com.klspta.web.cbd.xmgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.xmgl.zjgl.ZjglData;

public class Xmmanager extends AbstractBaseBean {
   public static  String  ZJGL_LR[]={"LB","YSFY","LJ","YFSDZ","ZJJD","CQYE","YY","EY","SANY","SIY","WY","LY","QY","BAY","JY","SIYUE","SYY","SEY","LRSP"};
   public static  String  ZJGL_ZC[]={"LB","YSFY","LJ","JL2","YFSDZ","ZJJD","CQYE","YY","EY","SANY","SIY","WY","LY","QY","BAY","JY","SIYUE","SYY","SEY","LRSP"};
    public static String ZJGL_ZJZC;
    public static Xmmanager instens;
    private Xmmanager(){}
    
    public static Xmmanager getXmmanager(){
        if (instens==null){
            return new Xmmanager ();
        }else{
            return  instens;
        }
    }
    /***
     * 
     * <br>Description:刷新缓存
     * <br>Author:朱波海
     * <br>Date:2013-12-17
     */
    public void refresh(){
        
        
    }
    public void init(){
     // ArrayList<?> arrayList = new ArrayList<?>();
        //获取全部支出yw_guid
        String  sql="select distinct yw_guid  from  xmzjgl where status='zc'";
        List<Map<String, Object>> list = query(sql, YW);
        //t.zcstatus 
        for (int i=0;i<list.size();i++){
            String yw_guid = list.get(i).get("yw_guid").toString();
            //一个项目的所有lb
            String lxsql="select distinct lb  from  xmzjgl where status='zc' and yw_guid=?";
            List<Map<String, Object>> lblist = query(lxsql, YW,new Object []{yw_guid});
            for(int j=0;j<lblist.size();j++){
                
                
            }
            
        }
        
        
        
    }
   /***
    * 
    * <br>Description:项目管理中——办理过程
    * <br>Author:朱波海
    * <br>Date:2013-12-16
    */
    public  List<Map<String, Object>> getBLGC(String yw_guid){
      //String yw_guid = request.getParameter("yw_GUID");
      String sql="select * from xmblgc where yw_guid=? ";
      List<Map<String, Object>> list = query(sql, YW,new Object[]{yw_guid});
      return list;
    }
    /*******
     * 
     * <br>Description:项目管理——保存办理过程
     * <br>Author:朱波海
     * <br>Date:2013-12-16
     */
  public void saveBLGC(){
      String xh = request.getParameter("xh");
      String sj = request.getParameter("sj");
      String sjbl = request.getParameter("sjbl");
      String bmjbr = request.getParameter("bmjbr");
      String bz = request.getParameter("bz");
      String yw_guid = request.getParameter("yw_guid").trim();
      String insertString="insert into xmblgc (xh,sj,sjbl,bmjbr,bz,yw_guid )values(?,?,?,?,?,?)";
      int i = update(insertString, YW,new Object[]{xh,sj,sjbl,bmjbr,bz,yw_guid});
      if(i>0){
         response("success");
      }else{
          response("failure");
      }
  }
  /****
   * 
   * <br>Description:获取红线项目
   * <br>Author:朱波海
   * <br>Date:2013-12-16
   */
    public  List<Map<String, Object>> getHXXM(){
        String sql="select xmname,yw_guid,rownum from jc_xiangmu ";
        List<Map<String, Object>> list = query(sql, YW);
        return  list;
        
    }
    /****
     * 
     * <br>Description:项目管理——资金管理——资金流入
     * <br>Author:朱波海
     * <br>Date:2013-12-17
     */
 public List<Map<String, Object>> getZJGL_ZJLR( String yw_guid){
     String  sql="select * from  xmzjgl where status='lr' and yw_guid=?";
     List<Map<String, Object>> list = query(sql, YW,new Object []{yw_guid});
     return list;
 }  
 /******
  * 
  * <br>Description:保存资金管理——资金流入
  * <br>Author:朱波海
  * <br>Date:2013-12-17
  */
 public  void saveZJGL_ZJLR(){
     
     String yw_guid = request.getParameter("yw_guid");
     String val = request.getParameter("val");
     String cols = request.getParameter("cols");
     int i=Integer.parseInt(cols);
     String stye = request.getParameter("stye");
     String sql="update xmzjgl_lr set "+ZJGL_LR[i-1]+"= "+val+"  where yw_guid=? and status=?";
     update(sql, YW,new Object []{yw_guid,stye});
 }
 
 /****
  * 
  * <br>Description:项目管理——资金管理——资金支出
  * <br>Author:朱波海
  * <br>Date:2013-12-17
  */
public List<Map<String, Object>> getZJGL_ZJZC(String yw_guid){
    String  sql="select distinct lb,yw_guid  from  xmzjgl where status='zc' and yw_guid=?";
    List<Map<String, Object>> list = query(sql, YW,new Object []{yw_guid});
    //t.zcstatus 
    for (int i=0;i<list.size();i++){
        list.get(i).get("lb").toString();
        
    }
    return list;
 }
/******
 * 
 * <br>Description:保存资金管理——资金支出
 * <br>Author:朱波海
 * <br>Date:2013-12-17
 */
public void saveZJGL_ZJZC() {
    String yw_guid = request.getParameter("yw_guid");
    String val = request.getParameter("val");
    String status = request.getParameter("status");
    String lb = request.getParameter("lb");
    lb =  UtilFactory.getStrUtil().unescape(lb);
    String sort = request.getParameter("sort");
    String cols = request.getParameter("cols");
    int i=Integer.parseInt(cols);
    String sql="update xmzjgl_zc set "+ZJGL_ZC[i-1]+"= "+val+"  where yw_guid=? and status=? and lb=? and sort=?";
    update(sql, YW,new Object []{yw_guid,status,lb,sort});
    
}

public void saveZjglTree(){
    String st[]={"QQFY","CQFY","SZFY","CWFY","GLFY","CRZJFH","QTZC"};
    String yw_guid = request.getParameter("yw_guid").trim();
    String parent_id = request.getParameter("parent_id");
    String id = request.getParameter("id");
    String tree_name = request.getParameter("tree_name");
    tree_name=UtilFactory.getStrUtil().unescape(tree_name).trim();
    for (int i=0;i<st.length;i++){
        if(id.equals(st[i])){
    String sql=" insert into zjgl_tree (yw_guid,parent_id,tree_name,tree_id)values (?,?,?,?)";
    update(sql, YW,new Object[]{yw_guid,id,tree_name,id});
    new ZjglData().saveNode( tree_name,st[i], yw_guid);
        }
    }
}


}
