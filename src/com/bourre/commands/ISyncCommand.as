import com.bourre.commands.Command;
import com.bourre.commands.ISyncCommandListener;

interface com.bourre.commands.ISyncCommand
	extends Command
{
	public function addListener( o : ISyncCommandListener ) : Void;
	public function removeListener( o : ISyncCommandListener ) : Void;
	public function fireCommandEndEvent() : Void;
}