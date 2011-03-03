/*
package net.pixlib.display
{
	import net.pixlib.core.PXApplication;
	/**
	final public class PXLayerManager
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**
		private static  var _instance : PXLayerManager ;

		/**
		private var _highLevel : Sprite;

		/**
		private var _topLevel : Sprite;

		/**
		private var _contentLevel : Sprite;

		/**
		private var _bottomLevel : Sprite;

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public static function getInstance() : PXLayerManager
		{
			if (!(_instance is PXLayerManager)) _instance = new PXLayerManager();
			return PXLayerManager._instance;
		}

		/**
		public static function release() : void
		{
			if (PXLayerManager._instance is PXLayerManager) 
		}

		/**
		public function addBottomChild(child : DisplayObject) : DisplayObject
		{
			return _bottomLevel.addChild(child);
		}

		/**
		public function addContentChild(child : DisplayObject) : DisplayObject
		{
			return _contentLevel.addChild(child);
		}

		/**
		public function addTopChild(child : DisplayObject) : DisplayObject
		{
			return _topLevel.addChild(child);
		}

		/**
		public function addHighChild(child : DisplayObject) : DisplayObject
		{
			return _highLevel.addChild(child);
		}
		
		/**
		public function toString() : String
		{
			return PXStringifier.process(this);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		protected function init() : void
		{
			_bottomLevel = PXApplication.getInstance().root.addChild(new Sprite()) as Sprite;
			_bottomLevel.tabEnabled = false;
			_contentLevel = PXApplication.getInstance().root.addChild(new Sprite()) as Sprite;
			_contentLevel.tabEnabled = false;
			_topLevel = PXApplication.getInstance().root.addChild(new Sprite()) as Sprite;
			_topLevel.tabEnabled = false;
			_highLevel = PXApplication.getInstance().root.addChild(new Sprite()) as Sprite;
			_highLevel.tabEnabled = false;
		}

		// --------------------------------------------------------------------
		// Private implementation
		// --------------------------------------------------------------------
		/**
		function PXLayerManager()
		{
			init();
		}
	}
}