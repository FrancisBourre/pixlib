package
{
	import net.pixlib.events.PXBasicEvent;
	import net.pixlib.load.PXLoader;
	import net.pixlib.load.PXLoaderEvent;
	import net.pixlib.load.pixlib_GraphicLoader;
	import net.pixlib.log.PXDebug;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.display.PXTimeline;
	import net.pixlib.quick.document.PXDocument;
	import net.pixlib.quick.load.PXLoaderFactory;
	import net.pixlib.quick.load.PXLoaderType;

	import flash.display.MovieClip;
	import flash.net.URLRequest;


	public class Sample extends PXDocument
	{
		public function Sample()
		{
			
		}

		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
			
			var loader : PXLoader = PXLoaderFactory.create("animation", PXLoaderType.DISPLAY, new URLRequest("animation.swf"), false);
			loader.addEventListener(PXLoaderEvent.onLoadInitEVENT, _onLoaded);
			loader.load();
		}
		
		private function _onLoaded(event : PXLoaderEvent) : void
		{
			PXDebug.DEBUG("Animation loaded", this);
			
			event.stopImmediatePropagation();
			
			var animation : MovieClip = addChild(event.pixlib_GraphicLoader::loader.displayObject) as MovieClip;
			
			var controller : PXTimeline = new PXTimeline(animation, true);
			controller.addFrameListener("middle", _onMiddle);
			controller.play();
			
			PXDebug.DEBUG("Timeline length " + controller.totalFrames, this);
		}

		private function _onMiddle(event : PXBasicEvent) : void
		{
			var controller : PXTimeline = PXTimeline(event.target);
			PXDebug.DEBUG(controller.currentFrameLabel, this);
		}
	}
}
