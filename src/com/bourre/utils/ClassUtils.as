/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @author Francis Bourre
 * @version 1.0
 */

class com.bourre.utils.ClassUtils 
{
	private function ClassUtils() 
	{
		
	}
	
	public static function getClassName( o ) : String 
	{
		var s : String = ClassUtils.getFullyQualifiedClassName( o );
		return s.substr( s.lastIndexOf(".")+1 );
	}
	
	public static function inheritsFromClass( o, clazz : Function ) : Boolean
	{
		var f = (typeof(o)=="function")? Function(o).prototype : o.__proto__;
		while( f = f.__proto__ ) if( clazz.prototype === f ) return true ;
		return false;
	}
	
	public static function implementsInterface( o, interfaze : Function ) : Boolean
	{
		if( inheritsFromClass( o, interfaze ) ) return false;
		return ( o instanceof interfaze );
	}
	
	public static function getFullyQualifiedClassName( o ) : String 
	{
		return ClassUtils._buildPath( "", _global, (typeof(o)=="function")? Function(o).prototype : o.__proto__ );
	}
	
	private static function _buildPath( s : String, pack, o ) : String
	{
		for ( var p : String in pack ) 
		{
			var cProto : Function = pack[p];
			
			if ( cProto.__constructor__ === Object ) 
			{
				p = ClassUtils._buildPath( s + p + ".", cProto, o );
				if ( p ) return p;
				
			} else if ( cProto.prototype === o )
			{
				return s + p;
			}
		}
	}
}