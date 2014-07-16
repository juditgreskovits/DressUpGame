/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.view.views.MenuView;

	import org.robotlegs.mvcs.Mediator;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class MenuMediator extends Mediator
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var menuView:MenuView;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function MenuMediator()
		{
			super();
		}
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener(eventDispatcher, SoundEvent.UPDATE, onSoundUpdate);
			
			eventMap.mapListener(eventDispatcher, NavigationEvent.OVERLAY, onOverlay);
			// eventMap.mapListener(eventDispatcher, NavigationEvent.MESSAGING, onOverlay);
			
			eventMap.mapListener(menuView, SoundEvent.REQUEST_TOGGLE, dispatch);
			eventMap.mapListener(menuView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			eventMap.mapListener(menuView, NavigationEvent.REQUEST_OVERLAY, dispatch);
			
			eventMap.mapListener(eventDispatcher, StorageServiceEvent.RESTORE, onRestore);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, SoundEvent.UPDATE, onSoundUpdate);
			
			eventMap.unmapListener(eventDispatcher, NavigationEvent.OVERLAY, onOverlay);
			// eventMap.unmapListener(eventDispatcher, NavigationEvent.MESSAGING, onOverlay);
			
			eventMap.unmapListener(menuView, SoundEvent.REQUEST_TOGGLE, dispatch);
			eventMap.unmapListener(menuView, SoundEvent.REQUEST_PLAY_SOUND, dispatch);
			
			eventMap.unmapListener(menuView, NavigationEvent.REQUEST_OVERLAY, dispatch);
			
			eventMap.unmapListener(eventDispatcher, StorageServiceEvent.RESTORE, onRestore);
			
			super.onRemove();
		}	
		
		//------------------------------------------------------------------------
		//  PUBLIC METHODS
		//------------------------------------------------------------------------
		
		//------------------------------------------------------------------------
		//  PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		protected function onRestore(evt:StorageServiceEvent):void
		{
			menuView.create();
			menuView.activate();
			menuView.enabled = true;
		}
		
		private function onSoundUpdate(evt:SoundEvent):void
		{
			menuView.updateSound(evt.musicOn || evt.soundOn);
		}
		
		protected function onOverlay(evt:NavigationEvent):void
		{
			menuView.enabled = !evt.overlay && !evt.messaging;
		}
	}
	
}