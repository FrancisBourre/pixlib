package
{
	import net.pixlib.commands.PXSequencer;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;

	import flash.events.Event;

	public class Sample extends PXDocument
	{
		public function Sample()
		{
			
		}
		
		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
			
			PXQuick.firePrivateEvent(new Event("onTalk"));
		}

		override protected function get configSequencer() : PXSequencer
		{
			var sequencer : PXSequencer = super.configSequencer;
			sequencer.addCommand(new BuildMVC());
			
			return sequencer;
		}
	}
}
