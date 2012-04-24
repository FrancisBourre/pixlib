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
package net.pixlib.quick.document.license.type
{
	import net.pixlib.log.PXStringifier;
	import net.pixlib.quick.document.license.PXLicense;
	import net.pixlib.quick.document.license.PXLicenseEvent;

	import flash.events.EventDispatcher;


	/**
	 * Dispatched when license is checked (or canceled).
	 * 
	 * @eventType net.pixlib.quick.document.license.LicenseEvent.onLicenseCheckEVENT
	 */
	[Event(name="onLicenseCheck", type="net.pixlib.quick.document.license.PXLicenseEvent")]

	/**
	 * The FreeLicense class implements a free for all application license type.
	 * 
	 * <p>If no license is defined... this is the default behaviour.</p>
	 * 
	 * @example Using PixQuick engine
	 * <listing>
	 * 
	 * package
	 * {
	 * 	import net.pixlib.quick.document.DocumentClass;
	 * 	
	 * 	public class MainDocument extends DocumentClass
	 * 	{
	 * 		public function MainDocument()
	 * 		{
	 * 			super(null, new FreeLicense());
	 * 			//or super();
	 * 		}
	 * 	}
	 * </listing>
	 * 
	 * @see net.pixlib.quick.document.license.License
	 * @see net.pixlib.quick.document.license.LicenseManager
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXFreeLicense extends EventDispatcher implements PXLicense
	{
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get full() : Boolean
		{
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get ttl() : Number
		{
			return Number.POSITIVE_INFINITY;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get url() : String
		{
			return null;
		}
		
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		
		/**
		 * Creates new instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXFreeLicense()
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function authorize() : void
		{
			dispatchEvent(new PXLicenseEvent(PXLicenseEvent.onLicenseCheckEVENT, this));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString() : String
		{
			return PXStringifier.process(this) + "[" + full + "]";
		}
	}
}
