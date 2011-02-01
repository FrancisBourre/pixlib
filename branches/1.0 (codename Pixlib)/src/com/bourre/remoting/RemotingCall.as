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

import com.bourre.data.libs.AbstractLib;
import com.bourre.events.EventType;
import com.bourre.log.PixlibDebug;
import com.bourre.log.PixlibStringifier;
import com.bourre.remoting.AbstractServiceProxy;
import com.bourre.remoting.BasicFaultEvent;
import com.bourre.remoting.BasicResultEvent;
import com.bourre.remoting.IServiceProxyListener;
import com.bourre.remoting.RemotingCallEvent;
import com.bourre.remoting.RemotingConnection;
import com.bourre.remoting.ServiceMethod;
import com.bourre.remoting.ServiceResponder;

class com.bourre.remoting.RemotingCall 
	extends AbstractLib 
	implements IServiceProxyListener
{
	private var _sServiceName : String;
	private var _oMethod : ServiceMethod;
	private var _aArgs : Array;
	private var _oResponder : ServiceResponder;
	
	public static var onLoadInitEVENT : EventType = AbstractLib.onLoadInitEVENT;
	public static var onLoadProgressEVENT : EventType = AbstractLib.onLoadProgressEVENT;
	public static var onTimeOutEVENT : EventType = AbstractLib.onTimeOutEVENT;
	public static var onErrorEVENT : EventType = AbstractLib.onErrorEVENT;

	public static var onResultEVENT : EventType = ServiceResponder.onResultEVENT;
	public static var onFaultEVENT : EventType = ServiceResponder.onFaultEVENT;

	public function RemotingCall( 	sURL : String, 
									sFullyQualifiedMethodName : String,
									responder : IServiceProxyListener ) 
	{
		super();
		
		setURL( sURL );
		setFullyQualifiedMethodName( sFullyQualifiedMethodName );
		setResponder( responder );
	}
	
	public function setCredentials( sUserID : String, sPassword : String ) : Void
	{
		RemotingConnection.getRemotingConnection( _sURL ).setCredentials( sUserID, sPassword );
	}
	
	public function setResponder( responder : IServiceProxyListener ) : Void
	{
		if (responder) _oResponder = new ServiceResponder( responder );
	}
	
	public function setFullyQualifiedMethodName( sFullyQualifiedMethodName : String ) : Void
	{
		if ( sFullyQualifiedMethodName )
		{
			var a : Array = sFullyQualifiedMethodName.split(".");
			setMethodName( String( a.pop() ) );
			setServiceName( a.join(".") );
		}
	}
	
	public function setServiceName( serviceName : String ) : Void
	{
		_sServiceName = serviceName;
	}
	
	public function setServiceMethod( serviceMethod : ServiceMethod ) : Void
	{
		_oMethod = serviceMethod;
	}
	
	public function setMethodName( sServiceMethod : String ) : Void
	{
		if ( sServiceMethod instanceof ServiceMethod )
		{
			PixlibDebug.FATAL( "Argument failure on " + this + ".setMethodName(). Use String argument instead.");
			
		} else
		{
			setServiceMethod( new ServiceMethod( sServiceMethod ) );
		}
	}
	
	public function setArguments() : Void
	{
		if ( arguments.length > 0 ) _aArgs = arguments;
	}
	
	public function getServiceName() : String
	{
		return _sServiceName;
	}
	
	public function getMethod() : ServiceMethod
	{
		return _oMethod;
	}
	
	public function getArguments() : Array
	{
		return _aArgs;
	}
	
	public function initEventSource() : Void
	{
		_e = new RemotingCallEvent( null, this );
	}
	
	public function load() : Void
	{
		setArguments.apply( this, arguments );
		var service : AbstractServiceProxy = new AbstractServiceProxy( this.getURL(), getServiceName() );
		service.callServiceMethod.apply( service, [getMethod(), new ServiceResponder(this)].concat( getArguments() ) );
		super.load();
	}
	
	public function onResult( e : BasicResultEvent ):Void
	{
		super.release();

		fireEvent( new RemotingCallEvent( RemotingCall.onLoadInitEVENT, this, e.getResult() ) );		_oEB.broadcastEvent( e );
		if (_oResponder) _oResponder.invokeOnResult( e );
	}
	
	public function onFault( e : BasicFaultEvent ):Void
	{
		super.release();
		fireEvent( new RemotingCallEvent( RemotingCall.onErrorEVENT, this ) );
		_oEB.broadcastEvent( e );
		if (_oResponder) _oResponder.invokeOnFault( e );
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