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
	import flash.external.ExternalInterface;

	/**
	 * The PXWebUtils class offer useful utilities method to retreive or play 
	 * with some Web dedicated features.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXWebUtils
	{
		/**
		 * Some utilities methods for Web context.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * 
		 * @author Romain Ecarnot
		 */
		public static function get hostname() : String
		{
			if (ExternalInterface.available)
				return ExternalInterface.call("window.location.hostname.toString");

			return null;
		}
		
		/**
		 * Returns the full qualified URL of current application.
		 * 
		 * @return the full qualified URL of current application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get url() : String
		{
			if (ExternalInterface.available)
				return ExternalInterface.call("window.location.href.toString");

			return null;
		}
		
		/**
		 * Returns the protocol used for current application.
		 * 
		 * @return the protocol used for current application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get protocol() : String
		{
			if (ExternalInterface.available)
				return ExternalInterface.call("window.location.protocol.toString");

			return null;
		}
		
		/**
		 * Returns the path used for current application.(after the protocol and 
		 * hostname value).
		 * 
		 * @return the path used for current application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get path() : String
		{
			if (ExternalInterface.available)
				return ExternalInterface.call("window.location.pathname.toString");

			return null;
		}
		
		/**
		 * Opens a browser popup window using external javascript call.
		 * 
		 * @param url		URL to open
		 * @param window	(optional) Window's name
		 * @param features	(optional) Opening options
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function openWindow(url : String, window : String = "_blank", features : String = "") : void
		{
			if (ExternalInterface.available)
				ExternalInterface.call("window.open", url, window, features);
		}
		
		/**
		 * @private
		 */
		function PXWebUtils() {
			
		}
	}
}
