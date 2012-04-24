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
	import net.pixlib.quick.document.resource.PXDocumentResource;
	import net.pixlib.quick.document.sound.PXDocumentSoundModel;
	import net.pixlib.quick.document.sound.PXDocumentSoundView;

	import flash.events.Event;


	/**
	 * The PXLoadBackgroundSound command loads background MP3 sound file 
	 * if defined in document resources collection pass to DocumentClass 
	 * constructor.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXInitBackgroundSound extends PXAbstractCommand
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _resource : PXDocumentResource;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXInitBackgroundSound(resource : PXDocumentResource)
		{
			_resource = resource;
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
			var bgSound : PXDocumentSoundView = new PXDocumentSoundView();
			
			var soundModel : PXDocumentSoundModel = new PXDocumentSoundModel();
			soundModel.addListener(bgSound);
			soundModel.init();

			fireCommandEndEvent();
		}

	}
}
