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

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.structures.Rectangle;
import com.bourre.utils.Geom;
import com.bourre.ioc.plugin.IPlugin;

class com.bourre.ioc.visual.ScreenProtection 
	extends AbstractMovieClipHelper
{

	public static var DEFAULT_ID : String = "ScreenProtectionUI";
	public static var DEFAULT_DEPTH : Number = 9996;
	
	public function ScreenProtection ( owner : IPlugin, target : MovieClip, depth : Number, id : String, settings : Rectangle )
	{
		super( owner, id?id:ScreenProtection.DEFAULT_ID, target? target:_level0 );
		
		var w : Number = settings.width ? settings.width : Stage.width;
		var h : Number = settings.height ? settings.width : Stage.height;
		var x : Number = settings.x ? settings.x : 0;
		var y : Number = settings.y ? settings.y : 0;

		view = Geom.buildRectangle( view, depth?depth:ScreenProtection.DEFAULT_DEPTH, w, h );
		view._alpha = 0;
		move( x, y );
		view.onPress = new Function();
		view.useHandCursor = false;
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