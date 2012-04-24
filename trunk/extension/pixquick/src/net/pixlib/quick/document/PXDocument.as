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
package net.pixlib.quick.document
{
	import net.pixlib.commands.PXSequencer;
	import net.pixlib.core.PXBaseDocument;
	import net.pixlib.core.pixlib_internal;
	import net.pixlib.log.PXLogManager;
	import net.pixlib.log.PXTraceLayout;
	import net.pixlib.plugin.PXBasePlugin;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.command.config.PXInitBackgroundSound;
	import net.pixlib.quick.command.config.PXLicenseChecker;
	import net.pixlib.quick.command.config.PXLoadAdditionalResource;
	import net.pixlib.quick.command.config.PXLoadCSS;
	import net.pixlib.quick.command.config.PXLoadConfig;
	import net.pixlib.quick.command.config.PXLoadFont;
	import net.pixlib.quick.command.config.PXLoadUI;
	import net.pixlib.quick.document.license.PXLicense;
	import net.pixlib.quick.document.license.PXLicenseManager;
	import net.pixlib.quick.document.license.type.PXFreeLicense;
	import net.pixlib.quick.document.resource.PXDocumentResource;
	import net.pixlib.quick.document.resource.PXDocumentResourceCollection;
	import net.pixlib.quick.document.resource.PXNullDocumentResourceCollection;
	import net.pixlib.quick.view.PXLockView;
	import net.pixlib.utils.PXFlashVars;

	import flash.events.Event;
	import flash.utils.getDefinitionByName;


	/**
	 * Main Document Class for no IoC Pixlib application.
	 * 
	 * <p>Extends it and uses it as FLA document class or directly in Flex Builder 
	 * or FDT as Main class in pure AS3 project.</p>
	 * 
	 * <p><ul>
	 * 	<li>Pixlib Application is initialized.</li>
	 * 	<li>Flashvars are automatically retreives from loaderInfo.</li> 
	 * 	<li>StageAlign is set to "TL".</li>
	 * 	<li>ScaleMode to "noScale".</li>
	 * 	<li>ContextMenu is hidden.</li>
	 * 	<li>MacWheel engine is started if host is MacOs.</li>
	 * 	<li>Basic configuration loading sequencer.</li>
	 * </ul></p>
	 * 
	 * @example Default document with no resources and no license
	 * <listing>
	 * 
	 * package 
	 * {
	 * 	import net.pixlib.document.PXDocument;
	 * 	
	 * 	public class MyMainDoc extends PXDocument
	 * 	{
	 * 		override public function onDocumentReady() : void
	 * 		{
	 * 			trace("Application loaded and ready");
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @example Default document with custom resources
	 * <listing>
	 * 
	 * package 
	 * {
	 * 	import net.pixlib.document.PXDocument;
	 * 	
	 * 	public class MyMainDoc extends PXDocument
	 * 	{
	 * 		override protected function get resources() : PXDocumentResourceCollection
	 * 		{
	 * 			return new MyResourcesCollection();
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @example Default document with Adobe InMarkket license
	 * <listing>
	 * 
	 * package 
	 * {
	 * 	import net.pixlib.document.PXDocument;
	 * 	
	 * 	public class MyMainDoc extends PXDocument
	 * 	{
	 * 		override protected function get license() : PXLicense
	 * 		{
	 * 			return new PXInMarketLicense("APP_UID");
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXDocument extends PXBaseDocument
	{
		// --------------------------------------------------------------------
		// Constants
		// --------------------------------------------------------------------

		/** 
		 * FlashVar name to change production mode state.
		 *
		 * @default "PRODUCTION_MODE"
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static const PRODUCTION_MODE_VAR : String = "PRODUCTION_MODE";


		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Full qualified classpath of SWFAddress class.
		 * 
		 * <p>Add SWFAddress library if you define this property.</p>
		 * 
		 * @default null
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var SWFADDRESS_CLASSPATH : String;

		/**
		 * Indicates if application is deployed for production mode.
		 * 
		 * @default false
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var PRODUCTION_MODE : Boolean = false;


		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		
		/**
		 * @private 
		 * 
		 * Checks passed-in Flashvars
		 */
		override protected function registerFlashVars() : void
		{
			super.registerFlashVars();
			
			if (PXFlashVars.getInstance().isRegistered(PRODUCTION_MODE_VAR))
			{
				PRODUCTION_MODE = PXFlashVars.getInstance().getBoolean(PRODUCTION_MODE_VAR, false);
			}
		}
		
		/**
		 * Initializes document properties.
		 * 
		 * <p>Set Stage default properties, hide context menu and 
		 * enable Mouse Wheel Helper on Mac OS Platform.</p>
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override protected function init() : void
		{
			alignStage();
			initContextMenu();
			registerFlashVars();
			initLogging();
			configure();
		}
		
		/**
		 * Initializes loggin API.
		 * 
		 * <p>Uses the #PRODUCTION_MODE value to add, default, the 
		 * PXTraceLayout loggin layout.</p>
		 *
		 * <p>Feel free to override this method to add custom logging 
		 * layout.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function initLogging() : void
		{
			if (!PRODUCTION_MODE)
			{
				PXLogManager.getInstance().addLogListener(PXTraceLayout.getInstance());
			}
		}

		/**
		 * Starts application configuration.
		 * 
		 * @see #configSequencer Configuration sequencer
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function configure() : void
		{
			var sequencer : PXSequencer = configSequencer;

			if (sequencer.length > 0)
			{
				sequencer.addEventListener(PXSequencer.onSequencerEndEVENT, onConfigCompleteHandler);
				sequencer.execute();
			}
			else onDocumentReady();
		}
		
		/**
		 * Returns PXDocumentResourceCollection instance to use for 
		 * pre laoding and pre configuration process.
		 * 
		 * @default PXNullDocumentResourceCollection instance
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function get resources() : PXDocumentResourceCollection
		{
			return new PXNullDocumentResourceCollection();
		}

		/**
		 * Returns PXLicense instance to use for this application.
		 * 
		 * @default PXFreeLicense instance
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function get license() : PXLicense
		{
			return new PXFreeLicense();
		}

		/**
		 * Creates and returns a configuration sequencer.
		 * 
		 * <p>Depending of the Document resources collection, the sequencer loads :
		 * <ul>
		 * 	<li>Config XML data</li>
		 * 	<li>Shared Font Library</li>
		 * 	<li>CSS styles</li>
		 * 	<li>UI Assets</li>
		 * 	<li>Background sound</li>
		 * </ul>
		 * </p>
		 * 
		 * <p>override to customize your process.</p>
		 * 
		 * @see net.pixlib.command.config.PXInitBackgroundSound		 * @see net.pixlib.command.config.PXInitMVC
		 * @see net.pixlib.command.config.PXLicenseChecker
		 * @see net.pixlib.command.config.PXLoadConfig
		 * @see net.pixlib.command.config.PXLoadCSS
		 * @see net.pixlib.command.config.PXLoadFont		 * @see net.pixlib.command.config.PXLoadUI
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function get configSequencer() : PXSequencer
		{
			var sequencer : PXSequencer = new PXSequencer();
			sequencer.owner = PXBasePlugin.getInstance();

			var resCollection : PXDocumentResourceCollection = resources;

			PXLicenseManager.getInstance().pixlib_internal::register(license);

			sequencer.addCommand(new PXLicenseChecker());

			if (resCollection.configuration)
			{
				PXQuick.pixlib_internal::CONFIGURATION_ID = resCollection.configuration.url;
				sequencer.addCommand(new PXLoadConfig(resCollection.configuration));
			}

			if (resCollection.font)
			{
				sequencer.addCommand(new PXLoadFont(resCollection.font));
			}

			if (resCollection.css)
			{
				PXQuick.pixlib_internal::CSS_ID = resCollection.css.url;
				sequencer.addCommand(new PXLoadCSS(resCollection.css));
			}

			if (resCollection.assets)
			{
				sequencer.addCommand(new PXLoadUI(resCollection.assets));
			}

			if (resCollection.sound)
			{
				sequencer.addCommand(new PXInitBackgroundSound(resCollection.sound));
			}

			var adds : Vector.<PXDocumentResource> = resCollection.additional;
			if (adds.length > 0)
			{
				for each (var res : PXDocumentResource in adds)
				{
					sequencer.addCommand(new PXLoadAdditionalResource(res));
				}
			}

			sequencer.addCommand(new PXStartDocument());

			new PXLockView();

			try
			{
				if (PXDocument.SWFADDRESS_CLASSPATH != null && getDefinitionByName(PXDocument.SWFADDRESS_CLASSPATH) is Class)
				{
					getDefinitionByName(PXDocument.SWFADDRESS_CLASSPATH).addEventListener("change", function(event : Event) : void {
					});
				}
			}
			catch(err : Error)
			{
			}

			return sequencer;
		}

		/**
		 * Triggered when configuration sequencer is complete.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function onConfigCompleteHandler(event : Event) : void
		{
			event.stopImmediatePropagation();
			event.target.removeEventListener(PXSequencer.onSequencerEndEVENT, onConfigCompleteHandler);
			event.target.clear();

			onDocumentReady();
		}


		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 * Document class constructor
		 */
		function PXDocument()
		{
			super();
		}
	}
}

import net.pixlib.commands.PXAbstractCommand;

import flash.events.Event;

internal class PXStartDocument extends PXAbstractCommand
{
	public function PXStartDocument()
	{
	}

	override protected function onExecute(event : Event = null) : void
	{
		fireCommandEndEvent();
	}
}