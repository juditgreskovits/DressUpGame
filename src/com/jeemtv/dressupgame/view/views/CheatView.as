/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.net.SharedObject;
	import flash.events.Event;
	import flash.display.Sprite;
	import com.liamwalsh.utils.gameStuff.CheatCodeCreator;
	import com.jeemtv.dressupgame.view.mediators.CheatMediator;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CheatView extends Sprite
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _cheatMediator:CheatMediator;
		private var _cheatCodeCreator:CheatCodeCreator;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CheatView()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function create(cheatMediator:CheatMediator):void
		{
			_cheatMediator = cheatMediator;
			
			_cheatCodeCreator = new CheatCodeCreator(stage);
			_cheatCodeCreator.addCheatCode("clear", "clear", onClear);
			_cheatCodeCreator.addCheatCode("unlock", "unlock", onUnlock);
			_cheatCodeCreator.addCheatCode("settings", "settings", onSettings);
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
		
		private function onClear(evt:Event):void
		{
			SharedObject.getLocal(GlobalConstants.SHARED_OBJECT_NAME).clear();
		}
		
		private function onUnlock(evt:Event):void
		{
			// trace("CheatView.onUnlock");
		}
		
		private function onSettings(evt:Event):void
		{
			_cheatMediator.dispatchCheat(EventFactory.requestOverlay(NavigationConstants.OVERLAY_SETTINGS));
		}
		
	}
}