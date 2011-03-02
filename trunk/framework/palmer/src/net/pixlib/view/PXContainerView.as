/*
	public class PXContainerView extends PXAbstractView
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public function PXContainerView(viewOwner : PXPlugin = null, viewName : String = null, dpo : DisplayObject = null)
		{
			super(viewOwner, viewName, dpo);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		}
		 * Inits default view behaviours.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		protected function initBehaviour() : void
		{
			container.tabEnabled = false;
		}
		final protected function addChild(child : DisplayObject) : DisplayObject
		{
			return container.addChild(child);
		}
		
		/**
		final protected function addChildAt(child : DisplayObject, index : int) : DisplayObject
		{
			return container.addChildAt(child, index);
		}

		/**
		final protected function removeChild(child : DisplayObject) : DisplayObject
		{
			return container.removeChild(child);
		}

		/**
		final protected function removeChildAt(index : int) : DisplayObject
		{
			return container.removeChildAt(index);
		}
		}
		{
			return addChild(new Bitmap(bitmapData, pixelSnapping, smoothing)) as Bitmap;
}