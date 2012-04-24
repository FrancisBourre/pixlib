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
	import net.pixlib.quick.document.update.PXNullUpdater;
	import net.pixlib.quick.document.update.PXUpdater;
	import net.pixlib.quick.document.update.PXUpdaterEvent;

	import flash.events.Event;
	import flash.system.Capabilities;

	/**
	 * If enabled, check application update.
	 * 
	 * @author Romain Ecarnot
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	final public class PXUpdateChecker extends PXAbstractCommand
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _updater : PXUpdater;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXUpdateChecker(updater : PXUpdater)
		{
			_updater = updater != null ? updater : new PXNullUpdater();
		}


		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------

		/**
		 * Executes command.
		 * 
		 * @param event	Event flow not used here
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override protected function onExecute(event : Event = null) : void
		{
			if (Capabilities.playerType.toLowerCase() != "desktop")
			{
				_updater = new PXNullUpdater();
			}

			_updater.addEventListener(PXUpdaterEvent.onUpdateEVENT, _onUpdate);
			_updater.update();
		}


		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		private function _onUpdate(event : PXUpdaterEvent) : void
		{
			_updater.removeEventListener(PXUpdaterEvent.onUpdateEVENT, _onUpdate);

			fireCommandEndEvent();
		}
	}
}
