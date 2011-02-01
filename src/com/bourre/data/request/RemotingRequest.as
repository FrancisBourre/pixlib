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
 
/**
 * @author Francis Bourre
 * @version 1.0
 */

import com.bourre.data.libs.LibEvent;
import com.bourre.data.request.AbstractDataRequest;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.remoting.BasicFaultEvent;
import com.bourre.remoting.BasicResultEvent;
import com.bourre.remoting.IServiceProxyListener;
import com.bourre.remoting.RemotingCall;

import com.bourre.log.Logger;import com.bourre.utils.LuminicTracer;import com.bourre.log.PixlibDebug;

class com.bourre.data.request.RemotingRequest 
	extends AbstractDataRequest 
	implements IServiceProxyListener
{
	private var _oRemotingCall : RemotingCall;
	
	public function RemotingRequest( url : String, sFullyQualifiedMethodName : String, _nTimeOut : Number ) 
	{
		super();
		//Logger.getInstance().addLogListener(LuminicTracer.getInstance());		
		//PixlibDebug.DEBUG( this + ".RemotingRequest");
		
		_oRemotingCall = new RemotingCall(  url, sFullyQualifiedMethodName, this, _onTimeOut );
		
		// added by Mike
		if(_nTimeOut != undefined)
			_oRemotingCall.setTimeOut( _nTimeOut );
		
		//_oRemotingCall.addEventListener( RemotingCall.onTimeOutEVENT, this );
		// corrected by Mike
		_oRemotingCall.addEventListener( RemotingCall.onTimeOutEVENT, this, _onTimeOut );
	}
	
	public function setCredentials( sUserID : String, sPassword : String ) : Void
	{
		_oRemotingCall.setCredentials( sUserID, sPassword );
	}
	
	public function setTimeOut( n : Number ) : Void
	{
		_oRemotingCall.setTimeOut( n );
	}
	
	public function setURL( url : String ) : Void
	{
		_oRemotingCall.setURL( url );
	}
	
	public function setArguments() : Void
	{
		_oRemotingCall.setArguments.apply( _oRemotingCall, arguments );
	}
	
	public function execute( e : IEvent ) : Void
	{
		_oResult = null;
		_oRemotingCall.execute();
	}

	private function _onTimeOut( e : LibEvent ) : Void 
	{
		//PixlibDebug.DEBUG( this + "._onTimeOut()");
		
		fireEvent( _eError );
	}
	
	/**
	 * IServiceProxyListener callbacks
	 */
	public function onResult( e : BasicResultEvent ) : Void 
	{
		_oResult = e.getResult();
		fireEvent( _eResult );
	}
		
	public function onFault( e : BasicFaultEvent ) : Void 
	{
		fireEvent( _eError );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this );
	}
}