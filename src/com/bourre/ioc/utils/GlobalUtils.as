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

import com.bourre.ioc.bean.BeanFactory;
import com.bourre.ioc.events.ApplicationBroadcaster;
import com.bourre.ioc.log.PixiocDebug;

class com.bourre.ioc.utils.GlobalUtils 
{
	private function GlobalUtils() 
	{
		
	}
	
	public static function initGlobals() : Void
	{
		_global.__DISPATCH = GlobalUtils._DISPATCH_EVENT;
		_global.__LOG = GlobalUtils._LOG_MESSAGE;
		_global.__CONFIG = GlobalUtils._GET_CONFIG;
	}
	
	private static function _DISPATCH_EVENT( e ) : Void
	{
		PixiocDebug.getInstance().debug( e );
		ApplicationBroadcaster.getInstance().dispatchEvent( e, e.channel );
	}
	
	private static function _LOG_MESSAGE( o ) : Void
	{
		PixiocDebug.getInstance().debug( o );
	}
	
	private static function _GET_CONFIG( k : String )
	{
		return BeanFactory.getInstance().locate( k );
	}
}