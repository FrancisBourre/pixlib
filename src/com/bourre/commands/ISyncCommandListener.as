import com.bourre.events.BasicEvent;

interface com.bourre.commands.ISyncCommandListener 
{
	public function onCommandEnd( e : BasicEvent ) : Void;
}