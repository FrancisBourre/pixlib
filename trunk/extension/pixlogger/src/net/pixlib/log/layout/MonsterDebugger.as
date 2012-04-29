package net.pixlib.log.layout 
{
	import net.pixlib.exceptions.PXException;
	
	/*
	 * Simple dummy MonsterDebugger class.
	 * see com.demonsters.debugger.MonsterDebugger for the right one to use.
	 */

	public class MonsterDebugger extends Object 
	{
		public static const VERSION : Number = Infinity;
		
		public static function initialize(base : Object, address : String = "127.0.0.1") : void 
		{
			throw new PXException( "You must use the com.demonsters.debugger.MonsterDebugger class. see http://demonsterdebugger.com" );
		}
	}
}
