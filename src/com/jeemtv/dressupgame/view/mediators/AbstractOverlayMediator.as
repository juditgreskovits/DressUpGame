/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.view.views.AbstractOverlayView;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractOverlayMediator extends AbstractMediator
	{
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _active:Boolean;
		
		// private properties
		
		private var _overlay:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractOverlayMediator(overlay:String)
		{
			super();
			
			_overlay = overlay;
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
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.OVERLAY, onOverlay);
			
			eventMap.mapListener(abstractOverlayView, NavigationEvent.REQUEST_OVERLAY, onOverlay);
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.MESSAGING, onMessaging);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, NavigationEvent.OVERLAY, dispatch);
			
			eventMap.unmapListener(abstractOverlayView, NavigationEvent.REQUEST_OVERLAY, dispatch);
			
			eventMap.unmapListener(eventDispatcher, NavigationEvent.MESSAGING, onMessaging);
			
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
		
		protected function onOverlay(evt:NavigationEvent):void
		{
			if(_overlay == evt.overlay)
			{
				_active = true;
				abstractOverlayView.activate();
			}
			else if(_active)
			{
				abstractOverlayView.deactivate();
				_active = false;
			}
		}
		
		protected function onMessaging(evt:NavigationEvent):void
		{
			if(evt.messaging) abstractView.enabled = false;
			else if(_active) abstractView.enabled = true;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get abstractOverlayView():AbstractOverlayView
		{
			return abstractView as AbstractOverlayView;
		}
		
	}
}
