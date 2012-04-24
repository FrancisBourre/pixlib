package
{
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;
	import net.pixlib.quick.document.license.PXLicense;
	import net.pixlib.quick.document.license.type.PXInMarketLicense;

	public class Sample extends PXDocument
	{
		public function Sample()
		{
			
		}
		
		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
		}
		
		override protected function get license() : PXLicense
		{
			return new PXInMarketLicense(this, "PUBLICATION_ID");
		}
	}
}
