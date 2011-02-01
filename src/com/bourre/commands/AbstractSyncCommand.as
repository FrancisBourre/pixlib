import com.bourre.commands.ISyncCommand;
import com.bourre.commands.ISyncCommandListener;
import com.bourre.core.HashCodeFactory;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;

class com.bourre.commands.AbstractSyncCommand
	implements ISyncCommand
{

	private var _oEB : EventBroadcaster;
	private var _e : BasicEvent;
	public static var onCommandEndEVENT : EventType = new EventType("onCommandEnd");

	private function AbstractSyncCommand()
	{
		_oEB = new EventBroadcaster( this );
		_e = new BasicEvent( AbstractSyncCommand.onCommandEndEVENT );
	}
	
	public function addListener( o : ISyncCommandListener ) : Void 
	{
		_oEB.addEventListener( AbstractSyncCommand.onCommandEndEVENT, o);
	}

	public function removeListener( o : ISyncCommandListener ) : Void 
	{
		_oEB.removeEventListener( AbstractSyncCommand.onCommandEndEVENT, o);
	}

	public function fireCommandEndEvent() : Void 
	{
		_oEB.broadcastEvent( _e );
	}

	public function execute( e:IEvent ) : Void 
	{
		fireCommandEndEvent();
	}

	public function toString() : String
	{
		return PixlibStringifier.stringify( this );
	}
}