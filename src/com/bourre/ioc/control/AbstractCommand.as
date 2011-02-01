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
import com.bourre.events.IEvent;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.model.ModelLocator;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.visual.MovieClipHelperLocator;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.control.AbstractCommand 
	implements Command
{
	private var _owner : IPlugin;
	
	private function AbstractCommand() 
	{
		
	}

	public function execute( e : IEvent ) : Void 
	{
		getLogger().error( this + ".execute() must be implemented in concrete class." );
	}
	
	public function getOwner() : IPlugin
	{
		return _owner;
	}
	
	public function setOwner( owner : IPlugin ) : Void
	{
		_owner = owner;
	}
	
	public function getModelLocator() : ModelLocator
	{
		return getOwner().getModelLocator();
	}
	
	public function getMovieClipHelperLocator() : MovieClipHelperLocator
	{
		return getOwner().getMovieClipHelperLocator();
	}
	
	public function getLogger() : PixiocDebug
	{
		return PixiocDebug.getInstance( getOwner() );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this );
	}
	
	//
	private function _firePrivateEvent( e : IEvent ) : Void
	{
		getOwner().firePrivateEvent( e );
	}
}