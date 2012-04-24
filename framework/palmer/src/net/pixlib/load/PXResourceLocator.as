/*
package net.pixlib.load
	/**
	final public class PXResourceLocator implements PXLocator
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/** @private */
		private static const DEFAULT_NAME : String = "DefaultResourceLocator";

		/** @private */
		private static const _M : PXHashMap = new PXHashMap();

		/** @private */
		private var _sName : String;

		/** @private */
		private var _keyList : Array;
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		public function get name() : String
		{
			return _sName;
		}
		
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public static function getInstance(key : String = null) : PXResourceLocator
		{
			if ( key == null || key.length < 1 ) key = DEFAULT_NAME;
			if (!_M.containsKey(key)) _M.put(key, new PXResourceLocator(key));
			return _M.get(key);
		}

		/**
		public static function release(key : String = null) : Boolean
		{
			if ( key == null || key.length < 1 ) key = DEFAULT_NAME;
			if (_M.containsKey(key))
			{
				getInstance(key).clear();
				_M.remove(key);
				return true;
			}
			return false;
		}

		/**
		public function register(key : String, element : Object) : Boolean
		{
			var keyName : String = pixlib_internal::buildResourceID(name, key);
			if (!PXCoreFactory.getInstance().isRegistered(keyName))
			{
				if (PXCoreFactory.getInstance().register(keyName, element))
				{
					_keyList.push(keyName);
					return true;
				}
			}
			else
			{
				PXDebug.ERROR(" element is already registered with '" + key + "' name in " + this, this);
			}
			return false;
		}

		/**
		public function unregister(key : String) : Boolean
		{
			var keyName : String = pixlib_internal::buildResourceID(name, key);
			if (PXCoreFactory.getInstance().unregister(keyName))
				return true;
			}
			return false;
		}
		
		/**
		public function locate(key : String) : Object
		{
			var keyName : String = pixlib_internal::buildResourceID(name, key);
			if ( PXCoreFactory.getInstance().isRegistered(keyName) )
			{
				return PXCoreFactory.getInstance().locate(keyName);
			}
			else
			{
				throw new PXNoSuchElementException("Can't find item with '" + key + "' name in '" + name + "' ResourceLocator.", this);
			}
		}

		/**
		public function locateCSS(key : String) : PXCSS
		{
			try
			{
				return locate(key) as PXCSS;
			}
			catch(e : Error)
			{
				PXDebug.ERROR(this + ".locateCSS(" + key + ") failed." + e.message, this);
			}
			return null;
		}

		/**
		public function locateShader(key : String) : Shader
		{
			try
			{
				return locate(key) as Shader;
			}
			catch(e : Error)
			{
				PXDebug.ERROR(".locateShader(" + key + ") failed." + e.message, this);
			}
			return null;
		}

		/**
		public function locateXML(key : String) : XML
		{
			try
			{
				return locate(key) as XML;
			}
			catch(e : Error)
			{
				PXDebug.ERROR(".locateXML(" + key + ") failed." + e.message, this);
			}
			return null;
		}

		/**
		public function locateDisplayObject(key : String) : DisplayObject
		{
			try
			{
				return locate(key) as DisplayObject;
			}
			catch(e : Error)
			{
				PXDebug.ERROR(".locateDisplayObject(" + key + ") failed." + e.message, this);
			}
			return null;
		}

		/**
		public function isRegistered(key : String) : Boolean
		{
			return PXCoreFactory.getInstance().isRegistered(pixlib_internal::buildResourceID(name, key));
		}

		/**
		public function add(dico : Dictionary) : void
		{
			PXDebug.ERROR(".add() is not available in this implementation.", this);
		}

		/**
		public function clear() : void
		{
			var len : uint = _keyList.length;
			for (var i : uint = 0;i < len;i++) PXCoreFactory.getInstance().unregister(_keyList[i]);
			_keyList = [];
		}

		/**
		public function isEmpty() : Boolean
		{
			return _keyList.length == 0;
		}

		/**
		public function size() : uint
		{
			return _keyList.length;
		}
		/**
		public function toString() : String
		{
			return PXStringifier.process(this) + "[" + name + "]";
		}

		// --------------------------------------------------------------------
		// Private implementation
		// --------------------------------------------------------------------
		/**
		function PXResourceLocator(name : String)
		{
			super();
			_sName = name;
			_keyList = [];
		}

		/**
		pixlib_internal static function buildResourceID(locatorName : String, resourceID : String) : String
		{
			{
				return "ResourceLocator(" + locatorName + "," + resourceID + ")";
			}
			return resourceID;
		}
	}
}