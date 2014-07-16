/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class StartView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _startButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function StartView()
		{
			super(new MainMenu_design());
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
			
			TLFTextFieldUtils.formatTLFTextField(startAsset.title, CopyData.getCopy(CopyConstants.START_TITLE), 23, false, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(startAsset.startBtn.label, CopyData.getCopy(CopyConstants.START_BUTTON_LABEL));
			
			_startButton = new ButtonBehaviour(startAsset.startBtn, 1, onStartButtonClick);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_startButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_startButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
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
		
		private function onStartButtonClick(evt:Event):void
		{
			var doll:uint;
			for each (doll in GlobalConstants.DOLLS)
			{
				dispatchEvent(EventFactory.requestDoll(doll));
			}
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_HOME, NavigationConstants.TRANSITION_START_TO_HOME));
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get startAsset():MainMenu_design
		{
			return _asset as MainMenu_design;
		}
	}
}