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
	
	public class AbstractMessagingMediator extends AbstractMediator
	{
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _messaging:String;
		private var _active:Boolean;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractMessagingMediator(messaging:String)
		{
			super();
			
			_messaging = messaging;
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
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.MESSAGING, onMessaging);
			
			eventMap.mapListener(abstractMessagingView, NavigationEvent.REQUEST_MESSAGING, onMessaging);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, NavigationEvent.MESSAGING, dispatch);
			
			eventMap.unmapListener(abstractMessagingView, NavigationEvent.REQUEST_MESSAGING, dispatch);
			
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
		
		protected function onMessaging(evt:NavigationEvent):void
		{
			if(_messaging == evt.messaging)
			{
				_active = true;
				abstractMessagingView.activate();
			}
			else if(_active)
			{
				abstractMessagingView.deactivate();
				_active = false;
			}
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get abstractMessagingView():AbstractOverlayView
		{
			return abstractView as AbstractOverlayView;
		}
		
	}
}
