/*
package net.pixlib.tms
	final public class PXLanguage
	{
		public static const onChangeEVENT : String = "onChange";
		
		// Private properties
		// --------------------------------------------------------------------
		private static  var _instance : PXLanguage ;
		
		private var _language : String;
		
		/**
		private var _bundleMap : PXHashMap;
		
		/**
		private var _broadcaster : PXEventBroadcaster;
		
		/**
		private var _loader : PXSequencer;
		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		public function get current() : String
		{
			return _language;
		}
		
		/** @private */
		public function set current(value : String) : void
		{
			if (value != _language)
			{
				if ( !_bundleMap.containsKey(value)) _bundleMap.put(value, new Vector.<PXILanguageBundle>());
				
				
				for each (var bundle : PXILanguageBundle in bundleList)
				{
					if ( bundle is PXLoadableBundle )
					{
						loadable = bundle as PXLoadableBundle;
						if (!loadable.loaded)
						{
							_loader.addCommand(bundle as PXLoadableBundle);
						}
					}
				}
				if ( _loader.length > 0 )
				{
					_loader.addEventListener(PXSequencer.onSequencerEndEVENT, _onSequenceEnd, value);
					_loader.execute();
				}
				else
				{
					_language = value;
					_broadcaster.broadcastEvent(new PXBasicEvent(PXLanguage.onChangeEVENT, this));
				}
			}
		}
		// --------------------------------------------------------------------
		/**
		public static function getInstance() : PXLanguage
		{
			if (!(_instance is PXLanguage)) _instance = new PXLanguage();
			return _instance;
		}
		
		/**
		public static function release() : void
		{
			if (_instance is PXLanguage) 
			}

		/**
		public function addBundle(bundle : PXILanguageBundle) : Boolean
		{
			if ( !_bundleMap.containsKey(bundle.language)) _bundleMap.put(bundle.language, new Vector.<PXILanguageBundle>());
			try
			{
				if ( !isBundleRegistered(bundle.language, bundle.id))
				{
					_bundleMap.get(bundle.language).push(bundle);
					return true;
				}
				else
				{
					PXDebug.ERROR("A bundle named '" + bundle.id + "' is already registered for '" + bundle.language + "'.", this);
					return false;
				}
			}
			catch(e : Error)
			{
				throw new PXUnsupportedOperationException("LocalBundle can't be registered : " + e.message, this);
			}
			return false;
		}
		
		/**
		public function hasResource(key : String, bundleID : String = PXLanguageBundle.ID) : Boolean
		{
			if (bundleID == null) bundleID = PXLanguageBundle.ID;
			if ( isBundleRegistered(_language, bundleID))
			{
				var bundle : PXILanguageBundle = getBundle(_language, bundleID);
				if ( bundle.hasResource(key))
				{
					return true;
				}
				else PXDebug.ERROR("Resource named '" + key + "' is not registered in '" + bundleID + "' for '" + _language + "'.", this);
			}
			else PXDebug.ERROR("LocalBundle named '" + bundleID + "' is not registered in '" + _language + "'.", this);
			return false;
		}

		/**
		public function hasLanguage(search : String) : Boolean
		{
			return _bundleMap.containsKey(search);
		}
		
		/**
		public function getResource(key : String, bundleID : String = PXLanguageBundle.ID, defaultValue : * = "") : String
		{
			var bundle : PXILanguageBundle = getBundle(_language, bundleID);
			if (bundle && bundle.hasResource(key))
			{
				return bundle.getResource(key);
			}
			else return defaultValue;
		}
		
		/**
		public function getString(key : String, bundleID : String = PXLanguageBundle.ID, defaultValue : String = "", substitutions : Array = null) : String
		{
			var value : String = getResource(key, bundleID, defaultValue);
				value = PXStringUtils.substitute.apply(null, [value].concat(substitutions));
			return value;
		}
		
		/**
		public function getNumber(key : String, bundleID : String = PXLanguageBundle.ID, defaultValue : Number = 0) : Number
		{
			var value : String = getResource(key, bundleID, defaultValue);
			return Number(value) || defaultValue;
		}
		
		/**
		public function addEventListener(type : String, listener : Object, ... rest) : Boolean
		{
			return _broadcaster.addEventListener.apply(_broadcaster, rest.length > 0 ? [type, listener].concat(rest) : [type, listener]);
		}

		/**
		public function removeEventListener(type : String, listener : Object) : Boolean
		{
			return _broadcaster.removeEventListener(type, listener);
		}

		/**
		public function clear() : void
		{
			_broadcaster.removeAllListeners();
			_bundleMap.clear();
		}
		
				code = langNode.@code.toString();
					bundleID = bundleNode.@name.toString();
					if (!bundleID || bundleID.length == 0) bundleID = PXLanguageBundle.ID;
					
		public function toString() : String
		{
			return PXStringifier.process(this);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		protected function getBundle(langTarget : String, bundleID : String) : PXILanguageBundle
		{
			if ( _bundleMap.containsKey(langTarget))
			{
				var bundleList : Vector.<PXILanguageBundle> = _bundleMap.get(langTarget);
				for each (var bundle : PXILanguageBundle in bundleList) if ( bundle.id == bundleID ) return bundle;
			}
			else
			{
				PXDebug.ERROR("Local '" + langTarget + "' is not declared in LocalManager.", this);
			}
			return null;
		}

		/**
		protected function isBundleRegistered(langTarget : String, bundleID : String) : Boolean
		{
			return getBundle(langTarget, bundleID) != null;
		}

		// --------------------------------------------------------------------
		// Private implementation
		// --------------------------------------------------------------------
		
		function PXLanguage()
		{
			_broadcaster = new PXEventBroadcaster(this);
			_bundleMap = new PXHashMap();
			_loader = new PXSequencer();
		}
		
		private function _onSequenceEnd(event : Event, value : String) : void
		{
			_language = value;
			_loader.removeEventListener(PXSequencer.onSequencerEndEVENT, _onSequenceEnd);
			_broadcaster.broadcastEvent(new PXBasicEvent(PXLanguage.onChangeEVENT, this));
		}
	}
}