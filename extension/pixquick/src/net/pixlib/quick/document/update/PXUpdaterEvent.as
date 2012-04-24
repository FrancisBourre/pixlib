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
package net.pixlib.quick.document.update 
{
	import net.pixlib.events.PXBasicEvent;

	import flash.events.Event;
	
	/**
	 * UpdaterEvent class is an event object which carry 
	 * Updater property.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @see net.pixlib.quick.document.update.Updater
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXUpdaterEvent extends PXBasicEvent 
	{
		//--------------------------------------------------------------------
		// Events
		//--------------------------------------------------------------------
		
		/**
		 * Defines the value of the <code>type</code> property of the event 
		 * object for a <code>onUpdate</code> event.
		 * 
		 * <p>The properties of the event object have the following values:</p>
		 * <table class="innertable">
		 *     <tr><th>Property</th><th>Value</th></tr>
		 *     <tr>
		 *     	<td><code>type</code></td>
		 *     	<td>Dispatched event type</td>
		 *     </tr>
		 *     <tr>
		 *     	<td><code>updater</code></td>
		 *     	<td>The Upadter instance carried by this event</td>
		 *     </tr>
		 *     
		 *     <tr><th>Method</th><th>Value</th></tr>
		 *     <tr>
		 *     	<td><code>clone()</code>
		 *     	</td><td>Clone the current event object</td>
		 *     </tr>
		 * </table>
		 * 
		 * @eventType onUpdate
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */		
		public static const onUpdateEVENT : String = "onUpdate";
		
		
		//--------------------------------------------------------------------
		// Public properties
		//--------------------------------------------------------------------
		
		/**
		 * Updater instance carried by thie event.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get updater() : PXUpdater
		{
			return target as PXUpdater;
		}
		
		
		//--------------------------------------------------------------------
		// Public API
		//--------------------------------------------------------------------
		
		/**
		 * Creates instance
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXUpdaterEvent(eventType : String, target : PXUpdater)
		{
			super(eventType, target);
		}
		
		/**
		 * Returns a clone of this event.
		 * 
		 * @return a clone og this event.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override public function clone() : Event
		{
			return new PXUpdaterEvent(type, updater);
		}
	}
}
