/*
package net.pixlib.quick.document.sound
	final public class PXDocumentSoundModel extends PXQuickModel
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/** 
		private var _event : PXSoundTraitEvent;
		
		/**
		private var _trait : PXSoundTrait;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		public function get muted() : Boolean
		{
			return _trait.muted;
		}

		/** @private */
		public function set muted(value : Boolean) : void
		{
			if (value != _trait.muted)
			{
				_trait.muted = value;
				fireChangeEvent();
			}
		}

		/**
		public function get volume() : Number
		{
			return _trait.volume;
		}

		/** @private */
		public function set volume(value : Number) : void
		{
			if (value != _trait.volume)
			{
				_trait.volume = value;
				fireChangeEvent();
			}
		}

		/**
		public function get pan() : Number
		{
			return _trait.pan;
		}

		/** @private */
		public function set pan(value : Number) : void
		{
			if (value != _trait.pan)
			{
				_trait.pan = value;
				fireChangeEvent();
			}
		}

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public function PXDocumentSoundModel()
		{
			super(ID);
			_trait = new PXSoundTrait();
			_event = new PXSoundTraitEvent(Event.CHANGE, null, _trait);
		}

		/**
		public function init() : void
		{
			onInitModel();
			fireChangeEvent();
		}

		/**
		public function setTrait(trait : PXSoundTrait) : void
		{
			_trait = trait;
			fireChangeEvent();
		}

		/**
		public function getTrait() : PXSoundTrait
		{
			return _trait;
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		protected function fireChangeEvent() : void
		{
			_event.trait = _trait;
			notifyChanged(_event);
		}
	}
}