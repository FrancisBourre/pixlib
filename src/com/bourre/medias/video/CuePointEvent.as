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

import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;
import com.bourre.medias.video.VideoDisplay;
import com.bourre.medias.video.VideoDisplayEvent;

class com.bourre.medias.video.CuePointEvent 
	extends VideoDisplayEvent 
{

	private var _oCuePointInfo : Object;
	
	public function CuePointEvent ( e : EventType, oLib : VideoDisplay, cuePointInfo : Object ) 
	{
		super( e, oLib );

		_oCuePointInfo = cuePointInfo;
	}
	
	public function getCuePointInfo() : Object
	{
		return _oCuePointInfo;
	}
	
	public function getNameInfo() : String
	{
		return getCuePointInfo().name;
	}
	
	public function getTimeInfo() : String
	{
		return getCuePointInfo().time;
	}
	
	public function getTypeInfo() : String
	{
		return getCuePointInfo().type;
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