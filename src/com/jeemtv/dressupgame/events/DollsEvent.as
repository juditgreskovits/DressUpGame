/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.DollVO;

	import flash.events.Event;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	
	public class DollsEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const REQUEST_DOLL:String = "requestDoll";
		public static const REQUEST_PREVIOUS_DOLL:String = "requestPreviousDoll";
		public static const REQUEST_NEXT_DOLL:String = "requestNextDoll";
		public static const REQUEST_CATEGORY:String = "requestCategory";
		public static const REQUEST_PREVIOUS_CATEGORY:String = "requestPreviousCategory";
		public static const REQUEST_NEXT_CATEGORY:String = "requestNextCategory";
		public static const REQUEST_UPDATE_NAME:String = "requestUpdateName";
		public static const REQUEST_UPDATE_SKIN:String = "requestUpdateSkin";
		public static const REQUEST_ADD_CLOTH:String = "requestDollAddCloth";
		public static const REQUEST_REMOVE_CLOTH:String = "requestDollRemoveCloth";
		
		public static const DOLL:String = "doll";
		public static const CATEGORY:String = "category";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _id:uint;
		private var _doll:DollVO;
		private var _category:uint;
		private var _name:String;
		private var _skin:uint;
		private var _cloth:String; // this is the id - we'll look it up from model for setting
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function DollsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set id(value:uint):void { _id = value; }
		public function get id():uint { return _id; }
		
		public function set doll(value:DollVO):void { _doll = value; }
		public function get doll():DollVO { return _doll; }
		
		public function set category(value:uint):void { _category = value; }
		public function get category():uint { return _category; }
		
		public function set name(value:String):void { _name = value; }
		public function get name():String { return _name; }
		
		public function set skin(value:uint):void { _skin = value; }
		public function get skin():uint { return _skin; }
		
		public function set cloth(value:String):void { _cloth = value; }
		public function get cloth():String { return _cloth; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:DollsEvent = new DollsEvent (type, bubbles, cancelable);
			evt.id = _id;
			evt.doll = _doll;
			evt.category = _category;
			evt.name = _name;
			evt.skin = _skin;
			evt.cloth = _cloth;
			return evt;
		}
		
	}
	
}