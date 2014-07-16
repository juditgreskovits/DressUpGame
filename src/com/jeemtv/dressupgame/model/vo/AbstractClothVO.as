/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractClothVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:String;
		private var _doll:uint;
		private var _category:uint;
		private var _topBottom:Boolean;
		private var _unlocked:Boolean;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractClothVO(id:String)
		{
			super();
			
			_id = id;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get id():String { return _id; }
		
		public function set doll(value:uint):void { _doll = value; }
		public function get doll():uint { return _doll; }
		
		public function set category(value:uint):void { _category = value; }
		public function get category():uint { return _category; }
		
		public function set topBottom(value:Boolean):void { _topBottom = value; }
		public function get topBottom():Boolean { return _topBottom; }
		
		public function set unlocked(value:Boolean):void { _unlocked = value; }
		public function get unlocked():Boolean { return _unlocked; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getAssetOnHanger():Sprite
		{
			return null;
		}
		
		public function getAssetOnDoll():Sprite
		{
			return null;
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