/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */
package net.pixlib.quick.command.config{	import net.pixlib.load.PXLoader;	import net.pixlib.quick.document.resource.PXDocumentResource;	import net.pixlib.quick.util.PXRequestHelper;	/**	 * The PXLoadAdditionalResource command loads additional resource into 	 * application.	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 *	 * @author Romain Ecarnot	 	 */	final public class PXLoadAdditionalResource extends PXAbstractResourceLoader
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**		 * Creates instance.		 *		 * @langversion 3.0		 * @playerversion Flash 10		 */		public function PXLoadAdditionalResource(resource : PXDocumentResource)
		{
			super(resource);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------		
		/**		 * @inheritDoc		 */
		override protected function get loader() : PXLoader
		{
			return resource.loader;
		}

		/**		 * @inheritDoc		 */
		override protected function get request() : PXRequestHelper
		{
			return PXRequestHelper.create(resource.url);
		}
	}
}