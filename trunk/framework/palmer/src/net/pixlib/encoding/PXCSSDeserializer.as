/*
	/**
	final public class PXCSSDeserializer implements PXDeserializer
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public function PXCSSDeserializer()
		{
		}

		/**
		public function deserialize(serializedContent : Object, target : Object = null, key : String = null) : Object
		{
			try
			{
				var sheet : StyleSheet = new StyleSheet(); 
			}
			catch( e : Error )
			{
				throw new PXIllegalArgumentException("deserialize() error. Content is not CSS compliant", this);
			}
			return null;
		}

		/**
		public function toString() : String
		{
			return PXStringifier.process(this);
		}
	}
}