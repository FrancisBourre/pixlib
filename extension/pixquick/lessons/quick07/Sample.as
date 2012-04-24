package
{
	import net.pixlib.quick.util.PXLayoutUtils;
	import net.pixlib.utils.PXDisplayUtils;
	import net.pixlib.quick.PXQuick;
	import net.pixlib.quick.document.PXDocument;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="990", height="600")]
	public class Sample extends PXDocument
	{	
		public function Sample()
		{

		}

		override protected function onDocumentReady() : void
		{
			PXQuick.debug("Application is ready", this);
			
			var background : Sprite = PXDisplayUtils.createSprite(this);
			
			with(background.graphics)
			{	
				beginFill(0xFF0000,1);
				drawRect(0, 0, 600, 600);
				endFill();
			}

			var foreground : Sprite = PXDisplayUtils.createSprite(this);
			
			with(foreground.graphics)
			{	
				beginFill(0x0000FF,1);
				drawRect(0, 0, 200, 200);
				endFill();
			}
			
			PXLayoutUtils.align(foreground,background,PXLayoutUtils.ALIGN_TOP_LEFT);
						
		}
	}
}
