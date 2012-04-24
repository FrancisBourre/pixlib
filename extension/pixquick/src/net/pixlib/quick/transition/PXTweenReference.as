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
package net.pixlib.quick.transition
{
	import flash.display.DisplayObject;

	/**
	 * The PXTweenReference class stores DisplayObject properties for tweening 
	 * behaviour.
	 * 
	 * @see net.pixlib.quick.transition.PXTweenHelper
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 *
	 * @author Romain Ecarnot
	 */
	public class PXTweenReference
	{
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Indicates the x coordinate of the DisplayObject instance relative 
		 * to the local coordinates of the parent DisplayObjectContainer.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var x : Number;

		/**
		 * Indicates the y coordinate of the DisplayObject instance relative 
		 * to the local coordinates of the parent DisplayObjectContainer.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var y : Number;

		/**
		 * Indicates the horizontal scale (percentage) of the object as applied 
		 * from the registration point.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var scaleX : Number;

		/**
		 * Indicates the vertical scale (percentage) of an object as applied 
		 * from the registration point of the object.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var scaleY : Number;

		/**
		 * Indicates the depth scale (percentage) of an object as applied 
		 * from the registration point of the object.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var scaleZ : Number;

		/**
		 * Indicates the alpha transparency value of the object specified.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var alpha : Number;

		/**
		 * Indicates the rotation of the DisplayObject instance, in degrees, 
		 * from its original orientation.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var rotation : Number;

		/**
		 * Indicates the x-axis rotation of the DisplayObject instance, in 
		 * degrees, from its original orientation relative to the 3D parent 
		 * container.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var rotationX : Number;

		/**
		 * Indicates the y-axis rotation of the DisplayObject instance, in 
		 * degrees, from its original orientation relative to the 3D parent 
		 * container.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var rotationY : Number;

		/**
		 * Indicates the z-axis rotation of the DisplayObject instance, in 
		 * degrees, from its original orientation relative to the 3D parent 
		 * container.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var rotationZ : Number;


		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 * 
		 * @param dpo	Display object source
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXTweenReference(dpo : DisplayObject)
		{
			x = dpo.x;
			y = dpo.y;
			scaleX = dpo.scaleX;
			scaleY = dpo.scaleY;
			scaleZ = dpo.scaleZ;
			alpha = dpo.alpha;
			rotation = dpo.rotation;
			rotationX = dpo.rotationX;
			rotationY = dpo.rotationY;
			rotationZ = dpo.rotationZ;
		}
	}
}
