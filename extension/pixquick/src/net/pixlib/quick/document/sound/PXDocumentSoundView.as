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
package net.pixlib.quick.document.sound 
{
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.resource.PXDocumentResource;
	import net.pixlib.quick.media.PXSoundStateStrategy;
	import net.pixlib.quick.media.PXSoundTrait;
	import net.pixlib.quick.media.PXSoundTraitEvent;
	import net.pixlib.quick.view.PXQuickView;

	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	/**
	 * The PXDocumentSoundView class manages background sound loop.
	 * 
	 * <p>You can specify which stategy to use for background sound 
	 * management. uses <code>strategy</code> property for this.</p>
	 * 
	 * <p>Default uses <code>PXCutSoundStrategy</code> strategy to change sound 
	 * volume and pan.</p>
	 * 
	 * <p>You can change strategy at runtime, when you want.</p>
	 * 
	 * @example Use TweenSoundStrategy
	 * <listing>
	 * 
	 * PXBackgroundSoundView.strategy = new PXTweenSoundStrategy();
	 * </listing>
	 * 
	 * @see #strategy
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXDocumentSoundView extends PXQuickView
	{
		//--------------------------------------------------------------------
		// Constants
		//--------------------------------------------------------------------
		
		public static const ID : String = "PXDocumentSoundView";
		
		
		//--------------------------------------------------------------------
		// Private properties
		//--------------------------------------------------------------------
		
		/**
		 * @private
		 * Stores Sound effect stategy to change sound properties.
		 */
		private static var _EFFECT_STRATEGY : PXSoundStateStrategy = null;

		/**
		 * @private
		 */
		private var _url : String;
		
		/**
		 * @private
		 */
		private var _playing : Boolean;
		
		
		//--------------------------------------------------------------------
		// Protected properties
		//--------------------------------------------------------------------
		
		/**
		 * Sound instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected var sound : Sound;

		/**
		 * Sound channel instance when sound is played.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected var channel : SoundChannel;

		
		//--------------------------------------------------------------------
		// Public API
		//--------------------------------------------------------------------
		
		/**
		 * Sets the sound state strategy to use to change sound properties.
		 * 
		 * @default PXCutSoundStateStrategy
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static function get strategy() : PXSoundStateStrategy
		{
			return _EFFECT_STRATEGY;
		}
		/**
		 * @private
		 */
		public static function set strategy(value : PXSoundStateStrategy) : void
		{
			_EFFECT_STRATEGY = value;
		}
		
		/**
		 * Indicates if background sound is currently playing.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get playing() : Boolean
		{
			return _playing;
		}
		
		/**
		 * Creates instance.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXDocumentSoundView(resource : PXDocumentResource = null)
		{
			if (resource) _url = resource.url;
			_playing = false;
			
			super(ID);
		}
		
		/**
		 * Plays sound.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function play(url : String = null) : void
		{
			var request : URLRequest;
			
			if(!url)
			{
				if (_url) request = new URLRequest(_url);
			}
			else request = new URLRequest(url);
			
			if(request)
			{
				sound = new Sound();
				sound.load(request);
	            
	            _playing = true;
	            
				_onSoundCompleteHandler();
			}	
		}

		/**
		 * Stops sound.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function stop() : void
		{
			if(channel) 
			{
				channel.stop();
				channel.removeEventListener(Event.SOUND_COMPLETE, _onSoundCompleteHandler);
				channel = null;	
				
				sound = null;
				
				_playing = false;
			}
		}
		
		/**
		 * Triggered when PXDocumentSoundModel has changed.
		 * 
		 * <p>Uses PXSoundStateStrategy to change sound properties. Take a look 
		 * at <code>strategy</code> property to set your own stategy.</p>
		 * 
		 * @param event	PXSoundTraitEvent instance with new sound properties
		 * 
		 * @see #strategy
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function change(event : PXSoundTraitEvent) : void
		{
			event.stopImmediatePropagation();
			
			if(channel)
			{
				_EFFECT_STRATEGY.changeSound(channel, event.trait);	
			}
		}
		
		
		//--------------------------------------------------------------------
		// Private methods
		//--------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function _onSoundCompleteHandler(event : Event = null) : void 
		{
			if(event) event.stopImmediatePropagation();
			
			channel = sound.play();
			
			var trait : PXSoundTrait = PXQuick.soundTrait;
			
			channel.soundTransform = trait.soundTransform;
			channel.addEventListener(Event.SOUND_COMPLETE, _onSoundCompleteHandler);
		}
	}
}
