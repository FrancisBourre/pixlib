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

import com.bourre.commands.CommandManagerFPS;
import com.bourre.commands.Delegate;
import com.bourre.data.libs.AbstractLib;
import com.bourre.data.libs.LibEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;
import com.bourre.ioc.assembler.ApplicationAssembler;
import com.bourre.ioc.assembler.channel.ChannelListenerExpert;
import com.bourre.ioc.assembler.constructor.ConstructorExpert;
import com.bourre.ioc.assembler.method.MethodExpert;
import com.bourre.ioc.assembler.movieclip.IMovieClipExpertListener;
import com.bourre.ioc.assembler.movieclip.MovieClipEvent;
import com.bourre.ioc.assembler.movieclip.MovieClipExpert;
import com.bourre.ioc.context.ContextLoader;
import com.bourre.ioc.context.ContextLoaderEvent;
import com.bourre.ioc.loader.ApplicationLoaderEvent;
import com.bourre.ioc.loader.IApplicationLoaderListener;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.parser.ContextParser;
import com.bourre.ioc.parser.IContextParserListener;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.loader.ApplicationLoader 
	implements IMovieClipExpertListener, IContextParserListener
{
	public static var onLoadInitEVENT : EventType = AbstractLib.onLoadInitEVENT;
	public static var onLoadProgressEVENT : EventType = AbstractLib.onLoadProgressEVENT;
	public static var onTimeOutEVENT : EventType = AbstractLib.onTimeOutEVENT;
	
	public static var onApplicationBuiltEVENT : EventType = new EventType( "onApplicationBuilt" );
	public static var onApplicationInitEVENT : EventType = new EventType( "onApplicationInit" );
	
	private var _oEB : EventBroadcaster;	private var _oContextLoader : ContextLoader;	private var _oContextParser : ContextParser;
	private var _oAssembler : ApplicationAssembler;
	
	public function ApplicationLoader() 
	{
		_oEB = new EventBroadcaster( this );
		_oContextLoader = new ContextLoader();
	}
	
	public function load() : Void
	{
		_oContextLoader.addEventListener( ContextLoader.onLoadInitEVENT, this, _parseContext );
		_oContextLoader.addEventListener( ContextLoader.onLoadProgressEVENT, this );
		_oContextLoader.addEventListener( ContextLoader.onTimeOutEVENT, this );
		_oContextLoader.load();
	}
	
	private function _parseContext( e : ContextLoaderEvent ) : Void
	{
		_oContextLoader.removeListener( this );

		_oAssembler = new ApplicationAssembler();
		_oContextParser = new ContextParser( _oAssembler );
		_oContextParser.addListener( this );
		_oContextParser.parse( e.getContext() );
	}
	
	public function onContextParsingEnd( e : IEvent ) : Void
	{
		_oContextParser.removeListener( this );
		addListener( _oAssembler.getLoaderUI() );
		MovieClipExpert.getInstance().addListener( this );
		MovieClipExpert.getInstance().load();
	}
	
	public function onLoadComplete( e : LibEvent ) : Void
	{
		MovieClipExpert.getInstance().removeListener( this );
		
		CommandManagerFPS.getInstance().delay( new Delegate( this, onLoadNextFrame) );
	}
	
	public function onLoadNextFrame() : Void
	{
		onApplicationBuilt();

		ConstructorExpert.getInstance().buildAllObjects();
		//PropertyExpert.getInstance().setAllProperties();
		MethodExpert.getInstance().callAllMethods();
		ChannelListenerExpert.getInstance().assignAllChannelListeners();

		onApplicationInit();
	}
	
	public function fireEvent( e : IEvent ) : Void
	{
		_oEB.broadcastEvent( e );
	}
	
	public function onApplicationBuilt() : Void
	{
		PixiocDebug.getInstance().debug( "Application has been built" );
		_oEB.broadcastEvent( new ApplicationLoaderEvent( ApplicationLoader.onApplicationBuiltEVENT, this ) );
	}
	
	public function onApplicationInit() : Void
	{
		PixiocDebug.getInstance().debug( "Application has been initialized" );
		_oEB.broadcastEvent( new ApplicationLoaderEvent( ApplicationLoader.onApplicationInitEVENT, this ) );
		removeListener( _oAssembler.getLoaderUI() );
	}
	
	/**
	 * IMovieClipExpertListener callbacks.
	 */
	public function onBuildMovieClip( e : MovieClipEvent ) : Void 
	{
		//
	}
	
	public function onLoadInit( e : LibEvent ) : Void 
	{
		fireEvent( e );
	}

	public function onLoadProgress( e : LibEvent ) : Void 
	{
		fireEvent( e );
	}

	public function onTimeOut( e : LibEvent ) : Void 
	{
		fireEvent( e );
	}
	
	/**
	 * Event system
	 */
	public function addListener( oL : IApplicationLoaderListener ) : Void
	{
		_oEB.addListener( oL );
	}
	
	public function removeListener( oL : IApplicationLoaderListener ) : Void
	{
		_oEB.removeListener( oL );
	}
	
	public function addEventListener( e : EventType, oL, f : Function ) : Void
	{
		_oEB.addEventListener.apply( _oEB, arguments );
	}
	
	public function removeEventListener( e : EventType, oL ) : Void
	{
		_oEB.removeEventListener( e, oL );
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