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

import com.bourre.data.libs.BasicXMLDeserializer;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.IXMLToObjectDeserializer;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.data.request.AbstractDataRequest;
import com.bourre.events.IEvent;

class com.bourre.data.request.XMLToObjectRequest 
	extends AbstractDataRequest 
	implements ILibListener
{
	private var _xto : XMLToObject;

	public function XMLToObjectRequest( url : String, deserializer : IXMLToObjectDeserializer ) 
	{
		super();

		_xto = new XMLToObject( new Object(), deserializer? deserializer : new BasicXMLDeserializer() );
		setURL( url );
		_xto.addListener( this );
	}
	
	public function setURL( url : String ) : Void
	{
		_xto.setURL( url );
	}
	
	public function setAntiCache( b : Boolean ) : Void
	{
		_xto.setAntiCache( b );
	}
	
	public function setArguments( deserializer : IXMLToObjectDeserializer ) : Void
	{
		_xto.setDeserializer( deserializer );
	}
	
	public function execute( e : IEvent ) : Void
	{
		_oResult = null;
		
		// added by mike
		_xto.setObject( new Object() );
		
		_xto.execute();
	}
	
	public function onError( e : XMLToObjectEvent ) : Void
	{
		fireEvent( _eError );
	}
	
	/**
	 * ILibListener callbacks
	 */
	public function onLoadInit( e : LibEvent ) : Void 
	{
		_oResult = XMLToObjectEvent(e).getObject();
		fireEvent( _eResult );
	}

	public function onLoadProgress( e : LibEvent ) : Void 
	{
		//
	}

	public function onTimeOut( e : LibEvent ) : Void 
	{
		fireEvent( _eError );
	}
}