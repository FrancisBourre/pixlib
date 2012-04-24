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
package net.pixlib.quick.document.resource
{

	/**
	 * The PXDocumentResourceCollection declares default resources to be loaded 
	 * witinh the PXDocument engine.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXDocumentResourceCollection
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		
		/**
		 * @private
		 * 
		 * Stores additionnals resources.
		 */
		private var _more : Vector.<PXDocumentResource>;
		
		
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		
		/**
		 * Document resource for XML configuration file.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var configuration : PXDocumentResource;
		
		/**
		 * Document resource for CSS Stylesheet file.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var css : PXDocumentResource;

		/**
		 * Document resource for Shared Font Library file.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var font : PXDocumentResource;
		
		/**
		 * Document resource for UI assets library.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var assets : PXDocumentResource;

		/**
		 * Document resource for Background loop sound file.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var sound : PXDocumentResource;
		
		/**
		 * Returns addtionnals resources to load.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get additional() : Vector.<PXDocumentResource>
		{
			return _more;
		}
		
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates collection.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXDocumentResourceCollection()
		{
			_more = new Vector.<PXDocumentResource>();
			
			init();
		}
		
		/**
		 * Adds custom passed-in resource to PXDocument resources loading 
		 * process.
		 * 
		 * @param resource	The resource to add. PXDocumentResource#loader 
		 * 					property must be defined.
		 * 					
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function addResource(resource : PXDocumentResource) : void
		{
			if(resource.loader) _more.push(resource);
		}
		
		
		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		
		/**
		 * Inits collection.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function init() : void
		{
			configuration = new PXDocumentResource(null, "resources/config.xml");
			css = new PXDocumentResource(null, "resources/style.css");
			font = new PXDocumentResource(null, "resources/font.swf");
			assets = new PXDocumentResource(null, "resources/ui.swf");
			sound = new PXDocumentResource(null, "resources/loop.mp3");
		}
	}
}
