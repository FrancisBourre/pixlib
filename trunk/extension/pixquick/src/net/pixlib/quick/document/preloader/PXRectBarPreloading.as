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

	/**
	 * The RectBarPreloading class draw a simple rectangular progression bar 
	 * to represent application loading progression.
	 * 
	 * @see net.pixlib.document.DocumentPreloader
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXRectBarPreloading extends PXPreloaderDisplay
	{
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Indicates the width of the preloading bar.
		 * 
		 * @default 200
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var barWidth : Number = 200;

		/**
		 * Indicates the height of the preloading bar.
		 * 
		 * @default 12
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var barHeight : Number = 12;

		/**
		 * Indicates the color of bar border.
		 * 
		 * @default 0x000000
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var borderColor : uint = 0x000000;

		/**
		 * Indicates the alpha of bar border.
		 * 
		 * @default 0.5
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var borderAlpha : Number = 0.5;

		/**
		 * Indicates the color of bar background.
		 * 
		 * @default 0x000000
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var backgroundColor : uint = 0x000000;

		/**
		 * Indicates the alpha of bar background.
		 * 
		 * @default 0.5
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var backgroundAlpha : Number = 0.5;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXRectBarPreloading()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		override public function update(percent : Number) : void
		{
			with(graphics) {
				clear();
				lineStyle(1, borderColor, 0.5);
				drawRect(0, 0, barWidth, barHeight);
				lineStyle(1, 0xFFFFFF, 1);
				drawRect(1, 1, barWidth - 2, barHeight - 2);
				beginFill(0xFFFFFF, 1);
				drawRect(1, 1, (barWidth - 2) * percent, barHeight - 2);
				endFill();
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function clear() : void
		{
			graphics.clear();
		}
	}
}