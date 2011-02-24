/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */package net.pixlib.load {	import net.pixlib.display.css.PXCSS;	import net.pixlib.encoding.PXCSSDeserializer;			/**
	 * Dedicated Loader implementation for CSS files.	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 * 	 * @author Romain Ecarnot
	 */
	final public class PXCSSLoader extends PXFileLoader	{		//--------------------------------------------------------------------		// Public API		//--------------------------------------------------------------------				/**		 * Creates new <code>PXCSSLoader</code> instance.		 * 		 * <p>If <code>key</code> is not <code>null</code>, created CSS is 		 * registered into <code>LoaderLocator</code> repository.</p>		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function PXCSSLoader(key : String = null)		{			super(PXFileLoader.TEXT);						name = key;		}			/**		 * Returns loaded CSS instance.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function getCSS(  ) : PXCSS		{			return content as PXCSS;		}				/**		 * @inheritDoc		 */		override public function set content(value : Object) : void		{				if( value != null )			{				var deserializer : PXCSSDeserializer = new PXCSSDeserializer();												super.content = deserializer.deserialize(value);			}		}	}
}
