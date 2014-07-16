/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class CustomClothesEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const REQUEST_CREATE:String = "requestCreate";
		public static const REQUEST_EDIT:String = "requestEdit";
		public static const REQUEST_COMPLETE:String = "requestComplete";
		
		public static const REQUEST_PATTERN_UPDATE:String = "requestPatternUpdate";
		public static const REQUEST_MATERIAL_UPDATE:String = "requestMaterialUpdate";
		public static const REQUEST_COLOUR_UPDATE:String = "requestColourUpdate";
		public static const REQUEST_STAMP_ADD:String = "requestStampUpdate";
		
		public static const REQUEST_UNDO:String = "requestUndo";
		public static const REQUEST_REDO:String = "requestRedo";
		public static const REQUEST_CLEAR:String = "requestClear";
		
		public static const UPDATE:String = "updateCustomCloth";
		public static const COMPLETE:String = "completeCustomCloth";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _pattern:PatternVO;
		private var _material:uint;
		private var _colour:uint;
		private var _stamp:StampVO;
		
		private var _id:String;
		private var _cloth:CustomClothVO;
		private var _hasPrevious:Boolean;
		private var _hasNext:Boolean;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function CustomClothesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set pattern(value:PatternVO):void { _pattern = value; }
		public function get pattern():PatternVO { return _pattern; }
		
		public function set material(value:uint):void { _material = value; }
		public function get material():uint { return _material; }
		
		public function set colour(value:uint):void { _colour = value; }
		public function get colour():uint { return _colour; }
		
		public function set stamp(value:StampVO):void { _stamp = value; }
		public function get stamp():StampVO { return _stamp; }
		
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }
		
		public function set cloth(value:CustomClothVO):void { _cloth = value; }
		public function get cloth():CustomClothVO { return _cloth; }
		
		public function set hasPrevious(value:Boolean):void { _hasPrevious = value; }
		public function get hasPrevious():Boolean { return _hasPrevious; }
		
		public function set hasNext(value:Boolean):void { _hasNext = value; }
		public function get hasNext():Boolean { return _hasNext; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:CustomClothesEvent = new CustomClothesEvent (type, bubbles, cancelable);
			evt.pattern = _pattern;
			evt.material = _material;
			evt.colour = _colour;
			evt.stamp = _stamp;
			evt.id = _id;
			evt.cloth = _cloth;
			evt.hasPrevious = _hasPrevious;
			evt.hasNext = _hasNext;
			return evt;
		}
	}
}