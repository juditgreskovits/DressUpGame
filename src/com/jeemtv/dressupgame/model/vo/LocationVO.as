/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class LocationVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:String;
		private var _name:String;
		private var _assetClassName:String;
		private var _unlocked:Boolean;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function LocationVO(id:String)
		{
			super();
			
			_id = id;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get id():String { return _id; }
		
		public function set name(value:String):void { _name = value; }
		public function get name():String { return _name; }
		
		public function set assetClassName(value:String):void { _assetClassName = value; }
		public function get assetClassName():String { return _assetClassName; }
		
		public function set unlocked(value:Boolean):void { _unlocked = value; }
		public function get unlocked():Boolean { return _unlocked; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getAsset():Sprite
		{
			var locationClass:Class = getDefinitionByName(_assetClassName) as Class;
			return new locationClass() as Sprite;
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