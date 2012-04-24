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
	import net.pixlib.core.PXApplication;
	import net.pixlib.log.PXStringifier;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	/**
	 * Dispatched when user becomes active.
	 *  
	 * @eventType flash.events.Event.ACTIVATE
	 *  
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	[Event(name="activate", type="flash.events.Event")]

	/**
	 * Dispatched when user becomes inactive.
	 *  
	 * @eventType flash.events.Event.DEACTIVATE
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 */
	[Event(name="deactivate", type="flash.events.Event")]

	/**
	 * IDLEMonitor class allow to follow user activity.
	 * 
	 * @example Using IDLEMonitor manager
	 * <listing>
	 * 
	 * var monitor : IDLEMonitor = IDELMonitor.getInstance();
	 * monitor.addEventListener(Event.ACTIVATE, onWakeUp);
	 * monitor.addEventListener(Event.DEACTIVATE, onSleepMode)
	 * monitor.start();
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXIDLEMonitor extends EventDispatcher
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 * Stores singleton access 
		 */
		private static var _instance : PXIDLEMonitor;

		/**
		 * @private
		 * Stores application stage reference.
		 */
		private var _stage : Stage;

		/**
		 * @private 
		 * Stores Timer instance
		 */
		private var _timer : Timer;

		/**
		 * @private
		 * Stores user inactivity time
		 */
		private var _idleTime : uint;

		/**
		 * @private
		 * Stores user activity state
		 */
		private var _activity : Boolean;

		/**
		 * @private
		 * Running state
		 */
		private var _running : Boolean;


		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Returns <code>true</code> if user is currently active.
		 * 
		 * @return <code>true</code> if user is currently active.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function get isActive() : Boolean
		{
			return _activity;
		}

		/**
		 * Returns inactive time (in milliseconds).
		 * 
		 * @return inactive time (in milliseconds)
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function get idleTime() : uint
		{
			return _idleTime;
		}

		/**
		 * Time in millisecondes before declaring inactivity mode.
		 * 
		 * @default
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function get inactiveDelay() : uint
		{
			return _timer.delay;
		}

		/**
		 * @private
		 */
		public function set inactiveDelay(value : uint) : void
		{
			if (value != _timer.delay)
			{
				if (isRunning()) stop();

				_timer.delay = value;
			}
		}


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Returns singleton instance of IDLEMonitor class.
		 * 
		 * @return The singleton instance of IDLEMonitor class.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public static function getInstance() : PXIDLEMonitor
		{
			if (!(PXIDLEMonitor._instance is PXIDLEMonitor))
				PXIDLEMonitor._instance = new PXIDLEMonitor();

			return PXIDLEMonitor._instance;
		}

		/**
		 * Starts the activity monitor.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function start() : void
		{
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoveHandler);

			_timer.addEventListener(TimerEvent.TIMER, _onTimerHandler);
			_timer.start();

			_running = true;
		}

		/**
		 * Stops the activity monitor.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function stop() : void
		{
			_idleTime = 0;

			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER, _onTimerHandler);

			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoveHandler);

			_running = false;
		}

		/**
		 * Returns <code>true</code> if activity is monitored.
		 * 
		 * @return <code>true</code> if activity is monitored.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		public function isRunning() : Boolean
		{
			return _running;
		}

		/**
		 * Returns string representation.
		 * 
		 * @return string representation.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 */
		override public function toString() : String
		{
			return PXStringifier.process(this);
		}


		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 * Creates IDLEMonitor instance.  
		 */
		function PXIDLEMonitor() : void
		{
			_activity = true;
			_stage = PXApplication.getInstance().root.stage;
			_idleTime = 0;
			_timer = new Timer(10000);
			_running = false;
		}

		/** @private */
		private function _onMouseMoveHandler(event : MouseEvent) : void
		{
			if (_stage.mouseX < 0) return;

			if (!_activity) dispatchEvent(new Event(Event.ACTIVATE));

			_activity = true;
			_idleTime = 0;
			_timer.reset();
			_timer.start();
		}

		/**
		 * @private
		 * User is inactive, sets the idle time and dispatch Event.DEACTIVATE 
		 * event.
		 */
		private function _onTimerHandler(event : TimerEvent) : void
		{
			_idleTime += _timer.delay;

			if (_activity) dispatchEvent(new Event(Event.DEACTIVATE));

			_activity = false;
		}
	}
}