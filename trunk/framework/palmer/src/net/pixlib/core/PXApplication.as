/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */package net.pixlib.core {	import net.pixlib.log.PXStringifier;	import net.pixlib.structures.PXDimension;	import flash.display.DisplayObjectContainer;	import flash.display.LoaderInfo;	/**	 * The PXApplication class stores main application properties.	 * 	 * <p>If you extend PXBaseDocument class for your main class, initialization 	 * is automatically done for you.</p>	 *  	 * <p>If you use IoC architecture, PXApplication is automatically 	 * invoked and used. If not, you must call PXApplication.getInstance().pixlib_internal::init() 	 * to init application core properties.</p>	 * 	 * @example In your main class (Sprite or MovieClip type)	 * <listing>	 * 	 * PXApplication.getInstance().pixlib_internal::init(this, loaderInfo);	 * </listing>	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 * 	 * @author Romain Ecarnot	 */	final public class PXApplication	{		//--------------------------------------------------------------------		// Private properties		//--------------------------------------------------------------------				/**		 * @private		 */		private static  var _instance : PXApplication;				/**		 * @private		 */		private var _root : DisplayObjectContainer;				/**		 * @private		 */		private var _infos : LoaderInfo;				//--------------------------------------------------------------------		// Public properties		//--------------------------------------------------------------------				/**		 * The application main container.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function get root() : DisplayObjectContainer		{			return _root;				}		/**		 * The application loading informations.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function get loaderInfo() : LoaderInfo		{			return _infos;		}		/**		 * The application's size.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function get size( ) : PXDimension		{			return new PXDimension(root.stage.stageWidth, root.stage.stageHeight);		}				//--------------------------------------------------------------------		// Public API		//--------------------------------------------------------------------				/**		 * Returns singleton instance.		 * 		 * @return The singleton instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */			public static function getInstance() : PXApplication		{			if(!_instance) _instance = new PXApplication(); 			return _instance;		}				/**		 * Releases singleton instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public static function release() : void		{			if(_instance) _instance = null; 		}		/**		 * Returns string representation of instance.		 * 		 * @return The string representation of instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function toString() : String		{			return PXStringifier.process(this);		}						//--------------------------------------------------------------------		// Private implementation		//--------------------------------------------------------------------				/**		 * Inits application properties		 * 		 * @param rootTarget	PXApplication root		 * @param loaderInfo	PXApplication loader information		 */		pixlib_internal function init(rootTarget : DisplayObjectContainer, loaderInfo : LoaderInfo = null) : void		{			_root = rootTarget;			_infos = loaderInfo;		}		/**		 * @private		 */		function PXApplication()		{					}	}}