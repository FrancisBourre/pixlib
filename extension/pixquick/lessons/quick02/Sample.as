package
{
	import net.pixlib.log.PXLogManager;
	import net.pixlib.log.PXTraceLayout;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;
	import net.pixlib.quick.document.resource.PXDocumentResourceCollection;


	public class Sample extends PXDocument
	{
		public function Sample()
		{
			PXLogManager.getInstance().addLogListener(PXTraceLayout.getInstance());
		}
		
		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
			
			PXQuick.debug(PXQuick.configuration, this);
		}
		
		override protected function get resources() : PXDocumentResourceCollection
		{
			return new MyResources();
		}
	}
}
