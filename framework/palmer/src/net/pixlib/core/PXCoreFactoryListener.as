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
package net.pixlib.core
{
	/**
	 * The PXCoreFactoryListener interface defines class implementation for 
	 * instances which want to listen PXCoreFactory processes.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
		 
	 * @author Francis Bourre
	 */
	public interface PXCoreFactoryListener
	{
		/**
		 * Triggered when an ressource was registered into the PXCoreFactory.
		 * 
		 * @param event	PXCoreFactoryEvent instance with registration informations.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function onRegisterBean( event : PXCoreFactoryEvent ) : void;
		
		/**
		 * Triggered when an ressource was unregistered into the PXCoreFactory.
		 * 
		 * @param event	PXCoreFactoryEvent instance with unregistration informations.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function onUnregisterBean( event : PXCoreFactoryEvent ) : void;
	}
}