package
{
	import flash.events.Event;
	import net.pixlib.commands.PXAbstractCommand;

	public class Talk extends PXAbstractCommand
	{
		public function Talk()
		{
		}

		override protected function onExecute(event : Event = null) : void
		{
			var model : MyModel = getModel("MyModel") as MyModel;
			model.talk();
			
			fireCommandEndEvent();
		}

	}
}
