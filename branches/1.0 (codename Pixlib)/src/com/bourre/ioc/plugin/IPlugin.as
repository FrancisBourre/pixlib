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

import com.bourre.events.IEvent;
import com.bourre.ioc.control.PluginController;
import com.bourre.ioc.log.PixiocDebug;
import com.bourre.ioc.model.ModelLocator;
import com.bourre.ioc.visual.MovieClipHelperLocator;

interface com.bourre.ioc.plugin.IPlugin 
{
	public function onInitPlugin() : Void;
	public function onReleasePlugin() : Void;
	
	public function fireExternalEvent( e : IEvent, channel : String ) : Void;
	public function firePublicEvent( e : IEvent ) : Void;
	public function firePrivateEvent( e : IEvent ) : Void;
	
	public function getChannel() : String;
	public function getController() : PluginController;
	public function getModelLocator() : ModelLocator;
	public function getMovieClipHelperLocator() : MovieClipHelperLocator;
	public function getLogger() : PixiocDebug;
}