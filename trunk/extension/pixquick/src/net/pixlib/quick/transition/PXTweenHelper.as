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
	import flash.utils.Dictionary;

	/**
	 * TweenHelper act as a repository to store display objects properties.
	 * 
	 * @example
	 * <listing>
	 * 
	 * var rotator : Sprite = addChild(new Sprite());
	 * with(rotator.graphics) {
	 * 	beginFill(0xFF0000, 1);
	 * 	drawRect(0, 0, 100, 100);
	 * 	endFill();
	 * }
	 * 
	 * PXTweenHelper.register(rotator);
	 * 
	 * rotator.x -= 10;
	 * TweenMax.to(rotator, 1, {x : PXTweenHelper.get(rotator).x, rotation : 45});
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 *
	 * @author Romain Ecarnot
	 */
	final public class PXTweenHelper
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		
		/**
		 * @private
		 * Stores object properties.
		 */
		private static var _dico : Dictionary = new Dictionary();


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Registers passed-in display object in repository.
		 * 
		 * <p>When objects was stored, current properties of object are stored.<br />
		 * Take a look at TweenReference class to know which properties are 
		 * stored.</p>
		 * 
		 * @param dpo	Display object to store
		 * 
		 * @see net.pixlib.quick.transition.PXTweenReference
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function register(dpo : DisplayObject) : void
		{
			_dico[dpo] = new PXTweenReference(dpo);
		}

		/**
		 * Removes passed-in display object from repository.
		 * 
		 * @param dpo	Display object to remove
		 * 
		 * @see net.pixlib.quick.transition.PXTweenReference
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function unregister(dpo : DisplayObject) : void
		{
			if (_dico[dpo] != null) delete _dico[dpo];
		}

		/**
		 * Returns PXTweenReference instance for passed-in display object.
		 * 
		 * <p>If Display object is not yet in repository, stores it first.</p>
		 * 
		 * @param dpo	Display object to check
		 * 
		 * @return PXTweenReference instance for passed-in display object.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get(dpo : DisplayObject) : PXTweenReference
		{
			if (_dico[dpo] != null)
			{
				return _dico[dpo];
			}
			else
			{
				register(dpo);
				return get(dpo);
			}
		}


		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		function PXTweenHelper()
		{
		}
	}
}
