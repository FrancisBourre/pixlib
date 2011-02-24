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
package net.pixlib.plugin
{
	import net.pixlib.events.PXBasicEvent;


	/**
	 * @author Francis Bourre
	 */
	final public class PXPluginEvent extends PXBasicEvent
	{
		static public const onInitPluginEVENT : String = "onInitPlugin";

		static public const onReleasePluginEVENT : String = "onReleasePlugin";

		protected var oPlugin : PXPlugin;

		public function get value() : PXPlugin
		{
			return ( oPlugin != null ) ? oPlugin : target as PXPlugin;
		}

		/**
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXPluginEvent(eventType : String, target : Object = null, plugin : PXPlugin = null)
		{
			super(eventType, target);
			oPlugin = plugin;
		}
	}
}