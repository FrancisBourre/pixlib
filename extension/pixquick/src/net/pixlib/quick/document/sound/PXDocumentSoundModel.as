/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */
package net.pixlib.quick.document.sound{	import net.pixlib.quick.media.PXSoundTrait;	import net.pixlib.quick.media.PXSoundTraitEvent;	import net.pixlib.quick.model.PXQuickModel;	import flash.events.Event;	/**	 * The PXDocumentSoundModel model manages global application sound properties.	 * 	 * @langversion 3.0	 * @playerversion Flash 10	 *	 * @author Romain Ecarnot	 */
	final public class PXDocumentSoundModel extends PXQuickModel
	{		// --------------------------------------------------------------------		// Constants		// --------------------------------------------------------------------				/**		 * Model's identifier		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */		public static const ID : String = "PXDocumentSoundModel";				
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------		
		/** 		 * @private		 * Stores event structure.		 */
		private var _event : PXSoundTraitEvent;
		
		/**		 * @private		 * Stores sound properties in SoundTrait object.		 */
		private var _trait : PXSoundTrait;		

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**		 * Indicates whether the sound is muted or sounding.		 * 		 * <p>Broadcasts <code>Event.CHANGE</code> event type if 		 * muted value is different than model property.</p>		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get muted() : Boolean
		{
			return _trait.muted;
		}

		/** @private */
		public function set muted(value : Boolean) : void
		{
			if (value != _trait.muted)
			{
				_trait.muted = value;
				fireChangeEvent();
			}
		}

		/**		 * The volume, ranging from 0 (silent) to 1 (full volume).		 * 		 * <p>Broadcasts <code>Event.CHANGE</code> event type if 		 * volume value is different than model property.</p>		 * 		 * @param value The volume, ranging from 0 (silent) to 1 (full volume).		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get volume() : Number
		{
			return _trait.volume;
		}

		/** @private */
		public function set volume(value : Number) : void
		{
			if (value != _trait.volume)
			{
				_trait.volume = value;
				fireChangeEvent();
			}
		}

		/**		 * The left-to-right panning of the sound. Ranges from -1		 * (full pan left) to 1 (full pan right).		 * 		 * <p>Broadcasts <code>Event.CHANGE</code> event type if 		 * panning value is different than model property.</p>		 * 		 * @param	value The left-to-right panning of the sound, ranging from 		 * 			-1 (full pan left) to 1 (full pan right).		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function get pan() : Number
		{
			return _trait.pan;
		}

		/** @private */
		public function set pan(value : Number) : void
		{
			if (value != _trait.pan)
			{
				_trait.pan = value;
				fireChangeEvent();
			}
		}

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**		 * Creates a SoundModel instance.		 *		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function PXDocumentSoundModel()
		{
			super(ID);			
			_trait = new PXSoundTrait();
			_event = new PXSoundTraitEvent(Event.CHANGE, null, _trait);
		}

		/**		 * Inits model properties.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function init() : void
		{
			onInitModel();
			fireChangeEvent();
		}

		/**		 * Sets the SoundTrait to manage in this model.		 * 		 * <p>Broadcasts <code>Event.CHANGE</code> event type.</p>		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function setTrait(trait : PXSoundTrait) : void
		{
			_trait = trait;
			fireChangeEvent();
		}

		/**		 * Returns SoundTrait managed by this model.		 * 		 * @return SoundTrait managed by this model.		 * 		 * @langversion 3.0		 * @playerversion Flash 10		 */
		public function getTrait() : PXSoundTrait
		{
			return _trait;
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**		 * Broadcasts Event.CHANGE event type.		 *		 * @langversion 3.0		 * @playerversion Flash 10		 */
		protected function fireChangeEvent() : void
		{
			_event.trait = _trait;
			notifyChanged(_event);
		}
	}
}	