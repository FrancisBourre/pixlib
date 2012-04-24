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

	/**
	 * All strategies implementations to change sound state properties 
	 * must implements this interface. 
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 */
	public interface PXSoundStateStrategy 
	{
		//--------------------------------------------------------------------
		// Public API
		//--------------------------------------------------------------------
		
		/**
		 * Changes passed-in SoundChannel properties using passed-in 
		 * PXSoundTrait argument.
		 * 
		 * @param channel	SoundChannel to change
		 * @param trait		SoundTrait properties
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function changeSound(channel : SoundChannel, trait : PXSoundTrait) : void;
	}
}
