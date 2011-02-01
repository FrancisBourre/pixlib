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

import com.bourre.data.request.AbstractDataRequest;
import com.bourre.events.IEvent;
import com.bourre.utils.SharedObjectUtils;

class com.bourre.data.request.SharedObjectLoadRequest 
	extends AbstractDataRequest
{
	private var _sCookieName : String;	private var _sTargetName : String;
	
	public function SharedObjectLoadRequest( cookieName : String, targetName : String ) 
	{
		super();
		
		setURL( cookieName );
		setArguments( targetName ); 
	}
	
	public function setURL( url : String ) : Void
	{
		_sCookieName = url;
	}
	
	public function setArguments( targetName : String ) : Void
	{
		_sTargetName = targetName;
	}
	
	public function execute( e : IEvent ) : Void
	{
		_oResult = null;
		_oResult = SharedObjectUtils.loadLocal( _sCookieName, _sTargetName );
		
		if ( _oResult )
		{
			fireEvent( _eResult );
			
		} else
		{
			fireEvent( _eError );
		}
	}
}