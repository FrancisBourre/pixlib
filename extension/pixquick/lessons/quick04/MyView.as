package
{
	import net.pixlib.events.PXStringEvent;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.view.PXQuickView;

	public class MyView extends PXQuickView
	{
		public function MyView()
		{
			super("MyView", PXQuick.root);
		}
		
		public function onTalk(event : PXStringEvent) : void
		{
			logger.debug(event.value, this);
		}
	}
}
