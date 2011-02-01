/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */ /** * @author Francis Bourre * @version 1.0 */import com.bourre.data.collections.Map;import com.bourre.data.libs.BasicXMLDeserializer;import com.bourre.log.PixlibStringifier;class com.bourre.ioc.parser.ContextNodeNameList {	private static var _oI : ContextNodeNameList;		public static var BEANS : String = "beans";	public static var DEFAULT : String = "default";	public static var PROPERTY : String = "property";	public static var ARGUMENT : String = "argument";	public static var ROOT : String = "root";	public static var APPLICATION_LOADER : String = "application-loader";	public static var DLL : String = "dll";	public static var METHOD_CALL : String = "method-call";	public static var LISTEN : String = "listen";	private var _mNodeName : Map;		/**	 * @return singleton instance of DefaultContextNodeNameList	 */	public static function getInstance() : ContextNodeNameList 	{		if (!_oI) _oI = new ContextNodeNameList();		return _oI;	}		private function ContextNodeNameList()	{		init();	}		public function init() : Void	{		_mNodeName = new Map();				addNodeName( ContextNodeNameList.BEANS, "" );		addNodeName( ContextNodeNameList.DEFAULT, "" );		addNodeName( ContextNodeNameList.PROPERTY, "" );		addNodeName( ContextNodeNameList.ARGUMENT, "" );		addNodeName( ContextNodeNameList.ROOT, "" );		addNodeName( ContextNodeNameList.APPLICATION_LOADER, "" );		addNodeName( ContextNodeNameList.METHOD_CALL, "" );		addNodeName( ContextNodeNameList.LISTEN, "" );		addNodeName( BasicXMLDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME, "" );	}		public function addNodeName( nodeName : String, value ) : Void	{		_mNodeName.put( nodeName, value );	}		public function nodeNameIsReserved( nodeName ) : Boolean	{		return _mNodeName.containsKey( nodeName );	}		/**	 * Returns the string representation of this instance.	 * @return the string representation of this instance	 */	public function toString() : String 	{		return PixlibStringifier.stringify( this );	}}