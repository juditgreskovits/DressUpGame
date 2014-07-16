/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.geom.Point;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class StampVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:uint;
		private var _colour:uint;
		private var _position:Point;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function StampVO(id:uint)
		{
			super();
			
			_id = id;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set id(value:uint):void { _id = value; }
		public function get id():uint { return _id; }
		
		public function set colour(value:uint):void { _colour = value; }
		public function get colour():uint { return _colour; }
		
		public function set position(value:Point):void { _position = value; }
		public function get position():Point { return _position; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function clone():StampVO
		{
			var vo:StampVO = new StampVO(_id);
			vo.colour = _colour;
			if(_position) vo.position = _position.clone();
			return vo;
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
	}
}