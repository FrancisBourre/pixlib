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
import com.bourre.data.request.IDataRequestListener;
import com.bourre.events.IEvent;

interface com.bourre.data.request.IDataRequest 
	extends Command
{
	public function setURL( url : String ) : Void;
	public function getResult();
	public function setArguments() : Void;
	public function fireEvent( e : IEvent ) : Void;
	public function addListener( listener : IDataRequestListener ) : Void;
	public function removeListener( listener : IDataRequestListener ) : Void;
}