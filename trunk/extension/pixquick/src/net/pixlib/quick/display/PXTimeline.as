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

	import net.pixlib.collections.PXHashMap;
	import net.pixlib.events.PXBasicEvent;
	import net.pixlib.log.PXStringifier;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;


	/**
	 * 
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * 
	 * @author Romain Ecarnot
	 */
	public class PXTimeline
	{
		/**
		 * @private
		 */
		private var _mc : MovieClip;

		/**
		 * @private
		 */
		private var _map : PXHashMap;
		
		/**
		 * Current's timeline frame.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get currentFrame() : int
		{
			return _mc.currentFrame;
		}

		/**
		 * Current's timeline fram label.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get currentFrameLabel() : String
		{
			return _mc.currentFrameLabel;
		}
		
		/**
		 * The total number of frames in the Timeline instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get totalFrames() : int
		{
			return _mc.totalFrames;
		}

		/**
		 * The controlled timeline.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function get timeline() : MovieClip
		{
			return _mc;
		}

		/**
		 * 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function PXTimeline(timeline : MovieClip, autostop : Boolean = false)
		{
			_mc = timeline;
			if (autostop) _mc.gotoAndStop(1);

			_map = new PXHashMap();
		}

		/**
		 * Plays timeline.
		 * 
		 * @param frame	(optional) 	Label or frame number to start playing the 
		 * 							The Timeline. If null, starts playing at 
		 * 							current timeline position. 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function play(frame : * = null) : void
		{
			if (frame == null)
			{
				_mc.play();
			}
			else
			{
				_mc.gotoAndPlay(_resolveFrame(frame));
			}
			
			_mc.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}

		/**
		 * Stops timeline.
		 * 
		 * @param frame	(optional) 	Label or frame number to stop playing the 
		 * 							The Timeline. If null, stops playing at 
		 * 							current timeline position. 
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function stop(frame : * = null) : void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);

			if ( frame == null )
			{
				_mc.stop();
			}
			else
			{
				_mc.gotoAndStop(_resolveFrame(frame));
			}
		}

		/**
		 * Stops the timeline at the beginning.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function rewind() : void
		{
			stop(1);
		}
		
		/**
		 * Stops the timeline at the end.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function end() : void
		{
			stop(totalFrames);
		}
		
		/**
		 * Adds passed-in listener to listen to timeline when the passed-in 
		 * frame is activated.
		 *
		 * <p>You can add only one listener by frame, if you add listeners two 
		 * times for example for the frame 10, only the last one will be 
		 * triggered.</p>
		 * 
		 * @param frame	Frame to listen
		 *  
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function addFrameListener(frame : Object, listener : Function) : void
		{
			_map.put(_resolveFrame(frame), listener);
		}
		
		/**
		 * Removes listener for passed-in frame.
		 * 
		 * @param frame	Frame to listen
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function removeFrameListener(frame : Object) : void
		{
			var index : uint = _resolveFrame(frame);

			if (_map.containsKey(index))
			{
				_map.remove(index);
			}
		}

		/**
		 * Returns string representation of instance.
		 * 
		 * @return The string representation of instance.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 10
		 */
		public function toString() : String
		{
			return PXStringifier.process(this) + "[" + _mc.name + "]";
		}

		/**
		 * @private
		 */
		private function _resolveFrame(frame : Object) : uint
		{
			if (!_mc) return 0;

			if (frame is uint)
			{
				if (frame < totalFrames) return frame as uint;
			}
			else if (frame is String)
			{
				var i : uint;
				var a : Array = _mc.currentLabels ;
				for each ( var label:FrameLabel in a )
				{
					if (label.name == frame )
					{
						i = label.frame;
						return i > 1 ? i : 1 ;
					}
				}
			}

			throw new ArgumentError(this + " resolveFrame failed. Passed-in '" + frame + "' frame does not exist in current timeline.");
			return _mc.currentFrame;
		}

		/**
		 * @private
		 */
		private function _onEnterFrame(event : Event = null) : void
		{
			if (_map.containsKey(_mc.currentFrame))
			{
				_map.get(_mc.currentFrame)(new PXBasicEvent(Event.ENTER_FRAME, this));
			}
		}
	}
}
