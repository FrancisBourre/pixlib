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
package net.pixlib.quick.document.preloader
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;



	/**
	 * The DocumentPreloader class represents abstract implementation 
	 * for preloading feature.
	 * 
	 * @example DocumentPreloader default implementation
	 * <listing>
	 * 
	 * package main 
	 * {
	 * 	import net.pixlib.document.DocumentPreloader;
	 * 
	 * 	public class MyPreloader extends DocumentPreloader 
	 * 	{
	 * 		public function MyPreloader()
	 * 		{
	 * 			mainClassPath = "main.DocMain";
	 * 			
	 * 			super();
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @example Customize the PreloaderDisplay object
	 * <listing>
	 * 
	 * package main 
	 * {
	 * 	import net.pixlib.document.DocumentPreloader;
	 * 
	 * 	public class MyPreloader extends DocumentPreloader 
	 * 	{
	 * 		public function MyPreloader()
	 * 		{
	 * 			mainClassPath = "main.DocMain";
	 * 			super();
	 * 		}
	 * 		
	 * 		override protected function configureDisplay() : void
	 *		{
	 *			display = addChild(new MyPreloadingEffect()) as PreloaderDisplay;
	 *		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @example Metadata for your main class to allow preloading feature
	 * <listing>
	 * 
	 * package main 
	 * {
	 * 	[Frame(factoryClass="main.MyPreloader")]
	 * 	public class DocMain extends DocumentClass
	 * 	{
	 * 		override public function onDocumentReady() : void
	 * 		{
	 * 			// ...
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
	public class PXDocumentPreloader extends MovieClip
	{
		// --------------------------------------------------------------------
		// Protected properties
		// --------------------------------------------------------------------

		/**
		 * Stores the loading progression.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected var percent : Number;

		/**
		 * Stores the PreloaderDisplay object used to display loading 
		 * progression.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected var display : PXPreloaderDisplay;

		/**
		 * Indicates the full qualified class path of the main application 
		 * class.
		 * 
		 * @default null
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected var mainClassPath : String;


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXDocumentPreloader()
		{
			super();

			configureStage();
			configureDisplay();
			configureListeners();

			onUpdateHandler();
		}


		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------

		/**
		 * Configures stage properties
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function configureStage() : void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var menu : ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			contextMenu = menu;
		}

		/**
		 * Creates PreloaderDisplay instance to use to show loading progression. 
		 * 
		 * @default net.pixlib.document.preloader.RectBarPreloading
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function configureDisplay() : void
		{
			display = addChild(new PXRectBarPreloading()) as PXPreloaderDisplay;
		}

		/**
		 * Configures listeners.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function configureListeners() : void
		{
			addEventListener(Event.ENTER_FRAME, onUpdateHandler);
			stage.addEventListener(Event.RESIZE, onUpdateHandler);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onUpdateHandler);
			loaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
		}

		/**
		 * Triggered when loading progression has changed or when stage 
		 * was resized.
		 * 
		 * @param event	Event flow
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function onUpdateHandler(event : Event = null) : void
		{
			if (event) event.stopImmediatePropagation();

			percent = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;

			if (display) updateDisplay();
		}

		/**
		 * Updates PreloaderDisplay instance.
		 * 
		 * <p>Default implementation update PreloaderDisplay with loading 
		 * progression value and center the object on stage.</p>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function updateDisplay() : void
		{
			display.update(percent);
			display.x = (stage.stageWidth >> 1) - (display.width >> 1);
			display.y = (stage.stageHeight >> 1) - (display.height >> 1);
		}

		/**
		 * Triggered when all application is loaded.
		 * 
		 * @param event	Flow event
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function onCompleteHandler(event : Event) : void
		{
			event.stopImmediatePropagation();

			releaseListeners();
			releaseDisplay();

			startApplication();
		}

		/**
		 * Releases PreloaderDisplay object.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function releaseDisplay() : void
		{
			if (display)
			{
				display.clear();
				removeChild(display);
			}
		}

		/**
		 * Releases all listeners.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function releaseListeners() : void
		{
			removeEventListener(Event.ENTER_FRAME, onUpdateHandler);
			stage.removeEventListener(Event.RESIZE, onUpdateHandler);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onUpdateHandler);
			loaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
		}

		/**
		 * Starts main application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final protected function startApplication() : void
		{
			nextFrame();

			var main : Class = flash.utils.getDefinitionByName(mainClassPath) as Class;
			addChild(new main());
		}
	}
}