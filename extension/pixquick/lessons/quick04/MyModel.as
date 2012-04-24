package
{
	import net.pixlib.events.PXStringEvent;
	import net.pixlib.quick.model.PXQuickModel;

	public class MyModel extends PXQuickModel
	{
		public function MyModel()
		{
			super("MyModel");
		}

		public function talk() : void
		{
			notifyChanged(new PXStringEvent("onTalk", this, "Hello world"));
		}
	}
}
