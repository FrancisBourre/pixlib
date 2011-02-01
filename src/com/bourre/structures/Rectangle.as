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
 * {@code Rectangle} data structure.
 * 
 * <p>{@code Rectangle} structure manage many informations like : 
 * <ul>
 *   <li>Center point</li>
 *   <li>Top left corner</li>
 *   <li>Top Right corner</li>
 *   <li>Bottom left corner</li>
 *   <li>Bottom Right corner</li>
 *   <li>Left border</li>
 *   <li>Right border</li>
 *   <li>Top border</li>
 *   <li>Bottom border</li>
 *   <li>and position</li>
 * </ul>
 * 
 * @author Francis Bourre
 * @author Cédric Néhémie
 * @version 1.0
 */
 
import com.bourre.log.PixlibStringifier;
import com.bourre.structures.Point;

class com.bourre.structures.Rectangle
{
	//-------------------------------------------------------------------------
	// Public Properties
	//-------------------------------------------------------------------------
	
	/** width of {@code Rectangle}. **/
	public var width : Number;
	
	/** height of {@code Rectangle}. **/
	public var height : Number;
	
	/** x coordinate of {@code Rectangle}. **/
	public var x : Number;
	
	/** y coordinate of {@code Rectangle}. **/
	public var y : Number;
	
	//-------------------------------------------------------------------------
	// Public API
	//-------------------------------------------------------------------------
	
	/**
	 * Constructs a new {@code Rectangle} instance.
	 * 
	 * @param w width
	 * @param h height
	 * @param x x position
	 * @param y position
	 */
	public function Rectangle(w:Number, h:Number, x:Number, y:Number) 
	{
		width = w;
		height = h;
		this.x = x? x : 0;
		this.y = y? y : 0;
	}
	
	/**
	 * Returns top left corner.
	 * 
	 * @return {@link Point} instance with top left position
	 */
	public function getTopLeft() : Point
	{
		return new Point( x , y );
	}
	
	/**
	 * Set the top left corner.
	 * 
	 * <p>Modifying a corner change the size of the rectangle, 
	 * use {@link #x} and {@link #y} properties to align a rectangle
	 * to a position.
	 * 
	 * @return {@link Point} instance with new top left position
	 */
	public function setTopLeft( p : Point ) : Void
	{
		setLeft ( p.x );
		setTop ( p.y );
	}
	
	/**
	 * Returns top right corner.
	 * 
	 * @return {@link Point} instance with top right position
	 */
	public function getTopRight() : Point
	{
		return new Point( getRight() , y );
	}
	
	/**
	 * Set the top right corner.
	 * 
	 * <p>Modifying a corner change the size of the rectangle, 
	 * use {@link #x} and {@link #y} properties to align a rectangle
	 * to a position.
	 * 
	 * @return {@link Point} instance with new top right position
	 */
	public function setTopRight( p : Point ) : Void
	{
		setRight ( p.x );
		setTop ( p.y );
	}
	
	/**
	 * Returns bottom left corner.
	 * 
	 * @return {@link Point} instance with bottom left position
	 */
	public function getBottomLeft() : Point
	{
		return new Point( x , getBottom() );
	}
	
	/**
	 * Set the bottom left corner.
	 * 
	 * <p>Modifying a corner change the size of the rectangle, 
	 * use {@link #x} and {@link #y} properties to align a rectangle
	 * to a position.
	 * 
	 * @return {@link Point} instance with new bottom left position
	 */
	public function setBottomLeft( p : Point ) : Void
	{
		setLeft ( p.x );
		setBottom ( p.y );
	}
	
	/**
	 * Returns bottom right corner.
	 * 
	 * @return {@link Point} instance with bottom right position
	 */
	public function getBottomRight() : Point
	{
		return new Point( getRight() , getBottom() );
	}
	
	/**
	 * Set the bottom right corner.
	 * 
	 * <p>Modifying a corner change the size of the rectangle, 
	 * use {@link #x} and {@link #y} properties to align a rectangle
	 * to a position.
	 * 
	 * @return {@link Point} instance with new bottom right position
	 */
	public function setBottomRight( p : Point ) : Void
	{
		setRight ( p.x );
		setBottom ( p.y );
	}
	
	/**
	 * Returns center point
	 * 
	 * @return {@link Point} instance with center position
	 */
	public function getCenter() : Point
	{
		return new Point(x + width/2, y + height/2);
	}
	
	/**
	 * Returns left border
	 * 
	 * @return {@code Number}
	 */
	public function getLeft () : Number
	{
		return x;
	}
	
	/**
	 * Set the rectangle left border
	 * 
	 * @param	n The new left border
	 */
	public function setLeft ( n : Number ) : Void
	{
		var d : Number = n - x;
		x = n;
		width -= d;
	}
	
	/**
	 * Returns right border
	 * 
	 * @return {@code Number}
	 */
	public function getRight () : Number
	{
		return x + width;
	}
	
	/**
	 * Set the rectangle right border
	 * 
	 * @param	n The new right border
	 */
	public function setRight ( n : Number ) : Void
	{
		width = n - x;
	}
	
	/**
	 * Returns top border
	 * 
	 * @return {@code Number}
	 */
	public function getTop () : Number
	{
		return y;
	}
	
	/**
	 * Set the rectangle top border
	 * 
	 * @param	n The new top border
	 */
	public function setTop ( n : Number ) : Void
	{
		var d : Number = n - y;
		y = n;
		height -= d;
	}
	
	/**
	 * Returns bottom border
	 * 
	 * @return {@code Number}
	 */
	public function getBottom () : Number
	{
		return y + height;
	}
	
	/**
	 * Set the rectangle bottom border
	 * 
	 * @param	n The new bottom border
	 */
	public function setBottom ( n : Number ) : Void
	{
		height = n - y;
	}
	
	/**
     * Compare 2 rectangles each other.
     * 
     * <p>Rectangles are equals when size <b>and</b> position are
     * equals.
     *   
     * @param   r     The {@code Rectangle} object to compare with the current one.
     * @return  {@code true} if Rectangles are equals, {@code false} otherwise.
     */    
	public function equals ( r : Rectangle ) : Boolean
	{
		return ( (x == r.x) && (y == r.y) && (width == r.width) && (height == r.height) );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * 
	 * @return {@code String} representation of this instance
	 */
	public function toString() : String
	{
		return PixlibStringifier.stringify( this ) + " : [" + width + ", " + height + ", " + x + ", " + y + "]";
	}
}