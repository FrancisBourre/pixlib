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
package net.pixlib.quick.load
{
	import net.pixlib.exceptions.PXIllegalArgumentException;
	import net.pixlib.load.PXCSSLoader;
	import net.pixlib.load.PXFileLoader;
	import net.pixlib.load.PXGraphicLoader;
	import net.pixlib.load.PXLoader;
	import net.pixlib.load.PXStreamLoader;
	import net.pixlib.load.PXXMLLoader;

	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;


	/**
	 * The PXLoaderFactory class allow automatic PXLoader creation 
	 * according the content which should be loaded.
	 * 
	 * @author Romain Ecarnot
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	public class PXLoaderFactory
	{
		private static var _instance : PXLoaderFactory;

		private static var _reg : RegExp = new RegExp("(.*?)(\.[^.]*$|$)", "");

		private var _dico : Dictionary;
		
		/**
		 * File extensions list for files which should be loaded by a PXFileLoader.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var TEXT_EXTENSION : Array = ["txt", "html", "htm", "po", "ini", "properties"];
		
		/**
		 * File extensions list for files which should be loaded by a PXGraphicLoader.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var DISPLAY_EXTENSION : Array = ["jpg", "jpeg", "png", "gif", "swf"];
		
		/**
		 * File extensions list for files which should be loaded by a PXCSSLoader.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var CSS_EXTENSION : Array = ["css"];
		
		/**
		 * File extensions list for files which should be loaded by a PXStreamLoader.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var BINARY_EXTENSION : Array = ["zip", "mp3"];
		
		/**
		 * File extensions list for files which should be loaded by a PXXMLLoader.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var XML_EXTENSION : Array = ["xml", "xlf"];
		
		/**
		 * Creates and returns PXLoader instance according passing arguments.
		 * 
		 * @param	id		Future loader identifier
		 * @param	type	PXLoader type to use (or "auto")
		 * @param	request	The URLRequest to use as loading process
		 * @param	nocache	Use cache system or not
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function create(id : String, type : String = "auto", request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			return getInstance().buildLoader(id, type, request, nocache);
		}

		/**
		 * Adds loading type to internal loading type dictionnary.
		 * 
		 * @example
		 * <listing>
		 * 
		 * PXLoaderFactory.addType("CUSTOM", buildCustomLoader);
		 * 
		 * public function buildCustomLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		 * {
		 *		
		 * }
		 * </listing>
		 * 
		 * @param	type			Loading type
		 * @param	parsingMethod	Method to call to build correct PXLoader
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function addType(type : String, parsingMethod : Function) : void
		{
			getInstance()._dico[type] = parsingMethod;
		}

		/**
		 * @private
		 */
		private static function getInstance() : PXLoaderFactory
		{
			if (!_instance) _instance = new PXLoaderFactory();
			return _instance;
		}

		/**
		 * @private
		 */
		protected function buildLoader(id : String, type : String = "auto", request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			if (_dico[type])
			{
				return _dico[type](id, request, nocache);
			}
			else
			{
				throw new PXIllegalArgumentException("Type '" + type + "' is not registered in factory", PXLoaderFactory);
			}
			return null;
		}
		
		/**
		 * @private
		 */
		function PXLoaderFactory()
		{
			_dico = new Dictionary();
			_dico[PXLoaderType.AUTO] = _buildAutomatic;
			_dico[PXLoaderType.TEXT] = _buildTextLoader;
			_dico[PXLoaderType.BINARY] = _buildBinayLoader;
			_dico[PXLoaderType.DISPLAY] = _buildDisplayLoader;
			_dico[PXLoaderType.XML] = _buildXMLLoader;
			_dico[PXLoaderType.CSS] = _buildCSSLoader;
		}
		
		/**
		 * @private
		 */
		private static function _checkExtension(name : String, list : Array) : Boolean
		{
			var ext : String = _reg.exec(name)[2];

			if ( ext != null && ext.length > 0 ) ext = ext.substring(1);

			return list.indexOf(ext) > -1;
		}
		
		/**
		 * @private
		 */
		private function _buildAutomatic(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader;
			
			switch(true)
			{
				case _checkExtension(request.url, BINARY_EXTENSION) :
					loader = _buildBinayLoader(id, request, nocache);
					break;
				case _checkExtension(request.url, CSS_EXTENSION) :
					loader = _buildCSSLoader(id, request, nocache);
					break;
				case _checkExtension(request.url, DISPLAY_EXTENSION) :
					loader = _buildDisplayLoader(id, request, nocache);
					break;
				case _checkExtension(request.url, TEXT_EXTENSION) :
					loader = _buildTextLoader(id, request, nocache);
					break;
				case _checkExtension(request.url, XML_EXTENSION) :
					loader = _buildXMLLoader(id, request, nocache);
					break;
				default : 
					loader = _buildBinayLoader(id, request, nocache);
			}
			
			return loader;
		}
		
		/**
		 * @private
		 */
		private function _buildTextLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader = new PXFileLoader(URLLoaderDataFormat.TEXT, id);
			loader.anticache = nocache;
			loader.request = request;
			return loader;
		}
		
		/**
		 * @private
		 */
		private function _buildBinayLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader = new PXStreamLoader(id);
			loader.anticache = nocache;
			loader.request = request;
			return loader;
		}
		
		/**
		 * @private
		 */
		private function _buildDisplayLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader = new PXGraphicLoader();
			loader.name = id;
			loader.anticache = nocache;
			loader.request = request;
			return loader;
		}
		
		/**
		 * @private
		 */
		private function _buildXMLLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader = new PXXMLLoader(id);
			loader.anticache = nocache;
			loader.request = request;
			return loader;
		}
		
		/**
		 * @private
		 */
		private function _buildCSSLoader(id : String, request : URLRequest = null, nocache : Boolean = false) : PXLoader
		{
			var loader : PXLoader = new PXCSSLoader(id);
			loader.anticache = nocache;
			loader.request = request;
			return loader;
		}
	}
}
