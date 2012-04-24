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

import com.bourre.core.ILocator;
import com.bourre.data.collections.Map;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.model.ModelLocator 
	implements ILocator
{
	private static var _M : Map = new Map();
	
	private var _owner : IPlugin;
	
	private function ModelLocator( owner : IPlugin ) 
	{
		_owner = owner;
		_logger = PixiocDebug.getInstance( getOwner() );
		_m = new Map();
	}
	
	public static function getInstance( owner : IPlugin ) : ModelLocator
	{
		if ( !(ModelLocator._M.containsKey( owner )) ) ModelLocator._M.put( owner, new ModelLocator(owner) );
		return ModelLocator._M.get( owner );
	}
	
	public function getOwner() : IPlugin
	{
		return _owner;
	}
	
	public function isRegistered( key : String ) : Boolean 
	{
		return _m.containsKey( key );
	}

	public function locate( key : String ) 
	{
		if ( !(isRegistered( key )) ) _logger.error( "Can't locate model instance with '" + key + "' name in " + this );
		return _m.get( key );
	}
	
	public function getModel( key : String ) : AbstractModel
	{
		return locate( key );
	}
	
	public function registerModel( key : String, o : AbstractModel ) : Boolean
	{
		if ( isRegistered( key ) )
		{
			_logger.fatal( "model instance is already registered with '" + key + "' name in " + this );
			return false;
			
		} else
		{
			_m.put( key, o );
			return true;
		}
	}
	
	public function unregisterModel( key : String ) : Void
	{
		_m.remove( key );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this ) + (_owner?", owner: "+_owner:"No owner.");
	}
}