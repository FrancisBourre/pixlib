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
import com.bourre.ioc.loader.ApplicationLoader;
import com.bourre.ioc.loader.ApplicationLoaderEvent;
import com.bourre.ioc.loader.IApplicationLoaderListener;
import com.bourre.ioc.utils.GlobalUtils;
import com.bourre.log.Logger;
import com.bourre.log.PixlibStringifier;
import com.bourre.utils.LuminicTracer;

class com.bourre.ioc.application.Application
	implements IApplicationLoaderListener
{
	private function Application( mc : MovieClip )
	{
		GlobalUtils.initGlobals();

		var al : ApplicationLoader = new ApplicationLoader();
		al.addListener( this );
		al.load();
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String
	{
		return PixlibStringifier.stringify( this );
	}

	public static function main( mc : MovieClip ) : Void
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		mc._focusRect = false;

		Logger.getInstance().addLogListener( LuminicTracer.getInstance() );
		var o:Application = new Application( mc );
	}
	
	/**
	 * IApplicationLoaderListener callbacks
	 */
	public function onApplicationBuilt( e : ApplicationLoaderEvent ) : Void
	{
		//
	}

	public function onApplicationInit( e : ApplicationLoaderEvent ) : Void
	{
		//
	}

	public function onLoadInit( e : LibEvent ) : Void
	{
		//
	}

	public function onLoadProgress( e : LibEvent ) : Void
	{
		//
	}

	public function onTimeOut( e : LibEvent ) : Void
	{
		//
	}
}