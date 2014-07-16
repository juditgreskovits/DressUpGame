/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.view.views.utils.MovieClipBehaviour;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class TransitionView extends Sprite
	{
		// private static constants
		
		// private properties
		
		private var _asset:MovieClip;
		private var _transition:String;
		private var _soundId:String;
		
		private var _transitionBehaviour:MovieClipBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function TransitionView(asset:MovieClip, transition:String, soundId:String=null)
		{
			super();
			
			_asset = asset;
			_transition = transition;
			_soundId = soundId;
			
			setup();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get transition():String
		{
			return _transition;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function play():void
		{
			_transitionBehaviour.stop(NavigationConstants.TRANSITION_START);
			if(_soundId) dispatchEvent(EventFactory.requestPlaySoundEffect(_soundId));
			
			addChild(_asset);
			
			_transitionBehaviour.play();
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
		
		private function setup():void
		{
			_transitionBehaviour = new MovieClipBehaviour(_asset);
			_transitionBehaviour.addFunctionToLabel(NavigationConstants.DEACTIVATE_VIEW, onDeactivateView);
			_transitionBehaviour.addFunctionToLabel(NavigationConstants.ACTIVATE_VIEW, onActivateView);
			_transitionBehaviour.addFunctionToLabel(NavigationConstants.TRANSITION_END, onTransitionEnd);
		}
		
		private function onDeactivateView():void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.REQUEST_DEACTIVATE_ADDRESS));
		}
		
		private function onActivateView():void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.REQUEST_ACTIVATE_ADDRESS));
		}
		
		private function onTransitionEnd():void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.TRANSITION_COMPLETE));
			
			_transitionBehaviour.stop();
			
			removeChild(_asset);
		}
		
	}
}