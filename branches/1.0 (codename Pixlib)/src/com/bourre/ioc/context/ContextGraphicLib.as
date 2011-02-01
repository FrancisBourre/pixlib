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

import com.bourre.data.libs.GraphicLibLocator;
import com.bourre.data.libs.OrphanGraphicLib;
import com.bourre.ioc.bean.BeanFactory;
import com.bourre.ioc.parser.ContextNodeNameList;
import com.bourre.log.PixlibDebug;
import com.bourre.log.PixlibStringifier;

class com.bourre.ioc.context.ContextGraphicLib 
	extends OrphanGraphicLib
{
	public function ContextGraphicLib( parentLocatorKey : String, nDepth:Number, bAutoShow:Boolean ) 
	{
		super( (parentLocatorKey==ContextNodeNameList.ROOT?null:parentLocatorKey), nDepth, bAutoShow );
	}
	
	private function _getContainer( mcTarget : MovieClip, depth : Number ) : MovieClip
	{
		if ( GraphicLibLocator.getInstance().isRegistered(_sParentLocatorKey) )
			mcTarget = GraphicLibLocator.getInstance().getGraphicLib( _sParentLocatorKey ).getView();
			
		if (mcTarget == undefined) 
		{
			mcTarget = BeanFactory.getInstance().locate( _sParentLocatorKey );

			if ( mcTarget && mcTarget instanceof MovieClip )
			{
				return ContextGraphicLib._getMovieClipContainer( mcTarget, depth );
				
			} else
			{
				PixlibDebug.FATAL( this + " MovieClip target is undefined." );
				return null;
			}
		} else
		{
			return ContextGraphicLib._getMovieClipContainer( mcTarget, depth );
		}
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