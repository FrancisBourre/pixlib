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
package net.pixlib.quick.view
{
	import net.pixlib.plugin.PXBasePlugin;
	import net.pixlib.view.PXAbstractView;

	import flash.display.DisplayObject;

	/**
	 * The PXQuickView class is an abstract implementation for view which 
	 * use the default PixQuick Plugin as owner.
	 * 
	 * @example
	 * <listing>
	 * 
	 * package
	 * {
	 * 	public class MyView extends PXQuickView
	 * 	{
	 * 		public function MyView()
	 * 		{
	 * 			super("MyView");
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 *
	 * @author Romain Ecarnot
	 */
	public class PXQuickView extends PXAbstractView
	{
		public function PXQuickView(viewName : String = null, dpo : DisplayObject = null)
		{
			super(PXBasePlugin.getInstance(), viewName, dpo);
		}
	}
}
