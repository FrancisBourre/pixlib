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
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * The PXCutSoundStrategy class change sound channel properties using 
	 * direct and simple cut effect between old and new values. 
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	final public class PXCutSoundStrategy implements PXSoundStateStrategy
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function changeSound(channel : SoundChannel, trait : PXSoundTrait) : void
		{
			var transform : SoundTransform = channel.soundTransform;
			transform.volume = trait.muted ? 0 : trait.volume;
			transform.pan = trait.pan;

			channel.soundTransform = transform;
		}
	}
}
