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
 
import com.bourre.data.libs.GraphicLib;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;
	
class com.bourre.data.libs.GraphicLibLocatorEvent 
	extends BasicEvent 
{

	private var _sName : String;
	private var _gl : GraphicLib;
	
	public function GraphicLibLocatorEvent( e : EventType, name : String, gl : GraphicLib ) 
	{
		super( e );
		
		_sName = name;
		_gl = gl;
	}
	
	public function getName() : String
	{
		return _sName;
	}
	
	public function getGraphicLib() : GraphicLib
	{
		return _gl;
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