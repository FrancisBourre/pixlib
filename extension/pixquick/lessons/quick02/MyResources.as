package
{
	import net.pixlib.quick.document.resource.PXDocumentResource;
	import net.pixlib.quick.document.resource.PXDocumentResourceCollection;


	/**
	 * @author Romain Ecarnot
	 */
	public class MyResources extends PXDocumentResourceCollection
	{
		public function MyResources()
		{
			super();
		}
		
		override protected function init() : void
		{
			configuration = new PXDocumentResource("config.xml");
		}
	}
}
