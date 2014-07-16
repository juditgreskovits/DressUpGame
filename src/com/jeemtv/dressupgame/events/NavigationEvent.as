/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.events
{
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class NavigationEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const REQUEST_ADDRESS:String = "requestNavigationAddress";
		public static const REQUEST_OVERLAY:String = "requestNavigationOverlay";
		public static const REQUEST_MESSAGING:String = "requestNavigationMessaging";
		
		public static const TRANSITION:String = "transition";
		public static const REQUEST_DEACTIVATE_ADDRESS:String = "requestDeactivateAddress";
		public static const REQUEST_ACTIVATE_ADDRESS:String = "requestActivateAddress";
		public static const TRANSITION_DEACTIVATE_ADDRESS:String = "deactivateAddress";
		public static const TRANSITION_ACTIVATE_ADDRESS:String = "activateAddress";
		public static const TRANSITION_COMPLETE:String = "transitionComplete";
		
		public static const OVERLAY:String = "overlay";
		public static const MESSAGING:String = "messaging";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _address:String;
		private var _transition:String; // default this to the curtain
		private var _overlay:String;
		private var _messaging:String;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set address(value:String):void { _address = value; }
		public function get address():String { return _address; }
		
		public function set overlay(value:String):void { _overlay = value; }
		public function get overlay():String { return _overlay; }
		
		public function set messaging(value:String):void { _messaging = value; }
		public function get messaging():String { return _messaging; }
		
		public function set transition(value:String):void { _transition = value; }
		public function get transition():String { return _transition; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:NavigationEvent = new NavigationEvent (type, bubbles, cancelable);
			evt.address = _address;
			evt.overlay = _overlay;
			evt.messaging = _messaging;
			evt.transition = _transition;
			return evt;
		}
		
	}
	
}