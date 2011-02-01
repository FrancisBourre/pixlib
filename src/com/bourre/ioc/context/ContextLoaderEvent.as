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

import com.bourre.data.libs.LibEvent;
import com.bourre.events.EventType;
import com.bourre.ioc.context.Context;
import com.bourre.ioc.context.ContextLoader;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.context.ContextLoaderEvent 
	extends LibEvent 
{
	public function ContextLoaderEvent( e : EventType, oLib : ContextLoader ) 
	{
		super( e, oLib );
	}
	
	public function getLib() : ContextLoader
	{
		return ContextLoader( super.getLib() );
	}
	
	public function getContext() : Context
	{
		return getLib().getContext();
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