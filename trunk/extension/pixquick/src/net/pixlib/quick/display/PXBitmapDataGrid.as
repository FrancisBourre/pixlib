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
package net.pixlib.quick.display 
{
	import net.pixlib.log.PXDebug;
	import net.pixlib.log.PXStringifier;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Use <strong>BitmapData</strong> as source and implement grid access 
	 * to bitmap parts ( cell system ).
	 * 
	 * <p>Allows to build a bitmap with many icons, or anything else 
	 * inside and access specific one using grid access.</p>
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	final public class PXBitmapDataGrid 
	{
		//--------------------------------------------------------------------
		// Private properties
		//--------------------------------------------------------------------

		private var _cellWidth : Number;
		private var _cellHeight : Number;
		private var _bmp : BitmapData;

		
		//--------------------------------------------------------------------
		// Public properties
		//--------------------------------------------------------------------
		
		/**
		 * Returns bitmap cell width.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get cellWidth( ) : Number
		{
			return _cellWidth;
		}

		/**
		 * Returns bitmap cell height.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get cellHeight( ) : Number
		{
			return _cellHeight;
		}

		
		//--------------------------------------------------------------------
		// Public API
		//--------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param data BitmapData content source
		 * @param cellWidth Sub bitmap cell's width
		 * @param cellWidth ( optional ) Sub bitmap cell's height 
		 * ( if not defined, uses <code>cellWidth</code> ).
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */ 
		public function PXBitmapDataGrid( object : DisplayObject, cellWidth : Number, cellHeight : Number ) 
		{
			_bmp = new BitmapData(object.width, object.height, true, 0x00FFFFFF);
			_bmp.draw(object);
			
			_cellWidth = cellWidth;
			_cellHeight = ( !isNaN(cellHeight) ) ? cellHeight : _cellWidth;
			
			if( ( _bmp.width % _cellWidth ) )
				PXDebug.WARN("Possible problem with bitmap cell width [ " + _bmp.width + " / " + _cellWidth + " ]", this);
			
			if( ( _bmp.height % _cellHeight ) )
				PXDebug.WARN("Possible problem with bitmap cell height [ " + _bmp.height + " / " + _cellHeight + " ]", this);
		}

		/**
		 * Returns BitmapData positionned at <code>p</code> position in grid.
		 * 
		 * @param p Cell coordinate
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function getDataAt( p : Point ) : BitmapData
		{
			return _createBitmap(_cellWidth, _cellHeight, new Rectangle(p.x * _cellWidth, p.y * _cellHeight, _cellWidth, _cellHeight));
		}

		/**
		 * Returns a BitmapData containing the entire row at passed-in 
		 * <code>rowIndex</code> index.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function getDataRow( rowIndex : uint ) : BitmapData
		{
			return _createBitmap(_bmp.width, _cellHeight, new Rectangle(0, rowIndex * _cellHeight, _bmp.width, _cellHeight));	
		}

		/**
		 * Returns a new BitmapData containing the entire column  at passed-in 
		 * <code>columnIndex</code> index.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function getDataColumn( columnIndex : uint ) : BitmapData
		{
			return _createBitmap(_cellWidth, _bmp.height, new Rectangle(columnIndex * _cellWidth, 0, _cellWidth, _bmp.height));	
		}

		/**
		 * Returns the source BitmapData clone.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function getBitmapData( clone : Boolean = true ) : BitmapData
		{
			return clone ? _bmp.clone() : _bmp;	
		}

		/**
		 * Returns string representation.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function toString( ) : String
		{
			return PXStringifier.process(this) + "[" + _cellWidth + "x" + _cellHeight + "]";
		}

		
		//--------------------------------------------------------------------
		// Private implementations
		//--------------------------------------------------------------------
		
		/** @private */
		private function _createBitmap( w : Number, h : Number, rect : Rectangle ) : BitmapData 
		{
			var o : BitmapData = new BitmapData(w, h, true);
			o.copyPixels(_bmp, rect, new flash.geom.Point(0, 0));
			
			return o;
		}		
	}
}
