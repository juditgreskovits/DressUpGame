/**
 * @author juditgreskovits
 * @version 0.1
 * @since Oct 3, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import com.google.analytics.GATracker;

	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class TrackingService extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _tracker:GATracker;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function TrackingService()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		/*public function create(display:DisplayObject, account:String):void
		{
			_tracker = new GATracker(display, account, "AS3", true);
		}*/
		
		public function create(tracker:GATracker):void
		{
			_tracker = tracker;
		}
		
		public function trackEvent(category:String, action:String, label:String, value:Number):void
		{
			action = category + TrackingConstants.SEPARATOR + action;
			_tracker.trackEvent(TrackingConstants.CATEGORY_GAME, action, label, value);
		}
		
		public function trackPageView(pageURL:String):void
		{
			_tracker.trackPageview(pageURL);
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