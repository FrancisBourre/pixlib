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

import com.bourre.commands.Command;
import com.bourre.core.HashCodeFactory;
import com.bourre.data.collections.Map;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.ioc.control.AbstractCommand;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.log.PixlibStringifier;
import com.bourre.utils.ClassUtils;

class com.bourre.ioc.control.PluginController 
{	private var _oEB : EventBroadcaster;
	
	private var _owner : IPlugin;	private var _mEventList : Map;
	
	public function PluginController( owner : IPlugin ) 
	{
		_owner = owner;
		_mEventList = new Map();
		
		_oEB = new EventBroadcaster( getOwner() );
		_oEB.addListener( this );
	}
	
	public function getOwner() : IPlugin
	{
		return _owner;
	}
	
	public function getLogger() : PixiocDebug
	{
		return PixiocDebug.getInstance( getOwner() );
	}
	
	public function getBroadcaster() : EventBroadcaster
	{
		return _oEB;
	}
	
	public function pushCommandClass( s : String, commandClass : Function ) : Void
	{
		_mEventList.put( s.toString(), ClassUtils.getFullyQualifiedClassName( commandClass ) );
	}
	
	public function pushCommandClassPath( s : String, sCommandClassPath : String ) : Void
	{
		s = s.toString();
		_mEventList.put( s, s, sCommandClassPath?sCommandClassPath:s );
	}
	
	public function remove( s : String ) : Void
	{
		_mEventList.remove( s.toString() );
	}
	
	private function handleEvent( e : IEvent ) : Void
	{
		_executeCommand( e );
	}
	
	public function getCommand( s : String ) : Command
	{
		if ( _mEventList.containsKey( s.toString() ) )
		{
			var className : String = _mEventList.get( s.toString() );
			var cmd : Command = HashCodeFactory.buildInstance( className );
			
			if (!cmd )
			{
				PixiocDebug.getInstance().fatal( this + ".getCommand() failed with '" + className + "' class name." );
				
			} else if ( ClassUtils.inheritsFromClass( cmd, AbstractCommand ) )
			{
				AbstractCommand( cmd ).setOwner( getOwner() );
				return cmd;
				
			} else if ( ClassUtils.implementsInterface( cmd, Command ) )
			{
				return cmd;
				
			} else
			{
				PixiocDebug.getInstance().fatal( this + ".getCommand() failed. '" + className + "' doesn't implement 'com.bourre.commands.Command' interface." );
				return null;
			}
			
		} else
		{
			getLogger().error( this + ".getCommand can't retrieve Command associated with '" + s + "'." );
			return null;
		}
	}

	private function _executeCommand( e : IEvent ) : Void
	{
		var t:String = (e.getType() == undefined) ? Object(e).type.toString() : e.getType().toString();
		getCommand( t ).execute( e );
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