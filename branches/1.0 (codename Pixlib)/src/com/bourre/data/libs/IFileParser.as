import com.bourre.data.libs.FileLib;

interface com.bourre.data.libs.IFileParser 
{
	public function setOwner( owner : FileLib ) : Void;
	public function parse( sData : String ) : Void;
}