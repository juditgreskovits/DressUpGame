/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;

	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class MenuView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _soundButton:ButtonBehaviour;
		private var _settingsButton:ButtonBehaviour;
		private var _helpButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function MenuView()
		{
			super(new Menu_design());
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function create():void
		{
			super.create();
			
			var tabIndex:uint = AccessibilityConstants.MENU_TAB_INDEX;
			_soundButton = new ButtonBehaviour(menuAsset.sound, tabIndex++, onSoundButtonClick, SoundConstants.CLICK);
			_settingsButton = new ButtonBehaviour(menuAsset.settings, tabIndex++, onSettingsButtonClick, SoundConstants.CLICK);
			_helpButton = new ButtonBehaviour(menuAsset.help, tabIndex, onHelpButtonClick, SoundConstants.CLICK);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_soundButton.enabled = true;
			_settingsButton.enabled = true;
			_helpButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_soundButton.enabled = false;
			_settingsButton.enabled = false;
			_helpButton.enabled = true;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateSound(on:Boolean):void
		{
			_soundButton.selected = on;
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
		
		private function onSoundButtonClick(evt:Event):void
		{
			dispatchEvent(new SoundEvent(SoundEvent.REQUEST_TOGGLE));
		}
		
		private function onSettingsButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestOverlay(NavigationConstants.OVERLAY_SETTINGS));
		}
		
		private function onHelpButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestOverlay(NavigationConstants.OVERLAY_HELP));
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get menuAsset():Menu_design
		{
			return _asset as Menu_design;
		}
	}
}