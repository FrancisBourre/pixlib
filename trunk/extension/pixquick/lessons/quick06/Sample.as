package
{
	import net.pixlib.load.PXLoader;
	import net.pixlib.load.PXLoaderEvent;
	import net.pixlib.load.pixlib_XMLLoader;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;
	import net.pixlib.quick.load.PXLoaderFactory;
	import net.pixlib.quick.load.PXLoaderType;

	import flash.net.URLRequest;

	public class Sample extends PXDocument
	{
		public function Sample()
		{
			
		}
		
		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
			
			var xmlLoader : PXLoader = PXLoaderFactory.create("picto", PXLoaderType.XML, new URLRequest("list.xml"));
			xmlLoader.addEventListener(PXLoaderEvent.onLoadInitEVENT, _onLoadInit);
			xmlLoader.load();
		}

		private function _onLoadInit(event : PXLoaderEvent) : void
		{
			trace(event.pixlib_XMLLoader::loader.xml);
		}
	}
}
