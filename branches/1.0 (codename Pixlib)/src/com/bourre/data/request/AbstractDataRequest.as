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

import com.bourre.data.request.DataRequestEvent;
import com.bourre.data.request.IDataRequest;
import com.bourre.data.request.IDataRequestListener;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibDebug;
import com.bourre.log.PixlibStringifier;

class com.bourre.data.request.AbstractDataRequest 
	implements IDataRequest
{
	private var _oEB : EventBroadcaster;
	private var _oResult;
	private var _eResult : DataRequestEvent;
	private var _eError : DataRequestEvent;
	
	public function AbstractDataRequest() 
	{
		_oEB = new EventBroadcaster( this );

		_eResult = new DataRequestEvent( DataRequestEvent.onDataResultEVENT, this );
		_eError = new DataRequestEvent( DataRequestEvent.onDataErrorEVENT, this );
	}
	
	public function getResult()
	{
		return _oResult;
	}
	
	public function addListener( listener : IDataRequestListener ) : Void
	{
		_oEB.addListener( listener );
	}
	
	public function removeListener( listener : IDataRequestListener ) : Void
	{
		_oEB.removeListener( listener );
	}
	
	public function fireEvent( e : IEvent ) : Void
	{
		_oEB.broadcastEvent( e );
	}
	
	/*
	 * virtual methods
	 */
	public function setURL( url : String ) : Void
	{
		PixlibDebug.ERROR( this + ".setURL() must be implemented in concrete class." );
	}
	
	public function setArguments() : Void
	{
		PixlibDebug.ERROR( this + ".setArguments() must be implemented in concrete class." );
	}
	
	public function execute( e : IEvent ) : Void
	{
		PixlibDebug.ERROR( this + ".execute() must be implemented in concrete class." );
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