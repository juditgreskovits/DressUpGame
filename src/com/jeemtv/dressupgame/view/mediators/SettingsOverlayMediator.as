/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.view.views.SettingsOverlayView;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class SettingsOverlayMediator extends AbstractOverlayMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SettingsOverlayMediator()
		{
			super(NavigationConstants.OVERLAY_SETTINGS);
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
			
			eventMap.mapListener(eventDispatcher, SoundEvent.UPDATE, onSoundUpdate);
			
			eventMap.mapListener(settingsOverlayView, SoundEvent.REQUEST_MUSIC_TOGGLE, dispatch);
			eventMap.mapListener(settingsOverlayView, SoundEvent.REQUEST_SOUND_TOGGLE, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, SoundEvent.UPDATE, onSoundUpdate);
			
			eventMap.unmapListener(settingsOverlayView, SoundEvent.REQUEST_MUSIC_TOGGLE, dispatch);
			eventMap.unmapListener(settingsOverlayView, SoundEvent.REQUEST_SOUND_TOGGLE, dispatch);
			
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
		
		private function onSoundUpdate(evt:SoundEvent):void
		{
			settingsOverlayView.updateMusic(evt.musicOn);
			settingsOverlayView.updateSound(evt.soundOn);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get settingsOverlayView():SettingsOverlayView
		{
			return abstractView as SettingsOverlayView; 
		}
		
	}
}