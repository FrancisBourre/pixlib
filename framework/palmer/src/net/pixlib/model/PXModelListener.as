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
package net.pixlib.model 
{

	/**
	 * The PXModelListener interface defines rules for model listeners.
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 	 * @author 	Francis Bourre
	 */
	public interface PXModelListener 
	{
		/**
		 * Triggered when model is initialized.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function onInitModel( event : PXModelEvent ) : void;

		/**
		 * Triggered when model is released.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		function onReleaseModel( event : PXModelEvent ) : void;
	}
}
