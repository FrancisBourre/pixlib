/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */
package net.pixlib.quick.util
{
	import net.pixlib.log.PXStringifier;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.system.System;	import flash.utils.clearInterval;	import flash.utils.setInterval;	
	/**	 * Dispatched when amount of total memory has changed and/or if  	 * <code>listen</code> is true.	 *  	 * @eventType flash.events.Event.CHANGE	 *  	 * @langversion 3.0	 * @playerversion Flash 10	 */
	[Event(name="change", type="flash.events.Event")]	
	/**	 * Dispatched when memory limit is reached and exceeded.	 *  	 * @see #overflow	 *  	 * @eventType net.pixlib.quick.util.MemoryMonitor.OVERFLOW	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 */
	[Event(name="overflow", type="net.pixlib.quick.util.PXMemoryMonitor")]	
	/**	 * The MemoryMonitor class allow application's memory monitoring.	 * 	 * @example	 * <listing>	 * 	 * var monitor : MemoryMonitor = MemoryMonitor.getInstance();	 * monitor.addEventListener( MemoryMonitor.OVERFLOW, onOverflowHandler );	 * 	 * // to listen memory variation	 * monitor.listen = true;	 * monitor.addEventListener( Event.CHANGE, onMemoryChangeHandler );	 * </listing>	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 * 	 * @author Romain Ecarnot	 */
	final public class PXMemoryMonitor extends EventDispatcher
	{
		// --------------------------------------------------------------------
		// Event types
		// --------------------------------------------------------------------		
		/**		 * Defines the value of the <code>type</code> property of the event 		 * object for an <code>overflow</code> event.		 * 		 * <p>The properties of the event object have the following values:</p>		 *  <table class="innertable">		 *     <tr><th>Property</th><th>Value</th></tr>		 *     <tr>		 *      <td><code>target</code></td>		 *      <td>The Object that defines the event listener that handles the event</td>		 *     </tr>		 *     <tr>		 *      <td><code>type</code></td>		 *      <td>Dispatched event type</td>		 *     </tr>		 *     <tr>		 *      <td><code>totalMemory</code></td>		 *      <td>The amount of memory (in bytes) currently in use by 		 *      Adobe Flash Player or Adobe AIR™</td>		 *     </tr>		 *  </table>		 * 		 * @eventType overflow		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public static const OVERFLOW : String = "overflow";		

		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------		
		/**		 * @private		 * Stores singleton instance		 */
		private static  var _instance : PXMemoryMonitor ;

		/**		 * @private 		 * Stores memory quantity when singleton is instanciated		 */
		private var _first : uint;

		/**		 * @private		 * Current application memory		 */
		private var _current : uint;

		/**		 * @private		 * Memory limit		 */
		private var _limit : uint;

		/**		 * @private		 * Stores setInterval call		 */
		private var _interval : uint;

		/**		 * @private		 * Memory check delay		 */
		private var _checkInterval : uint;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------		
		/** 		 * The amount of memory (in bytes) currently in use by 		 * Adobe Flash Player or Adobe AIR™.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get totalMemory() : uint
		{
			return System.totalMemory;
		}

		/**		 * The amount of memory (in bytes) currently in use by 		 * application.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get applicationMemory() : uint
		{
			return _current - _first;
		}

		/** 		 * Amount of memory limit to be monitored.<br/>		 * When this limit is reached and exceeded, an event is dispatched.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get overflow() : uint
		{
			return _limit;
		}

		/** @private */
		public function set overflow(n : uint) : void
		{
			if (n != _limit)
			{
				_limit = n;
				_checkOverflow();
			}
		}

		/** 		 * Monitoring tempo (in milliseconds).		 * 		 * @default 1000		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get tempo() : int
		{
			return _checkInterval;
		}

		/** @private */
		public function set tempo(n : int) : void
		{
			_checkInterval = n;
		}

		/**		 * Listens memory variation.		 * 		 * <p>If <code>true</code> an Event Event.CHANGE is dispatched 		 * each time the memory amount has changed.</p> 		 * 		 * @default false		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public var listen : Boolean = false;
				
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------		
		/**		 * Returns singleton instance of MemoryMonitor class.		 * 		 * @return The singleton instance of MemoryMonitor class.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public static function getInstance() : PXMemoryMonitor
		{
			if (!(PXMemoryMonitor._instance is PXMemoryMonitor)) PXMemoryMonitor._instance = new PXMemoryMonitor();
			return PXMemoryMonitor._instance;
		}

		/**		 * Releases singleton instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public static function release() : void
		{
			if (PXMemoryMonitor._instance is PXMemoryMonitor)
			{
				PXMemoryMonitor._instance._release();
				PXMemoryMonitor._instance = null;
			}
		}

		/**		 * Starts monitoring.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function start() : void
		{
			_interval = setInterval(_checkMemory, _checkInterval);
		}

		/**		 * Stops monitoring.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function stop() : void
		{
			clearInterval(_interval);
		}

		/**		 * Returns string representation of instance.		 * 		 * @return The string representation of instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		override public function toString() : String
		{
			return PXStringifier.process(this) + applicationMemory + "/" + totalMemory;
		}
				
		// --------------------------------------------------------------------
		// Private implementation
		// --------------------------------------------------------------------		
		/** @private */
		function PXMemoryMonitor()
		{
			_first = System.totalMemory;
			_current = _first;
			_limit = 0;
			_checkInterval = 1000;
		}

		/** @private */
		private function _checkMemory() : void
		{
			var total : uint = totalMemory;
			if ( total != _current )
			{
				_current = total;
				if (listen) dispatchEvent(new Event(Event.CHANGE));
				_checkOverflow();
			}
		}

		/** @private */
		private function _checkOverflow() : void
		{
			if ( _limit > 0 && _current > _limit)
			{
				dispatchEvent(new Event(OVERFLOW));
			}
		}

		/** @private */
		private function _release() : void
		{
			stop();
		}
	}
}