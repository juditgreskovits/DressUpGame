/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class MovieClipBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _asset:MovieClip;
		private var _functionDictionary:Dictionary;
		private var _argumentDictionary:Dictionary;
		private var _currentLabel:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function MovieClipBehaviour(asset:MovieClip)
		{
			super();
			
			_asset = asset;
			_currentLabel = _asset.currentLabel;
			
			stop();
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
		
		public function addFunctionToLabel(label:String, f:Function, a:Array=null):void
		{
			if(!_functionDictionary) _functionDictionary = new Dictionary();
			if(a && !_argumentDictionary) _argumentDictionary = new Dictionary();
			if(DisplayUtils.hasFrameLabel(_asset, label))
			{
				_functionDictionary[label] = f;
				if(a) _argumentDictionary[label] = a;
			}
		}
		
		public function play(label:*=null):void
		{
			if(label) _asset.gotoAndPlay(label);
			else _asset.play();
			_asset.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function stop(label:*=null):void
		{
			_asset.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if(label) _asset.gotoAndStop(label);
			else _asset.stop();
		}
		
		public function destroy():void
		{
			stop();
			
			_asset = null;
			_functionDictionary = null;
			_argumentDictionary = null;
			_currentLabel = null;
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
		
		private function onEnterFrame(evt:Event):void
		{
			if(_asset.currentLabel != _currentLabel)
			{
				_currentLabel = _asset.currentLabel;
				if(_functionDictionary && _functionDictionary[_currentLabel] != undefined)
				{
					if(_argumentDictionary && _argumentDictionary[_currentLabel] != undefined) _functionDictionary[_currentLabel].apply(null, _argumentDictionary[_currentLabel]);
					else _functionDictionary[_currentLabel]();
				}
			}
		}
		
	}
}