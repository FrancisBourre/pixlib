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
	import net.pixlib.quick.PXQuick;

	import com.greensock.TweenLite;

	import flash.media.SoundChannel;

	/**
	 * The PXTweenSoundStrategy class change sound channel properties using 
	 * GreenSock Tweening engine for smooth effect. 
	 * 
	 * <p>Be sure to have greensock.swc in your source path for compilation.</p>.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	final public class PXTweenSoundStrategy implements PXSoundStateStrategy 
	{
		//--------------------------------------------------------------------
		// Public properties
		//--------------------------------------------------------------------
		
		/**
		 * Properties transition duration.
		 * 
		 * @default 1 (seconde)
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public static var DELAY : Number = 1;
		
		
		//--------------------------------------------------------------------
		// Public API
		//--------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function changeSound(channel : SoundChannel, trait : PXSoundTrait) : void
		{
			try
			{
				TweenLite.to(channel, DELAY, {volume:trait.muted ? 0 : trait.volume});
			}
			catch(e : Error)
			{
				PXQuick.error("Greensock Tweening Platform (TweenLite) was not found", this);
			}
		}
	}
}
