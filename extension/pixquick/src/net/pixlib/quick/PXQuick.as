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
package net.pixlib.quick
{
	import net.pixlib.commands.PXFrontController;
	import net.pixlib.core.PXApplication;
	import net.pixlib.core.pixlib_internal;
	import net.pixlib.display.css.PXCSS;
	import net.pixlib.events.PXEventChannel;
	import net.pixlib.load.PXLoaderLocator;
	import net.pixlib.load.pixlib_FileLoader;
	import net.pixlib.load.pixlib_XMLLoader;
	import net.pixlib.log.PXLog;
	import net.pixlib.model.PXModel;
	import net.pixlib.plugin.PXAbstractPlugin;
	import net.pixlib.plugin.PXBasePlugin;
	import net.pixlib.plugin.PXPlugin;
	import net.pixlib.quick.document.PXDocument;
	import net.pixlib.quick.document.license.PXLicense;
	import net.pixlib.quick.document.license.PXLicenseManager;
	import net.pixlib.quick.document.sound.PXDocumentSoundModel;
	import net.pixlib.quick.document.sound.PXDocumentSoundView;
	import net.pixlib.quick.media.PXSoundTrait;
	import net.pixlib.quick.view.PXLockView;
	import net.pixlib.structures.PXDimension;
	import net.pixlib.view.PXView;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;


	/**
	 * The PXQuick class give access to main frontal Plugin instance 
	 * and MV/FC design.
	 * 
	 * @example
	 * <listing>
	 * 
	 * package
	 * {
	 * 	public class MyApp extends PXDocument
	 * 	{
	 * 		override protected function onDocumentReady() : void
	 * 		{
	 * 			PXQuick.debug("Application is ready");
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
	final public class PXQuick
	{
		/**
		 *@private
		 */
		pixlib_internal static var CONFIGURATION_ID : String;

		/**
		 *@private
		 */
		pixlib_internal static var CSS_ID : String;

		/**
		 * Returns singleton Plugin instance.
		 * 
		 * @return singleton Plugin instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get plugin() : PXPlugin
		{
			return PXBasePlugin.getInstance();
		}

		/**
		 * Returns the FrontController used by the BasePlugin instance.
		 * 
		 * @return The FrontController used by the BasePlugin instance.
		 * 
		 * @see PIXLIB_DOC/net/pixlib/commands/PXFrontController net.pixlib.commands.PXFrontController
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get controller() : PXFrontController
		{
			return PXAbstractPlugin(PXBasePlugin.getInstance()).controller;
		}

		/**
		 * Returns the Log object used by the BasePlugin singleton.
		 * 
		 * @return The Log used by the BasePlugin singleton.
		 * 
		 * @see PIXLIB_DOC/net/pixlib/log/PXLog net.pixlib.log.PXLog
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get logger() : PXLog
		{
			return PXBasePlugin.getInstance().logger;
		}

		/**
		 * Logs passed-in message with a log level defined  
		 * at 'debug' mode.
		 * 
		 * @param	o		Message to log
		 * @param	target	(optional) The target from where the log 
		 * 					is called
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function debug(o : *, target : Object = null) : void
		{
			logger.debug(o, target);
		}

		/**
		 * Logs passed-in message with a log level defined  
		 * at 'info' mode.
		 * 
		 * @param	o		Message to log
		 * @param	target	(optional) The target from where the log 
		 * 					is called
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function info(o : *, target : Object = null) : void
		{
			logger.info(o, target);
		}

		/**
		 * Logs passed-in message with a log level defined  
		 * at 'warn' mode.
		 * 
		 * @param	o		Message to log
		 * @param	target	(optional) The target from where the log 
		 * 					is called
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function warn(o : *, target : Object = null) : void
		{
			logger.warn(o, target);
		}

		/**
		 * Logs passed-in message with a log level defined  
		 * at 'error' mode.
		 * 
		 * @param	o		Message to log
		 * @param	target	(optional) The target from where the log 
		 * 					is called
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function error(o : *, target : Object = null) : void
		{
			logger.error(o, target);
		}

		/**
		 * Logs passed-in message with a log level defined  
		 * at 'fatal' mode.
		 * 
		 * @param	o		Message to log
		 * @param	target	(optional) The target from where the log 
		 * 					is called
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function fatal(o : *, target : Object = null) : void
		{
			logger.fatal(o, target);
		}

		/**
		 * Returns <code>PXModel</code> registered with passed-in <code>key</code> 
		 * identifier in BasePlugin instance.
		 * 
		 * @param key	Model's identifier
		 * 
		 * @return <code>PXModel</code> registered with passed-in <code>key</code> 
		 * identifier in BasePlugin instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function getModel(key : String) : PXModel
		{
			return PXBasePlugin.getInstance().getModel(key);
		}

		/**
		 * Returns <code>true</code> if passed-in Model identifier is 
		 * registered in BasePlugin plugin.
		 * 
		 * @param key	Model's identifier
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function isModelRegistered(key : String) : Boolean
		{
			return PXBasePlugin.getInstance().isModelRegistered(key);
		}

		/**
		 * Returns <code>PXView</code> registered with passed-in <code>key</code> 
		 * identifier in BasePlugin instance.
		 * 
		 * @param key	View's identifier
		 * 
		 * @return <code>PXView</code> registered with passed-in <code>key</code> 
		 * identifier in BasePlugin instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function getView(key : String) : PXView
		{
			return PXBasePlugin.getInstance().getView(key);
		}

		/**
		 * Returns <code>true</code> if passed-in View identifier is 
		 * registered in BasePlugin plugin.
		 * 
		 * @param key	View's identifier
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function isViewRegistered(key : String) : Boolean
		{
			return PXBasePlugin.getInstance().isViewRegistered(key);
		}

		/**
		 * Fires passed-in event in private event communication channel.
		 * 
		 * <p>Passed-in event type must be registered into BasePlugin 
		 * FrontController to be dispatched.<br>
		 * Used to build an Event type/Command association.</p>
		 * 
		 * @param event	Event to dispatch in private communication channel
		 * 
		 * @example
		 * <listing>
		 * 
		 * public function registerCommand() : void
		 * {
		 * 	PXQuick.controller.pushCommandClass("onTest", TestCommand);
		 * }
		 * 
		 * public function test() : void
		 * {
		 * 	PXQuick.firePrivateEvent(new Event("onTest"));
		 * }
		 * </listing>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function firePrivateEvent(event : Event) : void
		{
			PXBasePlugin.getInstance().firePrivateEvent(event);
		}

		/**
		 * Fires basic event instance using passed-in event type in private 
		 * event communication channel.
		 * 
		 * <p>Passed-in event type must be registered into BasePlugin 
		 * FrontController to be dispatched.<br>
		 * Used to build an Event type/Command association.</p>
		 * 
		 * @param event	Event to dispatch in private communication channel
		 * 
		 * @example
		 * public function registerCommand() : void
		 * {
		 * 	PXQuick.controller.pushCommandClass("onTest", TestCommand);
		 * }
		 * 
		 * public function test() : void
		 * {
		 * 	PXQuick.firePrivateEventType("onTest");
		 * }
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function firePrivateEventType(eventType : String) : void
		{
			PXBasePlugin.getInstance().firePrivateEvent(new Event(eventType));
		}

		/**
		 * Fires passed-in event in public event communication channel.
		 * 
		 * <p>Passed-in event type must be listened by another Plugin instance.</p>
		 * 
		 * @param event	Event to dispatch in public communication channel
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function firePublicEvent(event : Event) : void
		{
			PXBasePlugin.getInstance().firePublicEvent(event);
		}

		/**
		 * Fires passed-in event in external event communication channel.
		 * 
		 * <p>Passed-in event type must be listened by another Plugin instance.</p>
		 * 
		 * @param event	Event to dispatch in public communication channel		 * @param channel Plugin channel to target
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function fireExternalEvent(event : Event, channel : PXEventChannel) : void
		{
			PXBasePlugin.getInstance().fireExternalEvent(event, channel);
		}

		/**
		 * Returns current application's size.
		 * 
		 * @return current application's size.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get size() : PXDimension
		{
			return PXApplication.getInstance().size;
		}

		/**
		 * Returns current application's root display object container.
		 * 
		 * @return current application's root display object container.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get root() : DisplayObjectContainer
		{
			return PXApplication.getInstance().root;
		}

		/**
		 * Returns XML's application configuration.(if exist).
		 * 
		 * <p>When PXDocumentResourceCollection used in PXDocument constuctor 
		 * define an <code>configuration</code> property, the XML content is 
		 * availabe using this method for global retreiving.</p> 
		 * 
		 * @return XML's application configuration.(if exist).
		 * 
		 * @see net.pixlib.quick.document.resource.PXDocumentResourceCollection
		 * @see net.pixlib.quick.document.PXDocument
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get configuration() : XML
		{
			return PXLoaderLocator.getInstance().pixlib_XMLLoader::getLoader(pixlib_internal::CONFIGURATION_ID).xml;
		}

		/**
		 * Returns global CSS used in application.(if exist).
		 * 
		 * <p>When PXDocumentResourceCollection used in DocumentClass constuctor 
		 * define an <code>css</code> property, the PXCss content is 
		 * availabe using this method for global retreiving.</p> 
		 * 
		 * @return global PXCss used in application.(if exist).
		 * 
		 * @see net.pixlib.quick.document.resource.DocumentResourceCollection
		 * @see net.pixlib.quick.document.DocumentClass
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get css() : PXCSS
		{
			return PXLoaderLocator.getInstance().pixlib_FileLoader::getLoader(pixlib_internal::CSS_ID).content as PXCSS;
		}

		/**
		 * If enabled, returns the current deep link value.
		 * 
		 * @return The current deep link
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get deeplink() : String
		{
			try
			{
				if (getDefinitionByName(PXDocument.SWFADDRESS_CLASSPATH) is Class)
				{
					var link : String = getDefinitionByName(PXDocument.SWFADDRESS_CLASSPATH).getValue();

					if (link.length > 1)
					{
						link = link.substr(1);
						if (link.indexOf("/") > -1)
						{
							link = link.substring(0, link.indexOf("/"));
						}
						return link;
					}
				}
			}
			catch(err : Error)
			{
			}

			return null;
		}

		/**
		 * Returns PXLicense used in application.
		 * 
		 * @return PXLicense used in application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get license() : PXLicense
		{
			return PXLicenseManager.getInstance().license;
		}

		/**
		 * Locks user to interact with application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function lockInteractions() : void
		{
			if(isViewRegistered(PXLockView.ID))
				PXQuick.getView(PXLockView.ID).show();
		}

		/**
		 * Allows user to interact with application.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function unlockInteractions() : void
		{
			if(isViewRegistered(PXLockView.ID) && getView(PXLockView.ID).visible)
				PXQuick.getView(PXLockView.ID).hide();	
		}
		
		/**
		 * Returns the SoundTrait used for background sound strategy.
		 * 
		 * @return the SoundTrait used for background sound strategy.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get soundTrait() : PXSoundTrait
		{
			if (!isModelRegistered(PXDocumentSoundModel.ID))
			{
				return new PXSoundTrait();
			}
			else
			{
				var model : PXDocumentSoundModel = getModel(PXDocumentSoundModel.ID) as PXDocumentSoundModel;
				return model.getTrait();
			}

			return null;
		}

		/**
		 * Changes background sound volume.
		 * 
		 * @param value	New sound volume
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function set volume(value : Number) : void
		{
			if (isModelRegistered(PXDocumentSoundModel.ID))
			{
				var model : PXDocumentSoundModel = getModel(PXDocumentSoundModel.ID) as PXDocumentSoundModel;
				model.volume = value;
			}
		}

		/**
		 * Changes mute state of background sound.
		 * 
		 * @param value	New sound muted state
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function set muted(value : Boolean) : void
		{
			if (isModelRegistered(PXDocumentSoundModel.ID))
			{
				var model : PXDocumentSoundModel = getModel(PXDocumentSoundModel.ID) as PXDocumentSoundModel;
				model.muted = value;
			}
		}

		/**
		 * Plays background sound.
		 * 
		 * @param url	(optional) URL String for the file to play. If not defined 
		 * 				use the default PXDocumentResource for sound property.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function play(url : String = null) : void
		{
			if (isViewRegistered(PXDocumentSoundView.ID))
			{
				var view : PXDocumentSoundView = getView(PXDocumentSoundView.ID) as PXDocumentSoundView;

				if (url) view.play(url);
				else view.play();
			}
		}

		/**
		 * Stops background sound.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function stop() : void
		{
			if (isViewRegistered(PXDocumentSoundView.ID))
			{
				var view : PXDocumentSoundView = getView(PXDocumentSoundView.ID) as PXDocumentSoundView;
				view.stop();
			}
		}

		/**
		 * Toggles background playing state.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function toggle() : void
		{
			if (isViewRegistered(PXDocumentSoundView.ID))
			{
				var view : PXDocumentSoundView = getView(PXDocumentSoundView.ID) as PXDocumentSoundView;
				if (view.playing) view.stop();
				else view.playing;
			}
		}
	}
}
