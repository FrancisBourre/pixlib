/*
package net.pixlib.quick.command.config
	final public class PXLoadUI extends PXAbstractResourceLoader
	{
		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public function PXLoadUI(resource : PXDocumentResource)
		{
			super(resource);
		}

		// --------------------------------------------------------------------
		// Protected methods
		// --------------------------------------------------------------------
		/**
		override protected function get loader() : PXLoader
		{
			return new PXGraphicLoader(null, -1, false);
		}

		/**
		override protected function get request() : PXRequestHelper
		{
			return PXRequestHelper.create(resource.url, null, resource.anticache);
		}
	}
}