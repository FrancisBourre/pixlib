package
{
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;


	public class Sample extends PXDocument
	{
		public function Sample()
		{
			
		}

		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
		}
	}
}
