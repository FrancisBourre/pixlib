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
import com.bourre.events.StringEvent;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.model.ModelLocator;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.model.AbstractModel 
{
	public static var onInitEVENT : EventType = new EventType( "onInit" );
	
	private var _oEB : EventBroadcaster;
	private var _sName : String;	private var _owner : IPlugin;
	
	private function AbstractModel( owner : IPlugin, name : String ) 
	{
		_oEB = new EventBroadcaster( this );
		
		if ( owner ) setOwner( owner );
		if ( name ) setName( name );
	}
	
	public function onInit() : Void
	{
		notifyChanged( new StringEvent( AbstractMovieClipHelper.onInitEVENT, getName() ) );
	}
	
	public function setName( name : String ) : Void
	{
		var ml : ModelLocator = ModelLocator.getInstance( getOwner() );
		
		if ( !( ml.isRegistered( name ) ) )
		{
			if ( ml.isRegistered( getName() ) ) ml.unregisterModel( getName() );
			if ( ml.registerModel( name, this ) ) _sName = name;
			
		} else
		{
			getLogger().error( this + ".setName() failed. '" + name + "' is already registered in ModelLocator." );
		}
	}
	
	public function getOwner() : IPlugin
	{
		return _owner;
	}
	
	public function setOwner( owner : IPlugin ) : Void
	{
		_owner = owner;
	}
	
	public function getLogger() : PixiocDebug
	{
		return PixiocDebug.getInstance( getOwner() );
	}
	
	public function notifyChanged( e : IEvent ) : Void
	{
		_getBroadcaster().broadcastEvent( e );
	}
	
	public function getName() : String
	{
		return _sName;
	}
	
	public function release() : Void
	{
		_getBroadcaster().removeAllListeners();
		ModelLocator.getInstance( getOwner() ).unregisterModel( getName() );
		_sName = null;
	}

	public function addListener( oL ) : Void
	{
		_getBroadcaster().addListener(oL);
	}
	
	public function removeListener( oL ) : Void
	{
		_getBroadcaster().removeListener( oL );
	}
	
	public function addEventListener( e : EventType, oL, f : Function ) : Void
	{
		_getBroadcaster().addEventListener.apply( _getBroadcaster(), arguments );
	}
	
	public function removeEventListener( e : EventType, oL ) : Void
	{
		_getBroadcaster().removeEventListener( e, oL );
	}
	
	//
	private function _getBroadcaster() : EventBroadcaster
	{
		return _oEB;
	}
	
	private function _firePrivateEvent( e : IEvent ) : Void
	{
		getOwner().firePrivateEvent( e );
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