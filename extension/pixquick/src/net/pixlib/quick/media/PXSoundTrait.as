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
package net.pixlib.quick.media
{
	import net.pixlib.log.PXStringifier;

	import flash.media.SoundTransform;

	/**
	 * SoundTrait class stores sound properties for volume, panning value and 
	 * muted state.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXSoundTrait
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------

		/**
		 * @private
		 * Stores muted state.
		 */
		private var _muted : Boolean = false;

		/**
		 * @private
		 * Stores volume value.
		 */
		private var _volume : Number = 1;

		/**
		 * @private
		 * Stores panning value.
		 */
		private var _pan : Number = 0;


		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------

		/**
		 * Indicates whether the sound is muted or sounding. 
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get muted() : Boolean
		{
			return _muted;
		}

		/** @private */
		public function set muted(value : Boolean) : void
		{
			_muted = value;
		}

		/**
		 * The volume, ranging from 0 (silent) to 1 (full volume).
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get volume() : Number
		{
			return _volume;
		}

		/** @private */
		public function set volume(value : Number) : void
		{
			_volume = value;
		}

		/**
		 * The left-to-right panning of the sound. Ranges from -1
		 * (full pan left) to 1 (full pan right).
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get pan() : Number
		{
			return _pan;
		}

		/** @private */
		public function set pan(value : Number) : void
		{
			_pan = value;
		}

		/**
		 * Returns a SoundTransform instance using SoundTrait properties.
		 * 
		 * <p>If sound is muted, SoundTransform.volume is set to <code>0</code>.</p>
		 * 
		 * @return SoundTransform instance using SoundTrait properties.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final public function get soundTransform() : SoundTransform
		{
			return new SoundTransform(muted ? 0 : volume, pan);
		}
		
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------

		/**
		 * Creates instance.
		 * 
		 * @param volume	The volume, ranging from 0 (silent) to 1 (full volume).
		 * @param panning	The left-to-right panning of the sound. Ranges from -1
		 * 					(full pan left) to 1 (full pan right).
		 * @param isMuted	Indicates whether the sound is muted or sounding.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXSoundTrait(vol : Number = 1, panning : Number = 0, isMuted : Boolean = false)
		{
			volume = vol;
			pan = panning;
			muted = isMuted;
		}

		/**
		 * Returns string representation.
		 * 
		 * @return string representation.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		final public function toString() : String
		{
			return PXStringifier.process(this) + "[" + volume + "|" + pan + "|" + muted + "]";
		}
	}
}
