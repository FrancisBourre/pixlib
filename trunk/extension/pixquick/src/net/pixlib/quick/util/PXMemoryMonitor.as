/*
package net.pixlib.quick.util
{
	import net.pixlib.log.PXStringifier;
	/**
	[Event(name="change", type="flash.events.Event")]
	/**
	[Event(name="overflow", type="net.pixlib.quick.util.PXMemoryMonitor")]
	/**
	final public class PXMemoryMonitor extends EventDispatcher
	{
		// --------------------------------------------------------------------
		// Event types
		// --------------------------------------------------------------------
		/**
		public static const OVERFLOW : String = "overflow";

		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**
		private static  var _instance : PXMemoryMonitor ;

		/**
		private var _first : uint;

		/**
		private var _current : uint;

		/**
		private var _limit : uint;

		/**
		private var _interval : uint;

		/**
		private var _checkInterval : uint;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/** 
		public function get totalMemory() : uint
		{
			return System.totalMemory;
		}

		/**
		public function get applicationMemory() : uint
		{
			return _current - _first;
		}

		/** 
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

		/** 
		public function get tempo() : int
		{
			return _checkInterval;
		}

		/** @private */
		public function set tempo(n : int) : void
		{
			_checkInterval = n;
		}

		/**
		public var listen : Boolean = false;
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public static function getInstance() : PXMemoryMonitor
		{
			if (!(PXMemoryMonitor._instance is PXMemoryMonitor)) PXMemoryMonitor._instance = new PXMemoryMonitor();
			return PXMemoryMonitor._instance;
		}

		/**
		public static function release() : void
		{
			if (PXMemoryMonitor._instance is PXMemoryMonitor)
			{
				PXMemoryMonitor._instance._release();
				PXMemoryMonitor._instance = null;
			}
		}

		/**
		public function start() : void
		{
			_interval = setInterval(_checkMemory, _checkInterval);
		}

		/**
		public function stop() : void
		{
			clearInterval(_interval);
		}

		/**
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