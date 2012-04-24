/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */
package net.pixlib.quick.display
{
	import net.pixlib.log.PXStringifier;	import flash.display.DisplayObject;	import flash.geom.Point;

	/**
	 * Controls Display object using dynamic registration point.	 * 	 * @example	 * <listing>	 * 	 * var reg : PXRegDisplayObject = new PXRegDisplayObject(mySprite);	 * reg.registration = new Point(100, 100);	 * reg.rotation = 45;	 * </listing>	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 * 	 * @author Romain Ecarnot
	 */
	final public class PXRegDisplayObject
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**		 * @private		 * Stores display object target		 */
		private var _target : DisplayObject;

		/**		 * @private		 * Stores registration point		 */
		private var _reg : Point;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**		 * Registration point.		 * 		 * @param	x	X ccordinate		 * @param	y	Y ccordinate		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get registration() : Point
		{
			return _reg;
		}

		/** @private */
		public function set registration(p : Point) : void
		{
			_reg = p.clone();
		}

		/**		 * Returns <code>DisplayObject</code> target.		 * 		 * @return <code>DisplayObject</code> instance used as target		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get target() : DisplayObject
		{
			return _target;
		}

		/**		 * Indicates the x coordinate of the DisplayObject instance relative 		 * to the local coordinates of the parent DisplayObjectContainer.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get x() : Number
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			return p.x;
		}

		/** @private */
		public function set x(value : Number) : void
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.x += value - p.x;
		}

		/**		 * Indicates the y coordinate of the DisplayObject instance relative 		 * to the local coordinates of the parent DisplayObjectContainer.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get y() : Number
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			return p.y;
		}

		/** @private */
		public function set y(value : Number) : void
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.y += value - p.y;
		}

		/**		 * Indicates the horizontal scale (percentage) of the object 		 * as applied from the registration point.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get scaleX() : Number
		{
			return _target.scaleX;
		}

		/** @private */
		public function set scaleX(value : Number) : void
		{
			_setProperty("scaleX", value);
		}

		/**		 * Indicates the vertical scale (percentage) of an object 		 * as applied from the registration point of the object.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get scaleY() : Number
		{
			return _target.scaleY;
		}

		/** @private */
		public function set scaleY(value : Number) : void
		{
			_setProperty("scaleY", value);
		}

		/**		 * Indicates the rotation of the DisplayObject instance, in degrees, 		 * from its original orientation.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get rotation() : Number
		{
			return _target.rotation;
		}

		/** @private */
		public function set rotation(value : Number) : void
		{
			_setProperty("rotation", value);
		}

		/**		 * Indicates the rotation X of the DisplayObject instance, in degrees, 		 * from its original orientation.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get rotationX() : Number
		{
			return _target.rotationX;
		}

		/** @private */
		public function set rotationX(value : Number) : void
		{
			_setProperty("rotationX", value);
		}

		/**		 * Indicates the rotation Y of the DisplayObject instance, in degrees, 		 * from its original orientation.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get rotationY() : Number
		{
			return _target.rotationY;
		}

		/** @private */
		public function set rotationY(value : Number) : void
		{
			_setProperty("rotationY", value);
		}

		/**		 * Indicates the rotation Z of the DisplayObject instance, in degrees, 		 * from its original orientation.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get rotationZ() : Number
		{
			return _target.rotationZ;
		}

		/** @private */
		public function set rotationZ(value : Number) : void
		{
			_setProperty("rotationZ", value);
		}

		/**		 * Indicates the x coordinate of the mouse position, in pixels.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get mouseX() : Number
		{
			return Math.round(_target.mouseX - _reg.x);
		}

		/**		 * Indicates the y coordinate of the mouse position, in pixels.		 */
		public function get mouseY() : Number
		{
			return Math.round(_target.mouseY - _reg.y);
		}

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**		 * Creates new instance.		 * 		 * @param	target	<code>DisplayObject</code> to use as target		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function PXRegDisplayObject(target : DisplayObject)
		{
			if ( target != null )
			{
				registration = new Point(0, 0);
				_target = target;
			}
		}

		/**		 * Returns string representation of instance.		 * 		 * @return string representation of instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function toString() : String
		{
			return PXStringifier.process(this) + "[" + _reg.x + "," + _reg.y + "]";
		}		

		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------		
		/** @private */
		private function _setProperty(prop : String, value : Number) : void
		{
			var a : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target[prop] = value;
			var b : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.x -= b.x - a.x;
			_target.y -= b.y - a.y;
		}
	}
}
