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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * The StatsMeter class display performance informations about 
	 * current running application like, FPS, Instant memory, Max memory 
	 * and frame render time.
	 * 
	 * <p>Based on Mr.doob work available at http://github.com/mrdoob</p>
	 * 
	 * @example
	 * <listing>
	 * 
	 * addChild(new StatsMeter());
	 * // or
	 * addChild(new StatsMeter(StatsMeter.BOTTOM));
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXStatsMeter extends Sprite
	{
		// --------------------------------------------------------------------
		// Constants
		// --------------------------------------------------------------------

		/** 
		 * Constant definition to align StatMeter graphic on top of the 
		 * application.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static const TOP : String = "top";

		/** 
		 * Constant definition to align StatMeter graphic on bottom of the 
		 * application.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static const BOTTOM : String = "bottom";


		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _xml : XML;

		/**
		 * @private
		 */
		private var _field : TextField;

		/**
		 * @private
		 */
		private var _timer : uint;

		/**
		 * @private
		 */
		private var _fps : uint;

		/**
		 * @private
		 */
		private var _ms : uint;

		/**
		 * @private
		 */
		private var _msPrev : uint;

		/**
		 * @private
		 */
		private var _mem : Number;

		/**
		 * @private
		 */
		private var _memMax : Number;

		/**
		 * @private
		 */
		private var _place : String;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXStatsMeter(place : String = "top") : void
		{
			_memMax = 0;
			_place = place;

			addEventListener(Event.ADDED_TO_STAGE, _init, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, _destroy, false, 0, true);
		}

		/**
		 * @private
		 */
		private function _init(event : Event) : void
		{
			event.stopImmediatePropagation();

			_xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;

			var style : StyleSheet = new StyleSheet();
			style.setStyle('.xml', {fontSize:'10px', fontFamily:'Courier New'});
			style.setStyle('.os', {color:"#ffffff"});
			style.setStyle('.fps', {color:"#ffff00"});
			style.setStyle('.ms', {color:"#00ff00"});
			style.setStyle('.mem', {color:"#00ffff"});
			style.setStyle('.size', {color:"#ffc800"});

			_field = new TextField();
			_field.width = stage.stageWidth;
			_field.height = 14;
			_field.styleSheet = style;
			_field.condenseWhite = true;
			_field.selectable = false;
			_field.mouseEnabled = false;
			_field.backgroundColor = 0x000000;
			_field.background = true;
			addChild(_field);

			stage.addEventListener(Event.RESIZE, _onResize);
			_onResize(null);
			
			addEventListener(Event.ENTER_FRAME, _update);
		}

		/**
		 * @private
		 */
		private function _onResize(event : Event) : void
		{
			_field.x = _field.y = 0;
			_field.width = stage.stageWidth;

			_field.y = (_place == PXStatsMeter.TOP) ? 0 : stage.stageHeight - _field.height;
		}

		/**
		 * @private
		 */
		private function _destroy(event : Event) : void
		{
			event.stopImmediatePropagation();
			removeEventListener(Event.RESIZE, _onResize);
			removeEventListener(Event.ENTER_FRAME, _update);

			while (numChildren > 0) removeChildAt(0);
		}

		/**
		 * @private
		 */
		private function _update(event : Event) : void
		{
			event.stopImmediatePropagation();

			_timer = getTimer();

			if ( _timer - 1000 > _msPrev )
			{
				_msPrev = _timer;
				_mem = Number((System.totalMemory * 0.000000954).toFixed(2));
				_memMax = _memMax > _mem ? _memMax : _mem;

				_xml.fps = _fps + "/" + stage.frameRate;
				_xml.mem = _mem + "/" + _memMax;

				_fps = 0;
			}

			_fps++;

			_xml.ms = (_timer - _ms);
			_ms = _timer;

			_field.htmlText = "<span class='xml'><span class='os'>" + Capabilities.os + "</span>\t\t<span class='fps'>" + _xml.fps + "</span>\t\t<span class='mem'>" + _xml.mem + "</span>\t\t<span class='ms'>" + _xml.ms + "</span>\t\t<span class='size'>" + stage.stageWidth + "x" + stage.stageHeight + "</span></span>";
		}
	}
}