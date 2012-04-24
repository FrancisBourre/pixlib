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
package net.pixlib.quick.display
{
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	use namespace flash_proxy;

	/**
	 * Proxy implementation for display object.
	 * 
	 * @example
	 * <listing>
	 * 
	 * var proxy : PXDisplayProxy = new PXDisplayProxy(new Sprite());
	 * proxy.time = getTime();
	 * proxy.id = "234";
	 * proxy.rotation = 45;
	 * proxy.addEventListener(MouseEvent.CLICK, onClickHandler);
	 * 
	 * addChild(proxy.diplayObject);
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	dynamic public class PXDisplayProxy extends Proxy
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 * DisplayProxy references
		 */
		private static var _repository : Dictionary = new Dictionary(true);

		/** 
		 * @private
		 * Proxy values identifier list.
		 */
		private var _item : Array;

		/** 
		 * @private
		 * Proxy DisplayObject storage.
		 */
		private var _dpo : DisplayObject;

		/** 
		 * @private
		 * Proxy data storage.
		 */
		private var _data : Object;


		// --------------------------------------------------------------------
		// Protected properties
		// --------------------------------------------------------------------

		/**
		 * DisplayObject instance controlled by proxy.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function get diplayObject() : DisplayObject
		{
			return _dpo;
		}


		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Returns DisplayProxy which control passed-in DisplayObject.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get(target : DisplayObject) : PXDisplayProxy
		{
			return _repository[target];
		}

		/**
		 * Creates proxy display object.
		 * 
		 * @param target	DisplayObject to control 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXDisplayProxy(target : DisplayObject)
		{
			_data = {};
			_dpo = target;
			_dpo.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStageHandler, false, int.MAX_VALUE);

			register(this);
		}

		/**
		 * Registers an event listener object with this EventDispatcher object 
		 * so that the listener receives notification of an event.
		 * 
		 * @param type				Type of event
		 * @param listener			The listener function that processes the 
		 * 							event.
		 * @param useCapture		Determines whether the listener works in the 
		 * 							capture phase or the target and bubbling 
		 * 							phases.
		 * 	@param priority			The priority level of the event listener.
		 * 	@param useWeakReference	Determines whether the reference 
		 * 							to the listener is strong or weak.
		 * 							
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dpo.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Dispatches an event into the event flow.
		 * 
		 * @param 	event	The Event object that is dispatched into the event 
		 * 					flow. 
		 * 
		 * @return	A value of true if the event was successfully 
		 * 			dispatched.<br/> 
		 * 			A value of false indicates failure or that preventDefault() 
		 * 			was called on the event.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function dispatchEvent(event : Event) : Boolean
		{
			return _dpo.dispatchEvent(event);
		}

		/**
		 * Checks whether the EventDispatcher object has any listeners 
		 * registered for a specific type of event.
		 * 
		 * @param	type	Type of event
		 * 
		 * @return	A value of true if a listener of the specified type is 
		 * 			registered; false otherwise.
		 * 			
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function hasEventListener(type : String) : Boolean
		{
			return _dpo.hasEventListener(type);
		}

		/**
		 * Removes a listener from the EventDispatcher object.<br />
		 * If there is no matching listener registered with the EventDispatcher 
		 * object, a call to this method has no effect.
		 * 
		 * @param type			Type of event
		 * @param listener		The listener object to remove
		 * @param useCapture	Specifies whether the listener was registered 
		 * 						for the capture phase or the target and bubbling 
		 * 						phases.
		 * 						
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dpo.removeEventListener(type, listener, useCapture);
		}

		/**
		 * Returns the string representation of the instance.
		 * 
		 * @return A string representation of instance
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function toString() : String
		{
			return "";
		}


		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------

		/**
		 * Registers PXDisplayProxy instance in repository for futur uses.
		 * 
		 * @param proxy	PXDisplayProxy object to register.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected static function register(proxy : PXDisplayProxy) : void
		{
			if (_repository[proxy._dpo] != null)
			{
				throw new IllegalOperationError("DisplayProxy for " + proxy._dpo + " is already registered");
			}
			else
			{
				_repository[proxy._dpo] = proxy;
			}
		}

		/**
		 * Unregisters PXDisplayProxy instance from repository.
		 *
		 * @param proxy	PXDisplayProxy object to unregister.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected static function unregister(proxy : PXDisplayProxy) : void
		{
			if (_repository[proxy._dpo] != null)
			{
				delete _repository[proxy._dpo];
			}
		}

		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/** @private */
		flash_proxy override function callProperty(name : *, ...args) : *
		{
			return _dpo[ name ].apply(_dpo, args);
		}

		/** @private */
		flash_proxy override function deleteProperty(name : *) : Boolean
		{
			if (_dpo.hasOwnProperty(name)) return false;

			return delete _data[name];
		}

		/** @private */
		flash_proxy override function getProperty(name : *) : *
		{
			if (_dpo.hasOwnProperty(name)) return _dpo[name];

			return _dpo[name];
		}

		/** @private */
		flash_proxy override function setProperty(name : *, value : *) : void
		{
			if (_dpo.hasOwnProperty(name)) _dpo[name] = value;
			else _dpo[name] = value;
		}

		/** @private */
		flash_proxy override function hasProperty(name : *) : Boolean
		{
			return _dpo.hasOwnProperty(name) || _dpo.hasOwnProperty(name);
		}

		/** @private */
		flash_proxy override function isAttribute(name : *) : Boolean
		{
			return !(_dpo[name] is Function) && !(_data[name] is Function);
		}

		/** @private */
		flash_proxy override function nextNameIndex(index : int) : int
		{
			if (index == 0)
			{
				_item = [];
				var name : *;
				for (name in _dpo) _item.push(name);
				for (name in _data) _item.push(name);
			}

			return index < _item.length ? index + 1 : 0;
		}

		/** @private */
		flash_proxy override function nextName(index : int) : String
		{
			return _item[index - 1];
		}

		/** @private */
		flash_proxy override function nextValue(index : int) : *
		{
			return getProperty(_item[index - 1]);
		}

		/** @private */
		private function _onRemoveFromStageHandler(event : Event) : void
		{
			_dpo.removeEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStageHandler);

			unregister(this);
		}
	}
}