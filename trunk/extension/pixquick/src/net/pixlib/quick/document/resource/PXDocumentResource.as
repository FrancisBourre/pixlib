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

	import net.pixlib.load.PXLoader;
	import net.pixlib.log.PXStringifier;
	
	/**
	 * The PXDocumentResource declares properties for PXDocument auto load 
	 * resources. 
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXDocumentResource
	{
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		
		/**
		 * Resource ID.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var id : String;
		
		/**
		 * Resource url.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var url : String;
		
		/**
		 * Pixlib Loader to use to load current resource.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var loader : PXLoader;
		
		/**
		 * Loader anticache value
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public var anticache : Boolean;
			
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		
		/**
		 * Creates instance.
		 *
		 * @param id		Resource identifier. If not null, Resource loaded 
		 * 					content will be registered into the PXResourceLocator.
		 * @param url		Resource content url
		 * @param loader 	Loader to use to load the resource
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXDocumentResource(id : String, url : String, loader : PXLoader = null)
		{
			this.id = id;
			this.url = url;
			this.loader = loader;
			this.anticache = anticache;
		}
		
		/**
		 * Returns string representation.
		 * 
		 * @return string representation.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function toString() : String
		{
			return PXStringifier.process(this) + "[" + url + "]";
		}
	}
}
