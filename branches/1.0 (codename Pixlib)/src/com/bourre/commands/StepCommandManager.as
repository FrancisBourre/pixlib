import com.bourre.commands.CommandManagerMS;
import com.bourre.commands.Delegate;
import com.bourre.commands.ISyncCommand;
import com.bourre.commands.ISyncCommandListener;
import com.bourre.commands.MacroCommand;
import com.bourre.core.HashCodeFactory;
import com.bourre.events.BasicEvent;
import com.bourre.events.IEvent;
import com.bourre.log.Logger;
import com.bourre.log.LogLevel;
import com.bourre.log.PixlibStringifier;

class com.bourre.commands.StepCommandManager
	implements MacroCommand, ISyncCommandListener
{
	private var _aC : Array;
	private var _nStep : Number;
	private var _nTimeOut : Number;
	private var _nTimer : Number;
	private var _dCheckTimeOut : Delegate;
	
	public function StepCommandManager( nTimeOut : Number ) 
	{
		_aC = new Array();
		_nStep = 0;
		
		if ( nTimeOut>0 )
		{
			_nTimeOut = nTimeOut;
			_dCheckTimeOut = new Delegate( this, _checkTimeOut);
		} else
		{
			_nTimeOut = -1;
		}
	}
	
	public function addCommand( oC:ISyncCommand ) : Void
 	{
 		oC.addListener( this );
  		_aC.push(oC);
  	}
  	
  	public function removeCommand( oC:ISyncCommand ) : Void
  	{
  		var l:Number = _aC.length;
		while( --l > -1 ) 
		if (_aC[l] == oC) 
		{
			_aC[ l ].removeListener( this );
			_aC.splice(l, 1);
		}
  	}
  	
  	public function execute( e : IEvent ) : Void
 	{
  		if ( _nStep == 0) 
  		{
  			_executeNextCommand();
  		} else
  		{
  			_nStep = -1;
  			Logger.LOG( toString() + " is already running, you can't execute the process twice at the same time.", LogLevel.WARN);
  		}
  	}
  	
  	private function _executeNextCommand( o : ISyncCommand ) : Void
  	{
  		if ( _nStep == -1 )
  		{
  			Logger.LOG( toString() + " process has been aborted. Can't execute next command." , LogLevel.WARN);
  						
  		} else 
		{
			if( _nTimeOut != -1 )
	  		{
	  			CommandManagerMS.getInstance().remove( _dCheckTimeOut );
	  			_nTimer = getTimer();
	  			CommandManagerMS.getInstance().push( _dCheckTimeOut, 50 );
	  		}
			_aC[ _nStep ].execute();
  		}
  	}
  	
  	private function _checkTimeOut() : Void
  	{
  		if (getTimer() - _nTimer > _nTimeOut)
  		{
  			
  			CommandManagerMS.getInstance().remove( _dCheckTimeOut );
  			if (_nStep != getLength() - 1)
  			{ 
  				Logger.LOG( _aC[ _nStep ] + " didn't broadcast onCommandEnd event. " + toString() + " can't execute " + _aC[ _nStep+1 ], LogLevel.ERROR);
  			} else
  			{
  				Logger.LOG( _aC[ _nStep ] + " didn't broadcast onCommandEnd event. " + toString() + " can't end its process.", LogLevel.ERROR);
  			}
  			_nStep = -1;
  		}
  	}
  	
  	public function getLength() : Number
  	{
  		return _aC.length;
  	}
  	
	public function onCommandEnd(e : BasicEvent) : Void 
	{
		if (_nStep+1 < getLength())
		{
			_nStep++;
			_executeNextCommand();
		} else
		{
			_nStep = 0;
			if (_nTimeOut != -1) CommandManagerMS.getInstance().remove( _dCheckTimeOut );
		}
	}
	
	public function toString() : String
	{
		return PixlibStringifier.stringify( this );
	}
}