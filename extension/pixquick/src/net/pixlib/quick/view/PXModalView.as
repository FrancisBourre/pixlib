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
	import net.pixlib.display.PXLayerManager;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.structures.PXDimension;
	import net.pixlib.utils.PXDisplayUtils;
	import net.pixlib.view.PXContainerView;
	import net.pixlib.view.PXStageResizable;
	import net.pixlib.view.PXStageResizeManager;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;


	/**
	 * The PXModalView defines implementation for a view 
	 * using a modal behaviour on his layer.
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 *
	 * @author Romain Ecarnot
	 */
	public class PXModalView extends PXContainerView implements PXStageResizable
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**
		 * @private
		 * Modal sprite.
		 */
		private var _modal : Sprite;

		/**
		 * @private
		 * Content container.
		 */
		private var _container : DisplayObjectContainer;

		// --------------------------------------------------------------------
		// Protected properties
		// --------------------------------------------------------------------
		/**
		 * Returns content container.
		 * 
		 * @return The content container.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override protected function get container() : DisplayObjectContainer
		{
			return _container;
		}

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		override public function get position() : Point
		{
			return new Point(container.x, container.y);
		}

		/**
		 * @private
		 */
		override public function set position(value : Point) : void
		{
			container.x = value.x;
			container.y = value.y;
		}

		/**
		 * @inheritDoc
		 */
		override public function get size() : PXDimension
		{
			return new PXDimension(container.width, container.height);
		}

		/**
		 * @private
		 */
		override public function set size(value : PXDimension) : void
		{
			container.width = value.width;
			container.height = value.height;
		}

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		 * Shows view.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override public function show() : void
		{
			PXStageResizeManager.register(this);
			PXDisplayUtils.toTop(content);

			showInternal();

			super.show();
		}

		/**
		 * Hides view.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		override public function hide() : void
		{
			hideInternal();

			super.hide();

			PXStageResizeManager.unregister(this);
		}

		/**
		 * @inheritDoc
		 */
		public function resize(applicationSize : PXDimension = null) : void
		{
			resizeModal();
			resizeInternal();
		}

		/**
		 * @inheritDoc
		 */
		final override public function resolveUI(label : String, tryToResolve : Boolean = false) : DisplayObject
		{
			return resolveUIImp(container, label, tryToResolve);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		override protected function onInitView() : void
		{
			super.hide();

			_modal = DisplayObjectContainer(content).addChild(new Sprite()) as Sprite;
			_modal.buttonMode = true;
			_modal.useHandCursor = false;

			_container = DisplayObjectContainer(content).addChild(new Sprite()) as Sprite;

			createContent();

			super.onInitView();
		}

		/**
		 * Returns modal container.
		 * 
		 * @return The modal container.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function getModal() : Sprite
		{
			return _modal;
		}

		/**
		 * Creates view content.
		 * 
		 * <p>Overrides this method to define your own modal content.</p>
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function createContent() : void
		{
		}

		/**
		 * Internal process for "showing" feature.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function showInternal() : void
		{
		}

		/**
		 * Internal process for "resizing" feature.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function resizeInternal() : void
		{
		}

		/**
		 * Internal process for "hiding" feature.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function hideInternal() : void
		{
		}

		/**
		 * Centers the content container.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function centerContent() : void
		{
			container.x = Math.floor((content.stage.stageWidth >> 1) - (container.width >> 1));
			container.y = Math.floor((content.stage.stageHeight >> 1) - (container.height >> 1));
		}

		/**
		 * Resizes processing for modal object.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function resizeModal() : void
		{
			with(getModal().graphics)
			{
				clear();
				beginFill(0xFF0000, 0);
				drawRect(0, 0, PXQuick.size.width, PXQuick.size.height);
				endFill();
			}
		}

		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------

		/**
		 * @private
		 * Creates instance.
		 * 
		 * @param owner	View's owner (Plugin instance)
		 * @param name	View's identifier (must be unique in application)
		 */
		function PXModalView(name : String)
		{
			super(PXQuick.plugin, name, PXLayerManager.getInstance().addHighChild(new Sprite()));
		}
	}
}