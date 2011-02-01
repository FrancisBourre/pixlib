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
 
import com.bourre.data.iterator.Iterator;

class com.bourre.data.iterator.ArrayLoopIterator 
	implements Iterator
{
	private var _a:Array;
	private var _n:Number;
	
	public function ArrayLoopIterator(a:Array)
	{
		_a = a;
	}
	
	public function getLength() : Number
	{
		return _a.length;
	}
	
	public function hasNext() : Boolean 
	{
		return _n < _a.length - 1;
	}
	
	public function next() 
	{
		if( _n == undefined || _n == _a.length-1 ) _n = -1;
		return _a[++_n];
	}
	
	public function previous() 
	{
		if( _n == undefined || _n == 0 ) _n = _a.length;
		return _a[--_n];
	}

	public function getIndex() : Number 
	{
		return _n;
	}
	
	public function setIndex( n : Number )
	{
		_n = n;
	}
	
	public function resetIndex() : Void
	{
		_n = undefined;
	}
}