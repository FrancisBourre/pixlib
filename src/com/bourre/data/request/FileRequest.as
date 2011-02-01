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

import com.bourre.data.libs.FileLib;
import com.bourre.data.libs.FileLibEvent;
import com.bourre.data.libs.IFileParser;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.data.request.AbstractDataRequest;
import com.bourre.events.IEvent;

class com.bourre.data.request.FileRequest 
	extends AbstractDataRequest
	implements ILibListener
{
	private var _fl : FileLib;

	public function FileRequest( url : String ) 
	{
		super();
		
		_fl = new FileLib();
		setURL( url );
		_fl.addListener( this );
	}
	
	public function setURL( url : String ) : Void
	{
		_fl.setURL( url );
	}
	
	public function setArguments( parser : IFileParser ) : Void
	{
		_fl.setParser( parser );
	}
	
	public function execute( e : IEvent ) : Void
	{
		_oResult = null;
		_fl.execute();
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
		_oResult = FileLibEvent(e).getData();
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