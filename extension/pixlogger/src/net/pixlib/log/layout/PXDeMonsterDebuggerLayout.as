/*
package net.pixlib.log.layout
{
	import net.pixlib.log.PXStringifier;
	import net.pixlib.collections.PXHashMap;
	import net.pixlib.log.PXLogEvent;
	import net.pixlib.log.PXLogLevel;
	import net.pixlib.log.PXLogListener;

	import flash.events.Event;

	/**
	final public class PXDeMonsterDebuggerLayout implements PXLogListener
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**
		private static  var _oI : PXDeMonsterDebuggerLayout ;

		// --------------------------------------------------------------------
		// Protected properties
		// --------------------------------------------------------------------
		/** 
		protected var mColorLevel : PXHashMap;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		public static var CLIENT : Class = MonsterDebugger;
		
		/**
		public static var ROOT : Object = null;

		/**
		public static var AUTO_CLEAR : Boolean = true;

		/**
		public static var DEBUG_METHOD : String = "trace";

		/**
		public static var CLEAR_METHOD : String = "clearTraces";

		/**
		public static var DEPTH : uint = 4;

		/**
		public static var FUNCTIONS : Boolean = false;
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public static function getInstance() : PXDeMonsterDebuggerLayout
		{
			if (!_oI) _oI = new PXDeMonsterDebuggerLayout();
			return _oI;
		}

		/**
		public static function release() : void
		{
			if ( PXDeMonsterDebuggerLayout._oI is PXDeMonsterDebuggerLayout ) 
		}

		/**
		public function onLog(event : PXLogEvent) : void
		{
			if ( CLIENT.hasOwnProperty(DEBUG_METHOD) )
			{
				CLIENT[ DEBUG_METHOD ](event.logTarget, event.message, mColorLevel.get(event.level), FUNCTIONS, DEPTH);
			}
		}

		/**
		public function onClear(event : Event = null) : void
		{
			if ( CLIENT.hasOwnProperty(CLEAR_METHOD) )
			{
				CLIENT[ CLEAR_METHOD ]();
			}
		}

		/**
		public function toString() : String
		{
			return PXStringifier.process(this);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		protected function initColorMap() : void
		{
			mColorLevel = new PXHashMap();
			mColorLevel.put(PXLogLevel.ALL, 0x666666);
			mColorLevel.put(PXLogLevel.DEBUG, 0x0086B3);
			mColorLevel.put(PXLogLevel.INFO, 0x00B32D);
			mColorLevel.put(PXLogLevel.WARN, 0xB38600);
			mColorLevel.put(PXLogLevel.ERROR, 0xB32D00);
			mColorLevel.put(PXLogLevel.FATAL, 0xB3002D);
		}

		// --------------------------------------------------------------------
		// Private implementation
		// --------------------------------------------------------------------
		/**
		function PXDeMonsterDebuggerLayout()
		{
			new CLIENT(ROOT);
			initColorMap();
			if (AUTO_CLEAR) onClear();
		}
	}
}