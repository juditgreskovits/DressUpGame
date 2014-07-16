/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import flash.events.Event;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.view.views.utils.MovieClipBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.DisplayUtils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractOverlayView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _transitionBehaviour:MovieClipBehaviour;
		
		// private properties
		
		private var _closeFunction:Function;
		private var _closeArguments:Array;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractOverlayView(asset:MovieClip=null)
		{
			super(asset);
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
			
			_transitionBehaviour = new MovieClipBehaviour(_asset);
			_transitionBehaviour.stop(NavigationConstants.TRANSITION_IN_START);
			_transitionBehaviour.addFunctionToLabel(NavigationConstants.TRANSITION_IN_END, onTransitionInEnd);
			_transitionBehaviour.addFunctionToLabel(NavigationConstants.TRANSITION_OUT_END, onTransitionOutEnd);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_transitionBehaviour.play(NavigationConstants.TRANSITION_IN_START);
		}
		
		override public function deactivate():void
		{
			enabled = false;
			_transitionBehaviour.play(NavigationConstants.TRANSITION_OUT_START);
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
		
		protected function onTransitionInEnd():void
		{
			enabled = true;
		}
		
		protected function onTransitionOutEnd():void
		{
			if(_closeFunction)
			{
				if(_closeArguments) _closeFunction.apply(null, _closeArguments);
				else _closeFunction();
				
				removeFunctionFromTransitionComplete();
			}
			
			super.deactivate();
		}
		
		protected function close(evt:Event=null):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.REQUEST_OVERLAY));
		}
		
		protected function addFunctionToTransitionComplete(f:Function, a:Array=null):void
		{
			_closeFunction = f;
			_closeArguments = a;
		}
		
		protected function removeFunctionFromTransitionComplete():void
		{
			_closeFunction = null;
			_closeArguments = null;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
	}
}