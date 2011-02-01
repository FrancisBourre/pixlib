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

import com.bourre.commands.Delegate;
import com.bourre.data.libs.AbstractLib;
import com.bourre.data.libs.FileLibEvent;
import com.bourre.data.libs.IFileParser;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;

class com.bourre.data.libs.FileLib 
	extends AbstractLib
{
	public static var onLoadInitEVENT:EventType = AbstractLib.onLoadInitEVENT;
	public static var onLoadProgressEVENT:EventType = AbstractLib.onLoadProgressEVENT;
	public static var onTimeOutEVENT:EventType = AbstractLib.onTimeOutEVENT;
	
	private var _data : String;
	private var _oParser : IFileParser;

	public function FileLib( parser : IFileParser ) 
	{
		setContent( new LoadVars() );
		_oParser = parser;
	}

	public function getParser () : IFileParser 
	{
		return _oParser;
	}
	
	public function setParser( parser : IFileParser ) : Void
	{
		_oParser = parser;
	}
	
	public function parseData( sData : String ) : Void
	{
		getParser().setOwner( this );
		getParser().parse( sData );
		
    	super.onLoadInit();
	}
	
	public function initEventSource() : Void
	{
		_e = new FileLibEvent( null, this );
	}
	
	public function load ( url : String ) : Void
	{
		if ( url != undefined ) setURL( url );
		_data = null;
		
  		getContent().onData = Delegate.create( this, _onData );
  		getContent().load( this.getURL() );
  		super.load();
	}
	
	public function onLoadInit() : Void
	{
		// overwriting for delaying 'onLoadInit' broadcast
	}
	
	private function _onData( src : String ) : Void
	{
		if( src != null )
        {
        	getContent().loaded = true;
        	getContent().onLoad( true );
        	
        	if ( getParser() == undefined )
        	{
        		_data = src;
        		fireEventType( FileLib.onLoadInitEVENT );
        		
        	} else
        	{
        		parseData( src );
        	}
        }
   		 else
        {
        	getContent().onLoad( false );
        	fireEventType( FileLib.onErrorEVENT );
        }
	}
	
	public function getData()
	{
		return _data;
	}
	
	public function setData( data )
	{
		_data = data;
	}
	
	public function getContent() : LoadVars
	{
		return LoadVars( super.getContent() );
	}

	public function setContent( lv : LoadVars ) : Void
	{
		super.setContent( lv );
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