/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class SettingsOverlayView extends AbstractOverlayView
	{
		// private static constants
		
		private static const LABEL_SELECTED_OVER:String = "selected_over";
		private static const LABEL_SELECTED_DOWN:String = "selected_down";
		
		private static const LABEL_OUT_OVER:String = "out_over";
		private static const LABEL_OUT_DOWN:String = "out_down";
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _closeButton:ButtonBehaviour;
		private var _musicButton:ButtonBehaviour;
		private var _soundButton:ButtonBehaviour;
		private var _cancelButton:ButtonBehaviour;
		private var _resetButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SettingsOverlayView()
		{
			super(new Settings_design());
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
			
			// copy 2 labels 2 buttons
			
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.title, CopyData.getCopy(CopyConstants.SETTINGS_TITLE), 22);
			
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.button_music.label, CopyData.getCopy(CopyConstants.MUSIC_BUTTON_LABEL), 18, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.button_sound.label, CopyData.getCopy(CopyConstants.SOUND_BUTTON_LABEL), 18, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resumeBtn.label, CopyData.getCopy(CopyConstants.RESUME_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resetBtn.label, CopyData.getCopy(CopyConstants.RESET_BUTTON_LABEL), 14, true, GlobalConstants.COLOUR_PURPLE);
			
			// three buttons
			var tabIndex:uint = AccessibilityConstants.SETTINGS_TAB_INDEX;
			_musicButton = new ButtonBehaviour(settingsOverlayAsset.settings_dropdown.button_music, tabIndex++, onMusicButtonClick);
			_soundButton = new ButtonBehaviour(settingsOverlayAsset.settings_dropdown.button_sound, tabIndex++, onSoundButtonClick);
			_cancelButton = new ButtonBehaviour(settingsOverlayAsset.settings_dropdown.resumeBtn, tabIndex++, close);
			_resetButton = new ButtonBehaviour(settingsOverlayAsset.settings_dropdown.resetBtn, tabIndex++, onResetButtonClick);
			_closeButton = new ButtonBehaviour(settingsOverlayAsset.settings_dropdown.button_close, tabIndex++, close);
			
			_musicButton.overFunction = onMusicButtonOver;
			_musicButton.outFunction = onMusicButtonOut;
			_musicButton.downFunction = onMusicButtonDown;
			
			_soundButton.overFunction = onSoundButtonOver;
			_soundButton.outFunction = onSoundButtonOut;
			_soundButton.downFunction = onSoundButtonDown;
			
			_resetButton.overFunction = onResetButtonOver;
			_resetButton.outFunction = onResetButtonOut;
			_resetButton.downFunction = onResetButtonDown;
		}
		
		override public function activate():void
		{
			super.activate();
			
			_closeButton.enabled = true;
			_musicButton.enabled = true;
			_soundButton.enabled = true;
			_cancelButton.enabled = true;
			_resetButton.enabled = true;
			
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resetBtn.label, CopyData.getCopy(CopyConstants.RESET_BUTTON_LABEL), 14, true, GlobalConstants.COLOUR_PURPLE);
		}
		
		override public function deactivate():void
		{
			_closeButton.enabled = false;
			_musicButton.enabled = false;
			_soundButton.enabled = false;
			_cancelButton.enabled = false;
			_resetButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateMusic(on:Boolean):void
		{
			_musicButton.selected = on;
			onMusicButtonOut();
		}
		
		public function updateSound(on:Boolean):void
		{
			_soundButton.selected = on;
			onSoundButtonOut();
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
		
		private function onMusicButtonClick(evt:Event):void
		{
			dispatchEvent(new SoundEvent(SoundEvent.REQUEST_MUSIC_TOGGLE));
		}
		
		private function onSoundButtonClick(evt:Event):void
		{
			dispatchEvent(new SoundEvent(SoundEvent.REQUEST_SOUND_TOGGLE));
		}
		
		private function onResetButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestMessaging(NavigationConstants.MESSAGING_WARNING));
		}
		
		// button over
		
		private function onMusicButtonOver(evt:Event):void
		{
			if(_musicButton.selected) settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(LABEL_SELECTED_OVER);
			else settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(LABEL_OUT_OVER);
		}
		
		private function onMusicButtonOut(evt:Event=null):void
		{
			if(_musicButton.selected) settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(ButtonBehaviour.SELECTED);
			else settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(ButtonBehaviour.OUT);
		}
		
		private function onMusicButtonDown(evt:Event):void
		{
			if(_musicButton.selected) settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(LABEL_SELECTED_DOWN);
			else settingsOverlayAsset.settings_dropdown.button_music.gotoAndStop(LABEL_OUT_DOWN);
		}
		
		private function onSoundButtonOver(evt:Event):void
		{
			if(_soundButton.selected) settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(LABEL_SELECTED_OVER);
			else settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(LABEL_OUT_OVER);
		}
		
		private function onSoundButtonOut(evt:Event=null):void
		{
			if(_soundButton.selected) settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(ButtonBehaviour.SELECTED);
			else settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(ButtonBehaviour.OUT);
		}
		
		private function onSoundButtonDown(evt:Event):void
		{
			if(_soundButton.selected) settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(LABEL_SELECTED_DOWN);
			else settingsOverlayAsset.settings_dropdown.button_sound.gotoAndStop(LABEL_OUT_DOWN);
		}
		
		private function onResetButtonOver(evt:Event):void
		{
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resetBtn.label, CopyData.getCopy(CopyConstants.RESET_BUTTON_LABEL), 14, true, GlobalConstants.COLOUR_BRIGHT_PURPLE);
		}
		
		private function onResetButtonOut(evt:Event):void
		{
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resetBtn.label, CopyData.getCopy(CopyConstants.RESET_BUTTON_LABEL), 14, true, GlobalConstants.COLOUR_PURPLE);
		}
		
		private function onResetButtonDown(evt:Event):void
		{
			TLFTextFieldUtils.formatTLFTextField(settingsOverlayAsset.settings_dropdown.resetBtn.label, CopyData.getCopy(CopyConstants.RESET_BUTTON_LABEL), 14, true, GlobalConstants.COLOUR_PURPLE);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get settingsOverlayAsset():Settings_design
		{
			return _asset as Settings_design;
		}
		
	}
}