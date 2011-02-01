/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import com.bourre.commands.Delegate;import com.bourre.data.collections.Map;import com.bourre.log.LogEvent;import com.bourre.log.LogLevel;import com.bourre.log.LogListener;import com.bourre.log.PixlibStringifier;import com.bourre.utils.ClassUtils;class com.bourre.utils.AirTracer
	implements LogListener
{
	private static var DEBUG : Number = 10000;
	private static var INFO : Number = 20000;
	private static var WARN : Number = 30000;
	private static var ERROR : Number = 40000;
	private static var FATAL : Number = 50000;

	private static var LOCALCONNECTION_ID : String = "_AIRLOGGER_CONSOLE";
	private static var OUT_SUFFIX : String = "_IN";
	private static var IN_SUFFIX : String = "_OUT";

	private static var ALTERNATE_ID_IN : String = "";

	private static var _oI : AirTracer;

	public static function getInstance() : AirTracer
	{
		if (!AirTracer._oI) AirTracer._oI = new AirTracer();
		return AirTracer._oI;
	}

	public static function release() : Void
	{
		_oI.close();
		_oI = null;
	}

	private var _lcOut : LocalConnection;
	private var _lcIn : LocalConnection;
	private var _sID : String;

	private var _bIdentified : Boolean;
	private var _bRequesting : Boolean;

	private var _aLogStack : Array;
	private var _nPingRequest : Number;

	private var _sName : String;
	private var _mFormat : Map;

	private function AirTracer()
	{
		_lcOut = new LocalConnection();
		_lcOut.onStatus = Delegate.create(this, this.onStatus);
        
		_lcIn = new LocalConnection();
		_lcIn.setID = Delegate.create(this, this.setID);
		_lcIn.allowDomain = function () { 
			return true; 
		};
       
		_aLogStack = new Array();
            
		_bIdentified = false;
		_bRequesting = false;
		
		_buildColorKeys();
        		
		_connect();		
	}

	private function _buildColorKeys() : Void
	{
		_mFormat = new Map();

		_mFormat.put(LogLevel.DEBUG, AirTracer.DEBUG);
		_mFormat.put(LogLevel.INFO, AirTracer.INFO);
		_mFormat.put(LogLevel.WARN, AirTracer.WARN);
		_mFormat.put(LogLevel.ERROR, AirTracer.ERROR);
		_mFormat.put(LogLevel.FATAL, AirTracer.FATAL);
	}

	private function _connect() : Void
	{
		while( !_lcIn.connect(_getInConnectionName(ALTERNATE_ID_IN)) )
		{
			_lcOut.send(_getOutConnectionName(), "mainConnectionAlreadyUsed", ALTERNATE_ID_IN);
					
			ALTERNATE_ID_IN += "_";
		}
	}

	public function setName( s : String ) : Void
	{
		_sName = s;
			
		if( _bIdentified )
		{
			_lcOut.send(_getOutConnectionName(_sID), "setTabName", _sName);
		}
	}

	public function close() : Void
	{
		_lcIn.close();
	}

	public function focus() : Void
	{
		_send(getAirMessage("focus"));
	}

	public function clear() : Void
	{
		_send(getAirMessage("clear"));
	}

	public function setID( id : String ) : Void
	{
		try {
			clearInterval(_nPingRequest);
			_sID = id;
				
			_lcIn.close();
			_lcIn.connect(_getInConnectionName(_sID));
				
			_lcOut.send(_getOutConnectionName(), "confirmID", id, _sName);
				
			_bIdentified = true;
			_bRequesting = false;
				
			var l : Number = _aLogStack.length;
			if( l != 0 )
			{
				for(var i : Number = 0;i < l; i++ )
				{
					_send(_aLogStack.shift());
				}
			}
		}
			catch ( e : Error ) {
			_lcIn.connect(_getInConnectionName(ALTERNATE_ID_IN));
				
			_lcOut.send(_getOutConnectionName(), "idAlreadyUsed", id);
		}
	}

	public function pingRequest() : Void
	{
		_lcOut.send(_getOutConnectionName(), "requestID", ALTERNATE_ID_IN);
	}

	public function isRequesting() : Boolean
	{
		return _bRequesting;
	}

	public function isIdentified() : Boolean
	{
		return _bIdentified;
	}

	private function _send( evt ) : Void
	{
		if( _bIdentified )
		{
			_lcOut.send(_getOutConnectionName(_sID), evt.type, evt);
		}
			else
		{
			_aLogStack.push(evt);
				
			if( !_bRequesting )
			{					
				pingRequest();
				_nPingRequest = setInterval(this, "pingRequest", 1000);
				_bRequesting = true;
			}
		}
	}

	private function _getInConnectionName( id : String ) : String
	{
		return LOCALCONNECTION_ID + (id ? id : "") + IN_SUFFIX;
	}

	private function _getOutConnectionName( id : String ) : String
	{
		return LOCALCONNECTION_ID + (id ? id : "") + OUT_SUFFIX;
	}

	private function _getType( o )
	{
		if(o instanceof String) 
		{
			o = String(o);
		} else if(o instanceof Boolean) 
		{
			o = Boolean(o);
		} else if(o instanceof Number) 
		{
			o = Number(o);
		}
		return o;
	}

	public function onLog(e : LogEvent) : Void
	{
		log( e.content, e.level);
	}

	public function log( o , level : Number ) : Void
	{
		var alEvt = getAirMessage("log", _getType(o), level, new Date(), ClassUtils.getFullyQualifiedClassName(o));
		_send(alEvt);
	}

	public function getAirMessage( sType : String, message , level : Number, date : Date, sMessageType ) 
	{
		var nLevel : Number = (level ? _mFormat.get(level) : AirTracer.DEBUG );
		
		return { type: sType, message: message, level: nLevel, date: date, messageType: sMessageType };
	}

	public function onStatus( event ) : Void 
	{
		//PixlibDebug.DEBUG( "onStatus( " + event.level + ")" );
	}

	public function toString() : String 
	{
		return PixlibStringifier.stringify(this);
	}
}