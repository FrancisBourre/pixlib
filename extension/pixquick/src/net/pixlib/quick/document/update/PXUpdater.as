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
package net.pixlib.quick.document.update
{
	import flash.events.IEventDispatcher;

	/**
	 * The DefaultAIRUpdater class implements update mechanism to update 
	 * an Adobe AIR 2.0 application.
	 * 
	 * <p>Be sure to inject config/updateConfig.xml file in your application 
	 * package.</p>
	 * 
	 * <p>Use the default ApplicationUpdaterUI behaviour.</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public interface PXUpdater extends IEventDispatcher
	{
		/**
		 * Starts update engine.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function update() : void;
		
		/**
		 * Returns string represenation of instance.
		 * 
		 * @return A String representation of instance
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function toString() : String;
	}
}
