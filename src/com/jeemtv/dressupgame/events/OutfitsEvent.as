/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.OutfitVO;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class OutfitsEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const PARSE_XML:String = "parseOutfitsXML";
		
		public static const REQUEST_OUTFIT_UNLOCK:String = "requestOutfitUnlock";
		public static const OUTFIT_UNLOCKED:String = "outfitUnlocked";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _id:String;
		private var _outfit:OutfitVO;
		private var _location:LocationVO;
		
		private var _outfits:Vector.<OutfitVO>;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function OutfitsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------
		
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }	
		
		public function set outfit(value:OutfitVO):void { _outfit = value; }
		public function get outfit():OutfitVO { return _outfit; }
		
		public function set location(value:LocationVO):void { _location = value; }
		public function get location():LocationVO { return _location; }
		
		public function set outfits(value:Vector.<OutfitVO>):void { _outfits = value; }
		public function get outfits():Vector.<OutfitVO> { return _outfits; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:OutfitsEvent = new OutfitsEvent (type, bubbles, cancelable);
			evt.id = _id;
			evt.outfit = _outfit;
			evt.location = _location;
			evt.outfits = _outfits;
			return evt;
		}
		
	}
	
}