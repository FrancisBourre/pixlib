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
 * {@code StringEvent} defines specific event structure to work with
 * {@code String} value.
 * 
 * <p>Based on {@link BasicEvent} class, {@code StringEvent} add access 
 * to his specific {@code String} property with  {@link #getString} and 
 * {@link #setString} methods.
 * 
 * @author Francis Bourre
 * @version 1.0
 */

import com.bourre.events.ValueObject;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;

class com.bourre.events.ValueObjectEvent extends BasicEvent
{
	//-------------------------------------------------------------------------
	// Private properties
	//-------------------------------------------------------------------------
	
	private var _o : ValueObject;
	
	
	//-------------------------------------------------------------------------
	// Public API
	//-------------------------------------------------------------------------
	
	public function ValueObjectEvent( sType : EventType, oTarget : Object, o : ValueObject )
	{
		super( sType, oTarget );
		_o = o;
	}
	
	
	public function getValueObject() : ValueObject
	{
		return _o;
	}
	
	/**
	 * Returns the string representation of this instance.
	 * 
	 * @return {@code String} representation of this instance
	 */
	public function toString() : String
	{
		return PixlibStringifier.stringify( this ) + ' : ' + getType() + ', ' + getValueObject();
	}
}