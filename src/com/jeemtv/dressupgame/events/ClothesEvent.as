/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;

	import flash.events.Event;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	
	public class ClothesEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const PARSE_XML:String = "parseClothesXML";
		
		public static const REQUEST_CLOTH:String = "requestCloth";
		public static const REQUEST_CLOTHES:String = "requestClothes";
		
		public static const CLOTH:String = "cloth";
		public static const CLOTHES:String = "clothes";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _id:String;
		private var _cloth:AbstractClothVO;
		private var _clothes:Vector.<AbstractClothVO>;
		private var _category:uint;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function ClothesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------
		
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }
		
		public function set cloth(value:AbstractClothVO):void { _cloth = value; }
		public function get cloth():AbstractClothVO { return _cloth; }
		
		public function set clothes(value:Vector.<AbstractClothVO>):void { _clothes = value; }
		public function get clothes():Vector.<AbstractClothVO> { return _clothes; }
		
		public function set category(value:uint):void { _category = value; }
		public function get category():uint { return _category; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:ClothesEvent = new ClothesEvent (type, bubbles, cancelable);
			evt.id = _id;
			evt.cloth = _cloth;
			evt.clothes = _clothes;
			evt.category = _category;
			return evt;
		}
		
	}
	
}