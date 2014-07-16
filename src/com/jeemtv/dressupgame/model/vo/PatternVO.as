/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PatternVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:String;
		private var _doll:uint;
		private var _category:uint;
		private var _assetClassName:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PatternVO(id:String)
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
		
		public function set assetClassName(value:String):void { _assetClassName = value; }
		public function get assetClassName():String { return _assetClassName; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
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