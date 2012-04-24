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
package net.pixlib.quick.document.update
{
	import net.pixlib.log.PXStringifier;

	import flash.events.EventDispatcher;


	/**
	 * The NullUpdater class implements a null update mechanism.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXNullUpdater extends EventDispatcher implements PXUpdater
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		
		/**
		 * Creates instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXNullUpdater()
		{

		}
		
		/**
		 * @inheritDoc
		 */
		public function update() : void
		{
			dispatchEvent(new PXUpdaterEvent(PXUpdaterEvent.onUpdateEVENT, this));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString() : String
		{
			return PXStringifier.process(this); 
		}
	}
}
