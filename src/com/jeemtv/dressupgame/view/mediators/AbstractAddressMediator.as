/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.NavigationEvent;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractAddressMediator extends AbstractMediator
	{
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _active:Boolean;
		
		// private properties
		
		private var _address:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractAddressMediator(address:String)
		{
			super();
			
			_address = address;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// needs to know of transition start - disable active view
			// needs to know of transition "middle" - deactivate active view
			// needs to knoe of transition "middle" - activate new view
			// needs to know of transition end - enable view
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.TRANSITION_DEACTIVATE_ADDRESS, onDeactivateAddress);
			eventMap.mapListener(eventDispatcher, NavigationEvent.TRANSITION_ACTIVATE_ADDRESS, onActivateAddress);
			eventMap.mapListener(eventDispatcher, NavigationEvent.TRANSITION_COMPLETE, onTransitionComplete);
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.OVERLAY, onOverlay);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, NavigationEvent.TRANSITION_DEACTIVATE_ADDRESS, onDeactivateAddress);
			eventMap.unmapListener(eventDispatcher, NavigationEvent.TRANSITION_ACTIVATE_ADDRESS, onActivateAddress);
			eventMap.unmapListener(eventDispatcher, NavigationEvent.TRANSITION_COMPLETE, onTransitionComplete);
			
			eventMap.unmapListener(eventDispatcher, NavigationEvent.OVERLAY, onOverlay);
			
			super.onRemove();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onDeactivateAddress(evt:NavigationEvent):void
		{
			if(_active)
			{
				abstractView.deactivate();
				_active = false;
			}
		}
		
		private function onActivateAddress(evt:NavigationEvent):void
		{
			if(evt.address == _address)
			{
				_active = true;
				abstractView.activate();
			}
		}
		
		private function onTransitionComplete(evt:NavigationEvent):void
		{
			if(_active) abstractView.enabled = true;
		}
		
		protected function onOverlay(evt:NavigationEvent):void
		{
			if(evt.overlay) abstractView.enabled = false;
			else if(_active) abstractView.enabled = true;
		}
	}
}