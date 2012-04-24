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
	import net.pixlib.core.pixlib_internal;
	import net.pixlib.quick.document.license.type.PXFreeLicense;


	/**
	 * The LicenseManager class stores application license applied.
	 * 
	 * @see net.pixlib.quick.document.license.License
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXLicenseManager
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var _instance : PXLicenseManager;

		/**
		 * @private
		 */
		private var _license : PXLicense;


		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		
		/**
		 * Application license used in application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get license() : PXLicense
		{
			return _license;
		}
		
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Retuns LicenseManager unique instance.
		 * 
		 * @return LicenseManager unique instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function getInstance() : PXLicenseManager
		{
			if (!_instance) _instance = new PXLicenseManager();

			return _instance;
		}
		
		/**
		 * @private
		 */
		function PXLicenseManager()
		{
			_license = new PXFreeLicense();
		}
		
		/**
		 * @private
		 * 
		 * Registers application license. Registered by the DocumentClass 
		 * constructor.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 * @playerversion AIR 2.0
		 */
		pixlib_internal function register(license : PXLicense) : void
		{
			_license = license;
		}
	}
}
