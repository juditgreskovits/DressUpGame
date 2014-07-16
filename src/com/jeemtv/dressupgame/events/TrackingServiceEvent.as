/**
 * @author juditgreskovits
 * @version 0.1
 * @since Oct 3, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.google.analytics.GATracker;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class TrackingServiceEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const CREATE:String = "createTracking";
		public static const TRACK_PAGEVIEW:String = "trackPageview";
		public static const TRACK_EVENT:String = "trackEvent";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _tracker:GATracker;
		
		private var _account:String;
		
		private var _pageURL:String;
		
		private var _category:String;
		private var _action:String;
		private var _label:String;
		private var _value:Number;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function TrackingServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set tracker(value:GATracker):void { _tracker = value; }
		public function get tracker():GATracker { return _tracker; }
		
		public function set account(value:String):void { _account = value; }
		public function get account():String { return _account; }
		
		public function set pageURL(value:String):void { _pageURL = value; }
		public function get pageURL():String { return _pageURL; }
		
		public function set category(value:String):void { _category = value; }
		public function get category():String { return _category; }
		
		public function set action(value:String):void { _action = value; }
		public function get action():String { return _action; }
		
		public function set label(value:String):void { _label = value; }
		public function get label():String { return _label; }
		
		public function set value(value:Number):void { _value = value; }
		public function get value():Number { return _value; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:TrackingServiceEvent = new TrackingServiceEvent (type, bubbles, cancelable);
			evt.tracker = _tracker;
			evt.account = _account;
			evt.pageURL = _pageURL;
			evt.category = _category;
			evt.action = _action;
			evt.label = _label;
			evt.value = _value;
			return evt;
		}
		
	}
	
}