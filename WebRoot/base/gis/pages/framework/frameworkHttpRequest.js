    var _$URL = restUrl;
    var _$parameters = "_$serid=";
	var _$beanName = "nobeanname";
	var _$methodName = "nomethodname";


	function putRestParameter(parameterName, parameterValue){
	    _$parameters = _$parameters + "&" + parameterName + "=" + parameterValue;
	}
	
	function putClientCommond(beanName, methodName){
	    this._$beanName = beanName;
		this._$methodName = methodName;
	}
	
	function restRequest(){
	    _$URL = _$URL + _$beanName + "/" + _$methodName;
		var _$xmlHttp;
        if(window.XMLHttpRequest){
            _$xmlHttp = new XMLHttpRequest();
        }else if(window.ActiveXObject){
            _$xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        _$xmlHttp.open('POST', _$URL, false);
        _$xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        _$xmlHttp.send(_$parameters);
		var _$result = _$xmlHttp.responseText;            
		_resetParameters();
		//_$result = JSON.parse(_$result);
		try{
		    _$result = Ext.util.JSON.decode(_$result);
		    return _$result;
		}catch (e){
		    return _$result;
		}
		
	}
	
	function restRequestAsyn(funcback){
	    restRequestAsyn.Postback = function(oxmlhttp){
            return function(){
                if(_$xmlHttp.readyState==4){
                    if (_$xmlHttp.status == 200) {
						var _$result = _$xmlHttp.responseText;
						_$result = Ext.util.JSON.decode(_$result);
						_resetParameters();
						funcback(_$result);
					}
                }
            }
        }
		
	    _$URL = _$URL + _$beanName + "/" + _$methodName;
	    var _$xmlHttp;
        if(window.XMLHttpRequest){
            _$xmlHttp = new XMLHttpRequest();
        }else if(window.ActiveXObject){
            _$xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        _$xmlHttp.open('POST', _$URL, true);
        _$xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    _$xmlHttp.onreadystatechange = restRequestAsyn.Postback(this._$xmlHttp);  
	    _$xmlHttp.send(_$parameters);
	}
	
	function _resetParameters(){
	    _$URL = restUrl;
        _$parameters = "_$serid=";
	    _$beanName = "nobeanname";
	    _$methodName = "nomethodname";
	}
	