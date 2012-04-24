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
	import flash.events.IEventDispatcher;
	
	/**
	 * The License interface defines default behaviour for 
	 * Application license implementation.
	 * 
	 * @see net.pixlib.quick.document.license.type.FreeLicense
	 * @see net.pixlib.quick.document.license.type.InMarketLicense
	 * @see net.pixlib.quick.document.license.LicenseManager
	 * 
	 * @author Romain Ecarnot
	 */
	public interface PXLicense extends IEventDispatcher
	{
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		
		/**
		 * This property is used to inform the application that the customer 
		 * has a full license to the application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function get full() : Boolean;
		
		/**
		 * License time to live in units of milliseconds
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function get ttl() : Number;

		/**
		 * The URL to the license provider customer service website.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function get url() : String;
		
		/**
		 * Checks for license.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function authorize() : void;

		/**
		 * Returns string represenation of instance.
		 * 
		 * @return A String representation of instance
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function toString() : String;
	}
}
