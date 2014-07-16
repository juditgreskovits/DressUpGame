/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.SoundEvent;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.view.views.TransitionView;

	import org.robotlegs.mvcs.Mediator;

	public class TransitionMediator extends Mediator
	{
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var transitionView:TransitionView;
		
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function TransitionMediator()
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
			
			// needs to know of transition start - start active transition
			// needs to notify of transition "middle" deactivate active view
			// needs to notify of transition "middle" activate new view
			// needs to notify of end of transition
			
			eventMap.mapListener(transitionView, NavigationEvent.REQUEST_DEACTIVATE_ADDRESS, dispatch);
			eventMap.mapListener(transitionView, NavigationEvent.REQUEST_ACTIVATE_ADDRESS, dispatch);
			eventMap.mapListener(transitionView, NavigationEvent.TRANSITION_COMPLETE, dispatch);
			
			eventMap.mapListener(transitionView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.TRANSITION, onTransition);
		}
		
		override public function onRemove():void
		{	
			eventMap.unmapListener(transitionView, NavigationEvent.REQUEST_DEACTIVATE_ADDRESS, dispatch);
			eventMap.unmapListener(transitionView, NavigationEvent.REQUEST_ACTIVATE_ADDRESS, dispatch);
			eventMap.unmapListener(transitionView, NavigationEvent.TRANSITION_COMPLETE, dispatch);
			
			eventMap.unmapListener(transitionView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			eventMap.unmapListener(eventDispatcher, NavigationEvent.TRANSITION, onTransition);
			
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
		
		private function onTransition(evt:NavigationEvent):void
		{
			if(evt.transition == transitionView.transition)
			{
				transitionView.play();
			}
		}
		
	}
}