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
package net.pixlib.quick.util
{
	import net.pixlib.log.PXDebug;
	import net.pixlib.structures.PXDimension;
	import net.pixlib.utils.PXDisplayUtils;
	import flash.display.DisplayObject;

	/**
	 * The PXLayoutUtils utility class is an all-static class with methods for 
	 * working with display objects layout.
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 *
	 * @author Romain Ecarnot
	 */
	final public class PXLayoutUtils
	{		 
		public static const ALIGN_TOP_LEFT		: uint = 0;
		public static const ALIGN_TOP_RIGHT		: uint = 1;
		public static const ALIGN_TOP_CENTER	: uint = 2;
		public static const ALIGN_MIDDLE_LEFT	: uint = 3;
		public static const ALIGN_MIDDLE_RIGHT	: uint = 4;
		public static const ALIGN_MIDDLE_CENTER	: uint = 5;
		public static const ALIGN_BOTTOM_LEFT	: uint = 6;
		public static const ALIGN_BOTTOM_RIGHT	: uint = 7;
		public static const ALIGN_BOTTOM_CENTER	: uint = 8;
		 
		/**
		 * Centers vertically foreground DisplayObject relative to background DisplayObject.
		 * 
		 * foreground	DisplayObject instance to center
		 * background	DisplayObject reference
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 */
		 
		public static function centerVertically(foreground : DisplayObject, background : DisplayObject) : void
		{
			foreground.y = (background.height >> 1) + (foreground.height >> 1);
		}

		/**
		 * Centers horizontally foreground DisplayObject relative to background DisplayObject.
		 * 
		 * foreground	DisplayObject instance to center
		 * background	DisplayObject reference
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 */
		public static function centerHorizontally(foreground : DisplayObject, background : DisplayObject) : void
		{
			foreground.x = (background.width >> 1) - (foreground.width >> 1);
		}

		/**
		 * Centers foreground DisplayObject relative to background DisplayObject.
		 * 
		 * foreground	DisplayObject instance to center
		 * background	DisplayObject reference
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 */
		public static function center(foreground : DisplayObject, background : DisplayObject) : void
		{
			centerHorizontally(foreground, background);
			centerVertically(foreground, background);
		}

		/**
		 * Aligns passed-in foreground object using passed-in 
		 * background object reference with passed-in alignement on padding properties.
		 * 
		 * <p>alignement properties can be
		 * <ul>
		 * 	<li>PXLayoutUtils#ALIGN_TOP_LEFT</li>
		 * 	<li>PXLayoutUtils#ALIGN_TOP_RIGHT</li>
		 * 	<li>PXLayoutUtils#ALIGN_TOP_CENTER</li>
		 * 	<li>PXLayoutUtils#ALIGN_MIDDLE_LEFT</li>
		 * 	<li>PXLayoutUtils#ALIGN_MIDDLE_RIGHT</li>
		 * 	<li>PXLayoutUtils#ALIGN_MIDDLE_CENTER</li>
		 * 	<li>PXLayoutUtils#ALIGN_BOTTOM_LEFT</li>
		 * 	<li>PXLayoutUtils#ALIGN_BOTTOM_RIGHT</li>
		 * 	<li>PXLayoutUtils#ALIGN_BOTTOM_CENTER</li> 
		 *	</ul>
		 * </p>
		 *	
		 * @param foreground	DisplayObject instance to align
		 * @param background	DisplayObject reference
		 * @param alignement	(optional) Alignement process
		 * @param padding		(optional) Padding alignement
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function align (foreground : DisplayObject, background : DisplayObject, alignement : uint = 5, padding : PXDimension =  null) : void
		{
			if(!foreground || !background) return;
			if(!padding)padding =  new PXDimension(0,0);
			
			switch(alignement)
			{
				case ALIGN_TOP_LEFT:
				{
					foreground.x = padding.width;		
					foreground.y = padding.height;						
					break;		
				}
				case ALIGN_TOP_RIGHT:
				{
					foreground.x = background.width - foreground.width + padding.width ;		
					foreground.y = padding.height;		
					break;		
				}
				case ALIGN_TOP_CENTER:
				{
					foreground.x = ((background.width - foreground.width) >> 1) + padding.width;		
					foreground.y = padding.height;							
					break;		
				}
				case ALIGN_MIDDLE_LEFT:
				{
					foreground.x = padding.width;				
					foreground.y = ((background.height - foreground.height) >> 1) + padding.height;		
					break;		
				}
				case ALIGN_MIDDLE_RIGHT:
				{
					foreground.x = background.width - foreground.width + padding.width ;		
					foreground.y = ((background.height - foreground.height) >> 1) + padding.height;		
					break;		
				}
				case ALIGN_MIDDLE_CENTER:
				{
					foreground.x = ((background.width - foreground.width) >> 1) + padding.width;		
					foreground.y = ((background.height - foreground.height) >> 1) + padding.height;		
					break;		
				}
				case ALIGN_BOTTOM_LEFT:
				{
					foreground.x = padding.width;		
					foreground.y = background.height - foreground.height + padding.height;		
					break;		
				}
				case ALIGN_BOTTOM_RIGHT:
				{
					foreground.x = background.width - foreground.width + padding.width ;			
					foreground.y = background.height - foreground.height + padding.height;	
					break;		
				}
				case ALIGN_BOTTOM_CENTER:
				{
					foreground.x = ((background.width - foreground.width) >> 1) + padding.width;		
					foreground.y = background.height - foreground.height + padding.height;	
					break;		
				}
				default:
				PXDebug.WARN("Alignment is not registered : " + alignement,PXLayoutUtils);
			}
		}

		/**
		 * Resizes passed-in <code>object</code> in <code>bounds</code> dimension.
		 * 
		 * <p>If <code>debug</code> is <code>true</code>, logs source and 
		 * result dimension using <strong>Palmer</strong> Loggin API.</p>
		 * 
		 * @param object	Object to resize
		 * @param bounds	Maximum dimension for resizing
		 * @param debug		(optional) Logs (or not) output messages 
		 * 					( default is <code>false</code> )
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 */
		public static function resize(object : DisplayObject, bounds : PXDimension, debug : Boolean = false) : void
		{
			if ( ( object == null ) || ( bounds == null ) ) return;

			var ratio : Number = object.height / object.width;

			object.width = bounds.width;
			object.height = Math.round(object.width * ratio);

			if (object.width > bounds.width)
			{
				object.width = bounds.width;
				object.height = Math.round(object.width * ratio);
			}

			if (object.height > bounds.height )
			{
				object.height = bounds.height;
				object.width = Math.round(object.height / ratio);
			}

			if ( debug )
			{
				PXDebug.DEBUG(" source = " + object.width + "x" + object.height, PXDisplayUtils);
				PXDebug.DEBUG(" bounds = " + bounds.width + "x" + bounds.height, PXDisplayUtils);
				PXDebug.DEBUG(" resize = " + object.width + "x" + object.height, PXDisplayUtils);
			}
		}

		/**
		 * Returns resized dimension of passed-in <code>object</code> in 
		 * <code>bounds</code> dimension.
		 * 
		 * @return	resized dimension of passed-in <code>object</code> in 
		 * 			<code>bounds</code> dimension.
		 * 			
		 * @param object	Object source
		 * @param bounds	New bounds for resizing
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 */
		public static function getResizedDimension(object : DisplayObject, bounds : PXDimension) : PXDimension
		{
			if ( ( object == null ) || ( bounds == null ) ) return null;

			var ratio : Number = object.height / object.width;
			var w : Number;
			var h : Number;

			w = bounds.width;
			h = Math.round(object.width * ratio);

			if (w > bounds.width)
			{
				w = bounds.width;
				h = Math.round(object.width * ratio);
			}

			if (h > bounds.height)
			{
				h = bounds.height;
				w = Math.round(object.height / ratio);
			}

			return new PXDimension(w, h);
		}
	}
}
