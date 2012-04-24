package
{
	import net.pixlib.commands.PXAbstractCommand;
	import net.pixlib.model.PXModel;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.view.PXView;

	import flash.events.Event;

	public class BuildMVC extends PXAbstractCommand
	{
		public function BuildMVC()
		{
			
		}

		override protected function onExecute(event : Event = null) : void
		{
			var view : PXView = new MyView();
			
			var model : PXModel = new MyModel();
			model.addListener(view);
			
			PXQuick.controller.pushCommandClass("onTalk", Talk);
			
			fireCommandEndEvent();//Always call fireCommandEndEvent() when command is finished
		}

	}
}
