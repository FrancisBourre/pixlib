/*
package net.pixlib.quick.display
{
	import net.pixlib.log.PXStringifier;

	/**
	 * Controls Display object using dynamic registration point.
	 */
	final public class PXRegDisplayObject
	{
		// --------------------------------------------------------------------
		// Private properties
		// --------------------------------------------------------------------
		/**
		private var _target : DisplayObject;

		/**
		private var _reg : Point;

		// --------------------------------------------------------------------
		// Public properties
		// --------------------------------------------------------------------
		/**
		public function get registration() : Point
		{
			return _reg;
		}

		/** @private */
		public function set registration(p : Point) : void
		{
			_reg = p.clone();
		}

		/**
		public function get target() : DisplayObject
		{
			return _target;
		}

		/**
		public function get x() : Number
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			return p.x;
		}

		/** @private */
		public function set x(value : Number) : void
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.x += value - p.x;
		}

		/**
		public function get y() : Number
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			return p.y;
		}

		/** @private */
		public function set y(value : Number) : void
		{
			var p : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.y += value - p.y;
		}

		/**
		public function get scaleX() : Number
		{
			return _target.scaleX;
		}

		/** @private */
		public function set scaleX(value : Number) : void
		{
			_setProperty("scaleX", value);
		}

		/**
		public function get scaleY() : Number
		{
			return _target.scaleY;
		}

		/** @private */
		public function set scaleY(value : Number) : void
		{
			_setProperty("scaleY", value);
		}

		/**
		public function get rotation() : Number
		{
			return _target.rotation;
		}

		/** @private */
		public function set rotation(value : Number) : void
		{
			_setProperty("rotation", value);
		}

		/**
		public function get rotationX() : Number
		{
			return _target.rotationX;
		}

		/** @private */
		public function set rotationX(value : Number) : void
		{
			_setProperty("rotationX", value);
		}

		/**
		public function get rotationY() : Number
		{
			return _target.rotationY;
		}

		/** @private */
		public function set rotationY(value : Number) : void
		{
			_setProperty("rotationY", value);
		}

		/**
		public function get rotationZ() : Number
		{
			return _target.rotationZ;
		}

		/** @private */
		public function set rotationZ(value : Number) : void
		{
			_setProperty("rotationZ", value);
		}

		/**
		public function get mouseX() : Number
		{
			return Math.round(_target.mouseX - _reg.x);
		}

		/**
		public function get mouseY() : Number
		{
			return Math.round(_target.mouseY - _reg.y);
		}

		// --------------------------------------------------------------------
		// Public API
		// --------------------------------------------------------------------
		/**
		public function PXRegDisplayObject(target : DisplayObject)
		{
			if ( target != null )
			{
				registration = new Point(0, 0);
				_target = target;
			}
		}

		/**
		public function toString() : String
		{
			return PXStringifier.process(this) + "[" + _reg.x + "," + _reg.y + "]";
		}

		// --------------------------------------------------------------------
		// Private methods
		// --------------------------------------------------------------------
		/** @private */
		private function _setProperty(prop : String, value : Number) : void
		{
			var a : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target[prop] = value;
			var b : Point = _target.parent.globalToLocal(_target.localToGlobal(_reg));
			_target.x -= b.x - a.x;
			_target.y -= b.y - a.y;
		}
	}
}