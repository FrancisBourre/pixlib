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
package net.pixlib.quick.document.preloader
{
	import flash.display.Sprite;


	/**
	 * The PreloaderDisplay class gives default implementation for 
	 * object used in application loading progression.
	 * 
	 * @see net.pixlib.document.DocumentPreloader
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXPreloaderDisplay extends Sprite
	{
		/**
		 * Updates preloader fx.
		 * 
		 * <p>Overrides to implements your own behaviour.</p>
		 * 
		 * @param percent	Loading percent value
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function update(percent : Number) : void
		{

		}

		/**
		 * Clears preloader fx.
		 * 
		 * <p>Overrides to implements your own behaviour.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function clear() : void
		{

		}
	}
}
