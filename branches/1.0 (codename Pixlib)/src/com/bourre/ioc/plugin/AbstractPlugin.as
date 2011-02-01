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

import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;
import com.bourre.ioc.control.PluginController;
import com.bourre.ioc.events.ApplicationBroadcaster;
import com.bourre.ioc.events.ChannelExpert;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.model.ModelLocator;
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.plugin.IPluginListener;
import com.bourre.ioc.visual.MovieClipHelperLocator;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.plugin.AbstractPlugin 
	implements IPlugin
{
	private var _oABExternal : ApplicationBroadcaster;
	private var _oEBPublic : EventBroadcaster;	private var _oEBPrivate : EventBroadcaster;
	private var _oController : PluginController;	private var _oModelLocator : ModelLocator;	private var _oMovieClipHelperLocator : MovieClipHelperLocator;
	
	public static var onInitEVENT : EventType = new EventType( "onInit" );
	public static var onReleaseEVENT : EventType = new EventType( "onRelease" );
	
	private function AbstractPlugin() 
	{
		_oController = new PluginController( this );
		_oModelLocator = ModelLocator.getInstance( this );
		_oMovieClipHelperLocator = MovieClipHelperLocator.getInstance( this );
		
		_oABExternal = ApplicationBroadcaster.getInstance();
		_oEBPublic = ApplicationBroadcaster.getInstance().getChannelDispatcher( getChannel(), this );		_oEBPrivate = getController().getBroadcaster();
		
		_oEBPublic.addListener( this );
	}
	
	public function onInitPlugin() : Void
	{
		fireExternalEvent( new BasicPluginEvent( AbstractPlugin.onInitEVENT, this ) );
	}
	
	public function onReleasePlugin() : Void
	{
		fireExternalEvent( new BasicPluginEvent( AbstractPlugin.onReleaseEVENT, this ) );
	}
	
	public function getChannel() : String
	{
		return ChannelExpert.getInstance().getChannel( this );
	}
	
	public function getController() : PluginController
	{
		return _oController;
	}
	
	public function getModelLocator() : ModelLocator
	{
		return _oModelLocator;
	}
	
	public function getMovieClipHelperLocator() : MovieClipHelperLocator
	{
		return _oMovieClipHelperLocator;
	}
	
	public function getLogger() : PixiocDebug
	{
		return PixiocDebug.getInstance( this );
	}
	
	public function fireExternalEvent( e : IEvent, externalChannel : String ) : Void
	{
		if ( externalChannel && externalChannel != getChannel() ) 
		{
			_oABExternal.broadcastEvent( e, externalChannel );
			
		} else if( externalChannel )
		{
			getLogger().error( this + ".fireExternalEvent() failed, '" + externalChannel + "' is its public channel." );
		
		} else
		{
			getLogger().error( this + ".fireExternalEvent() failed, external channel is undefined." );
		}
	}
	
	public function firePublicEvent( e : IEvent ) : Void
	{
		_oEBPublic.broadcastEvent( e );
	}
	
	public function firePrivateEvent( e : IEvent ) : Void
	{
		_oEBPrivate.broadcastEvent( e );
	}
	
	public function addListener( oL : IPluginListener ) : Void
	{
		_oEBPublic.addListener( oL );
	}
	
	public function removeListener( oL : IPluginListener ) : Void
	{
		_oEBPublic.removeListener( oL );
	}
	
	public function addEventListener( e : EventType, oL, f : Function ) : Void
	{
		_oEBPublic.addEventListener.apply( _oEBPublic, arguments );
	}
	
	public function removeEventListener( e : EventType, oL ) : Void
	{
		_oEBPublic.removeEventListener( e, oL );
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