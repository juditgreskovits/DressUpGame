/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.view.views.AbstractView;

	import org.robotlegs.mvcs.Mediator;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractMediator extends Mediator
	{
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var abstractView:AbstractView;
		
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractMediator()
		{
			super();
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
			
			eventMap.mapListener(abstractView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			abstractView.addEventListener(NavigationEvent.REQUEST_ADDRESS, dispatch);
			// eventMap.mapListener(abstractView, NavigationEvent.REQUEST_ADDRESS, dispatch);
			eventMap.mapListener(abstractView, NavigationEvent.REQUEST_OVERLAY, dispatch);
			eventMap.mapListener(abstractView, NavigationEvent.REQUEST_MESSAGING, dispatch);
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.TRANSITION, onTransition);
			
			eventMap.mapListener(eventDispatcher, StorageServiceEvent.RESTORE, onRestore);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(abstractView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			abstractView.removeEventListener(NavigationEvent.REQUEST_ADDRESS, dispatch);
			// eventMap.unmapListener(abstractView, NavigationEvent.REQUEST_ADDRESS, dispatch);
			eventMap.unmapListener(abstractView, NavigationEvent.REQUEST_OVERLAY, dispatch);
			eventMap.unmapListener(abstractView, NavigationEvent.REQUEST_MESSAGING, dispatch);
			
			eventMap.unmapListener(eventDispatcher, NavigationEvent.TRANSITION, onTransition);
			
			eventMap.unmapListener(eventDispatcher, StorageServiceEvent.RESTORE, onRestore);
			
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
		
		protected function onRestore(evt:StorageServiceEvent):void
		{
			abstractView.create();
		}
		
		protected function onTransition(evt:NavigationEvent):void
		{
			abstractView.enabled = false;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
	}
}