/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class LocationsEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const PARSE_XML:String = "parseLocationsXML";
		public static const PARSE_UNLOCKED:String = "parseLocationsUnlocked";
		
		public static const REQUEST_LOCATION:String = "requestLocation";
		public static const REQUEST_LOCATIONS:String = "requestLocations";
		public static const REQUEST_PREVIOUS_LOCATIONS:String = "requestPreviousLocations";
		public static const REQUEST_NEXT_LOCATIONS:String = "requestNextLocations";
		
		public static const REQUEST_LOCATION_UNLOCK:String = "requestLocationsUnlock";
		
		public static const LOCATION:String = "location";
		public static const LOCATIONS:String = "locations";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _id:String;
		private var _location:LocationVO;
		private var _locations:Vector.<LocationVO>;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function LocationsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }
		
		public function set location(value:LocationVO):void { _location = value; }
		public function get location():LocationVO { return _location; }
		
		public function set locations(value:Vector.<LocationVO>):void { _locations = value; }
		public function get locations():Vector.<LocationVO> { return _locations; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:LocationsEvent = new LocationsEvent (type, bubbles, cancelable);
			evt.id = _id;
			// evt.index = _index;
			evt.location = _location;
			evt.locations = _locations;
			return evt;
		}
		
	}
	
}