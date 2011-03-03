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
 
import com.bourre.data.collections.AbstractFactory;
import com.bourre.log.PixlibStringifier;
import com.bourre.transitions.BasicMultiTweenFPS;
import com.bourre.transitions.BasicMultiTweenMS;
import com.bourre.transitions.BasicTweenFPS;
import com.bourre.transitions.BasicTweenMS;
import com.bourre.transitions.IBasicTween;
import com.bourre.transitions.MultiTweenFPS;
import com.bourre.transitions.MultiTweenMS;
import com.bourre.transitions.TweenFPS;
import com.bourre.transitions.TweenMS;

class com.bourre.transitions.TweenFactory 
	extends AbstractFactory
{
	/**
	 * Constructs a new {@code IBasicTween} instance.
	 * 
	 * <p>It acts as a factory, return type will depend upon passed arguments.
	 * 
	 * @param target			Object(s) targeted by the tween.
	 * @param property 			Setter : Method(s) or propert(y)(ies).
	 * @param endValue 			Ending value(s) of propert(y)(ies).
	 * @param rate 				Length of time (in frame per second or millisecond).
	 * @param startValue 		Starting value(s) of propert(y)(ies) (optional).
	 * @param easing 			Easing function (optional, default value is without easing).
	 * @param isFPS 			Easing function (optional, default value is true).
	 * @param hasEvent 			Easing function (optional, default value is true).
	*/
	public function buildTween(	target, 
								property, 
								endValue, 
								rate : Number, 
								startValue, 
								easing : Function, 
								isFPS : Boolean, 
								hasEvent : Boolean ) : IBasicTween
	{
		var sID : String;
		if ( isFPS == undefined ) isFPS = true;
		if ( hasEvent == undefined ) hasEvent = true;
		
		if ( endValue.length > 0 )
		{
			if ( isFPS )
			{
				sID = hasEvent? TweenFactory.__MULTI_TWEEN_FPS : TweenFactory.__BASIC_MULTI_TWEEN_FPS;

			} else
			{
				sID = hasEvent? TweenFactory.__MULTI_TWEEN_MS : TweenFactory.__BASIC_MULTI_TWEEN_MS;
			}
		} else
		{
			if ( isFPS )
			{
				sID = hasEvent? TweenFactory.__TWEEN_FPS : TweenFactory.__BASIC_TWEEN_FPS;

			} else
			{
				sID = hasEvent? TweenFactory.__TWEEN_MS : TweenFactory.__BASIC_TWEEN_MS;
			}
		}

		arguments.unshift( sID );
		return super._buildInstance.apply( this, arguments );
	}
	
	public function buildBasicTweenMS(	target, 
										property, 
										endValue, 
										rate : Number, 
										startValue, 
										easing : Function	) : IBasicTween
	{
		return buildTween( target, property, endValue, rate, startValue, easing, false, false );
	}
	
	public function buildBasicTweenFPS(	target, 
										property, 
										endValue, 
										rate : Number, 
										startValue, 
										easing : Function	) : IBasicTween
	{
		return buildTween( target, property, endValue, rate, startValue, easing, true, false );
	}
	
	public function buildTweenMS(	target, 
									property, 
									endValue, 
									rate : Number, 
									startValue, 
									easing : Function	) : IBasicTween
	{
		return buildTween( target, property, endValue, rate, startValue, easing, false, true );
	}
	
	public function buildTweenFPS(	target, 
									property, 
									endValue, 
									rate : Number, 
									startValue, 
									easing : Function	) : IBasicTween
	{
		return buildTween( target, property, endValue, rate, startValue, easing, true, true );
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString() : String 
	{
		return PixlibStringifier.stringify( this );
	}
	
	// singleton
	private static var _oI : TweenFactory;
	
	/**
	 * @return singleton instance of TweenFactory
	 */
	public static function getInstance() : TweenFactory
	{
		if (!_oI) _oI = new TweenFactory();
		return _oI;
	}
	
	// private implementation
	private static var __BASIC_TWEEN_MS : String = "BasicTweenMS";
	private static var __BASIC_TWEEN_FPS : String = "BasicTweenFPS";
	private static var __TWEEN_MS : String = "TweenMS";
	private static var __TWEEN_FPS : String = "TweenFPS";
	private static var __BASIC_MULTI_TWEEN_MS : String = "BasicMultiTweenMS";
	private static var __BASIC_MULTI_TWEEN_FPS : String = "BasicMultiTweenFPS";
	private static var __MULTI_TWEEN_MS : String = "MultiTweenMS";
	private static var __MULTI_TWEEN_FPS : String = "MultiTweenFPS";
	
	private function TweenFactory()
	{
		super();
		
		push( TweenFactory.__BASIC_TWEEN_MS, BasicTweenMS );
		push( TweenFactory.__BASIC_TWEEN_FPS, BasicTweenFPS );
		push( TweenFactory.__TWEEN_MS, TweenMS );
		push( TweenFactory.__TWEEN_FPS, TweenFPS );
		push( TweenFactory.__BASIC_MULTI_TWEEN_MS, BasicMultiTweenMS );
		push( TweenFactory.__BASIC_MULTI_TWEEN_FPS, BasicMultiTweenFPS );
		push( TweenFactory.__MULTI_TWEEN_MS, MultiTweenMS );
		push( TweenFactory.__MULTI_TWEEN_FPS, MultiTweenFPS );
	}
}