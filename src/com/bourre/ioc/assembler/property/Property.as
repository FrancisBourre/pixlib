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

import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.assembler.property.Property 
{
	private var _sOwnerID : String;	private var _sName : String;
	private var _sValue : String;
	private var _sType : String;
	private var _sRef : String;
	private var _sMethod : String;
	
	private function Property( ownerID : String, name : String, value : String, type : String, ref : String, method : String ) 
	{
		_sOwnerID = ownerID;
		_sName = name;		_sType = type;		_sRef = ref;
		_sValue = value;
		_sMethod = method;
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