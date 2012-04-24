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
package net.pixlib.quick.command.config
{
	import net.pixlib.commands.PXAbstractCommand;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.license.PXLicense;
	import net.pixlib.quick.document.license.PXLicenseEvent;
	import net.pixlib.quick.document.license.PXLicenseManager;

	import flash.events.Event;

	/**
	 * If enabled, check application license.
	 * 
	 * @see net.pixlib.quick.document.license.PXLicense	 * @see net.pixlib.quick.document.license.PXLicenseManager
	 * 
	 * @example Disable Logging Features for production release
	 * <listing>
	 * 
	 * package 
	 * {
	 * 	import net.pixlib.document.PXDocument;
	 * 	
	 * 	public class MyMainDoc extends PXDocument
	 * 	{
	 * 		public function MyMainDoc()
	 * 		{
	 * 			
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXLicenseChecker extends PXAbstractCommand
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _license : PXLicense;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXLicenseChecker()
		{

		}


		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------

		/**
		 * Executes command.
		 * 
		 * @param event	Event flow not used in abstract implementation
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override protected function onExecute(event : Event = null) : void
		{
			_license = PXLicenseManager.getInstance().license;
			_license.addEventListener(PXLicenseEvent.onLicenseCheckEVENT, _onLicense);
			_license.authorize();
		}
		

		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		private function _onLicense(event : PXLicenseEvent) : void
		{
			PXQuick.debug("License type " + PXLicenseManager.getInstance().license, this);
			
			_license.removeEventListener(PXLicenseEvent.onLicenseCheckEVENT, _onLicense);

			fireCommandEndEvent();
		}
	}
}
