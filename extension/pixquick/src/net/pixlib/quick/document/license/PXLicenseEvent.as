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
package net.pixlib.quick.document.license 
{
	import net.pixlib.events.PXBasicEvent;

	import flash.events.Event;
	
	/**
	 * ApplicationLicenseEvent class is an event object which carry 
	 * ApplicationLicense property.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @see net.pixlib.quick.document.license.License
	 * @see net.pixlib.quick.document.license.LicenseManager
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXLicenseEvent extends PXBasicEvent 
	{
		//--------------------------------------------------------------------
		// Events
		//--------------------------------------------------------------------
		
		/**
		 * Defines the value of the <code>type</code> property of the event 
		 * object for a <code>onLicenseCheck</code> event.
		 * 
		 * <p>The properties of the event object have the following values:</p>
		 * <table class="innertable">
		 *     <tr><th>Property</th><th>Value</th></tr>
		 *     <tr>
		 *     	<td><code>type</code></td>
		 *     	<td>Dispatched event type</td>
		 *     </tr>
		 *     <tr>
		 *     	<td><code>license</code></td>
		 *     	<td>The License instance carried by this event</td>
		 *     </tr>
		 *     
		 *     <tr><th>Method</th><th>Value</th></tr>
		 *     <tr>
		 *     	<td><code>clone()</code>
		 *     	</td><td>Clone the current event object</td>
		 *     </tr>
		 * </table>
		 * 
		 * @eventType onLicenseCheck
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */		
		public static const onLicenseCheckEVENT : String = "onLicenseCheckEVENT";
		
		
		//--------------------------------------------------------------------
		// Public properties
		//--------------------------------------------------------------------
		
		/**
		 * License instance carried by thie event.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get license() : PXLicense
		{
			return target as PXLicense;
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
		public function PXLicenseEvent(eventType : String, target : PXLicense)
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
			return new PXLicenseEvent(type, license);
		}
	}
}
