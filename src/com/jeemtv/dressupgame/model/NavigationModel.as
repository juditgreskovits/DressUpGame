/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class NavigationModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _address:String;
		private var _overlay:String;
		private var _messaging:String;
		
		private var _requestAddress:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function NavigationModel()
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
		
		public function requestAddress(address:String, transition:String):void
		{
			if(_address != address && _requestAddress != address)
			{
				// disable current address
				// create appropriate transition 
				// transition should tell navigation when to remove previous view
				// transition should tell navigation when to create new view
				// transition should tell when it's complete
				// enable new view at this point
				_requestAddress = address;
				
				var transitionEvent:NavigationEvent = new NavigationEvent(NavigationEvent.TRANSITION);
				transitionEvent.address = _requestAddress;
				transitionEvent.transition = transition;
				dispatch(transitionEvent);
			}
		}
		
		public function requestDeactivateAddress():void
		{
			var transitionEvent:NavigationEvent = new NavigationEvent(NavigationEvent.TRANSITION_DEACTIVATE_ADDRESS);
			transitionEvent.address = _address;
			dispatch(transitionEvent);
			
			_address = null;
		}
		
		public function requestActivateAddress():void
		{
			_address = _requestAddress;
			_requestAddress = null;
			
			var transitionEvent:NavigationEvent = new NavigationEvent(NavigationEvent.TRANSITION_ACTIVATE_ADDRESS);
			transitionEvent.address = _address;
			dispatch(transitionEvent);
		}
		
		public function requestOverlay(overlay:String):void
		{
			if(overlay != _overlay)
			{
				_overlay = overlay;
				
				var overlayEvent:NavigationEvent = new NavigationEvent(NavigationEvent.OVERLAY);
				overlayEvent.overlay = _overlay;
				dispatch(overlayEvent);
			}
		}
		
		// with messaging we might want to be able to add ability to execute different things depending when / where they appear
		public function requestMessaging(messaging:String):void
		{
			if(messaging != _messaging)
			{
				_messaging = messaging;
				
				var messagingEvent:NavigationEvent = new NavigationEvent(NavigationEvent.MESSAGING);
				messagingEvent.messaging = _messaging;
				dispatch(messagingEvent);
			}
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