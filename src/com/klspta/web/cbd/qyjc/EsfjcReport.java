package com.klspta.web.cbd.qyjc;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;
import com.klspta.web.cbd.sccsl.EsfzjjcManager;

public class EsfjcReport extends AbstractBaseBean implements IDataClass{
	
	private final static String[] TITLE= {"所属区域","序号","小区名称","性质","建设年代","区位","房屋、建筑类型","物业费",
											"楼栋总数","房屋总数","楼层状况","容积率","绿化率（%）","停车位","开发商",
											 "物业公司","地址","yw_guid","url"};
	
	@Override
	public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
		Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
		buildTitle(trbeans);
		buildESF(obj, trbeans);
		return trbeans;
	}

	private void buildESF(Object[] obj, Map<String, TRBean> trbeans) {
		List<Map<String, Object>> esf = null;
		if(obj.length>1){
			esf = new EsfzjjcManager().getESFData(obj[1].toString());
		}else{
			esf = new EsfzjjcManager().getESFData();
		}
		TRBean trbean = null;
		TDBean tdbean = null;
		int i= 0;
		int bkqljf = 0;
		int dkqljf = 0;
		int yqljf = 0;
		int yqxjf = 0;
		int dkqxjf = 0;
		String ssqy = "";
		if(esf!=null){
			for(int j = 0; j < esf.size(); j++){
				if("CBD北控区老旧房".equals(esf.get(j).get("SSQY"))){
					bkqljf++;
				}else if("CBD东扩区老旧房".equals(esf.get(j).get("SSQY"))){
					dkqljf++;
				}else if("CBD东扩区新居房".equals(esf.get(j).get("SSQY"))){
					dkqxjf++;
				}else if("CBD原区老旧房".equals(esf.get(j).get("SSQY"))){
					yqljf++;
				}else if("CBD原区新居房".equals(esf.get(j).get("SSQY"))){
					yqxjf++;
				}
			}
			for(Map<String,Object> map : esf){
				trbean = new TRBean();
				trbean.setCssStyle("trsingle");
				Set<String> keyset = map.keySet();
				for(String key : keyset){
					if("QT".equals(key)){
						tdbean = new TDBean(map.get(key)==null?"":map.get(key).toString(),"300","");
						trbean.addTDBean(tdbean);
					}else{
						if("SSQY".equals(key)){
							if("".equals(ssqy) || !ssqy.equals(map.get("SSQY"))){
								tdbean = new TDBean(map.get(key)==null?"":map.get(key).toString(),"120","");
								if("CBD北控区老旧房".equals(map.get(key))){
									tdbean.setRowspan(bkqljf+"");
								}else if("CBD东扩区老旧房".equals(map.get(key))){
									tdbean.setRowspan(dkqljf+"");
								}else if("CBD东扩区新居房".equals(map.get(key))){
									tdbean.setRowspan(dkqxjf+"");
								}else if("CBD原区老旧房".equals(map.get(key))){
									tdbean.setRowspan(yqljf+"");
								}else if("CBD原区新居房".equals(map.get(key))){
									tdbean.setRowspan(yqxjf+"");
								}
								trbean.addTDBean(tdbean);	
							}
						}else{
							if("XQMC".equals(key) && map.get("url")!=null){
								tdbean = new TDBean(map.get(key)==null?"":"<a href='"+map.get("url")+"' target='_blank'>"+map.get(key).toString()+ "</a>","120","");
							}else{
								tdbean = new TDBean(map.get(key)==null?"":map.get(key).toString(),"120","");
							}
							trbean.addTDBean(tdbean);
						}
					}
					ssqy = map.get("SSQY").toString();
				}
				trbeans.put("esf"+i, trbean);
				i++;
			}
		}
	}

	private void buildTitle(Map<String, TRBean> trbeans) {
		TRBean trbean = new TRBean();
		trbean.setCssStyle("title");
		TDBean tdBean = null;
		for(String name : TITLE){
			tdBean = new TDBean(name, "240", "");
			trbean.addTDBean(tdBean);
		}
		trbeans.put("title1", trbean);
	}
}