/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	// import fl.text.TLFTextField;

	
	public class ButtonBehaviour extends EventDispatcher
	{
		// public static constants
		
		public static const OVER:String = "over";
		public static const OUT:String = "out";
		public static const DOWN:String = "down";
		public static const DISABLED:String = "disabled";
		public static const SELECTED:String = "selected";
		
		public static const LABEL:String = "label";
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _asset:MovieClip;
		private var _enabled:Boolean;
		private var _selected:Boolean;
		
		private var _clickFunction:Function;
		private var _overFunction:Function;
		private var _outFunction:Function;
		private var _downFunction:Function;
		
		private var _clickSoundEvent:SoundEvent;
		private var _overSoundEvent:SoundEvent;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		// asset, click, over(op), out(op), overSound(op), clickSound(op), copy(op), tabIndex
		public function ButtonBehaviour(asset:MovieClip, tabIndex:int, clickFunction:Function, clickSoundId:String=null, overSoundId:String=null)
		{
			super();
			
			_asset = asset;
			_clickFunction = clickFunction;
			
			setup(tabIndex, clickSoundId, overSoundId);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				if(_enabled) enable();
				else disable();
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				if(_selected && DisplayUtils.hasFrameLabel(_asset, SELECTED)) _asset.gotoAndStop(SELECTED);
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set overFunction(value:Function):void
		{
			_overFunction = value;
		}
		
		public function set outFunction(value:Function):void
		{
			_outFunction = value;
		}
		
		public function set downFunction(value:Function):void
		{
			_downFunction = value;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function destroy():void
		{
			_enabled = false;
			
			_asset = null;
			
			_clickFunction = null;
			_overFunction = null;
			_outFunction = null;
			_downFunction = null;
			
			_clickSoundEvent = null;
			_overSoundEvent = null;
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
		
		private function setup(tabIndex:int, clickSoundId:String, overSoundId:String):void
		{
			_asset.tabIndex = tabIndex;
			_asset.mouseChildren = false;
			
			if(!clickSoundId) clickSoundId = SoundConstants.CLICK;
			_clickSoundEvent = EventFactory.requestPlaySoundEffect(clickSoundId, true);
			if(overSoundId) _overSoundEvent = EventFactory.requestPlaySoundEffect(overSoundId, true);
			
			disable();
		}
		
		private function enable():void
		{
			_asset.buttonMode = true;
			_asset.tabEnabled = true;
			_asset.addEventListener(MouseEvent.CLICK, buttonClick);
			_asset.addEventListener(MouseEvent.ROLL_OVER, buttonOver);
			_asset.addEventListener(FocusEvent.FOCUS_IN, buttonOver);
			_asset.addEventListener(MouseEvent.ROLL_OUT, buttonOut);
			_asset.addEventListener(FocusEvent.FOCUS_OUT, buttonOut);
			_asset.addEventListener(MouseEvent.MOUSE_DOWN, buttonDown );
			if(_selected && DisplayUtils.hasFrameLabel(_asset, SELECTED)) _asset.gotoAndStop(SELECTED);
			else if(DisplayUtils.hasFrameLabel(_asset, OUT)) _asset.gotoAndStop(OUT);
			else _asset.gotoAndStop(1);
		}
		
		private function disable():void
		{
			if(_asset)
			{
				_asset.buttonMode = false;
				_asset.tabEnabled = false;
				_asset.removeEventListener(MouseEvent.CLICK, buttonClick);
				_asset.removeEventListener(MouseEvent.ROLL_OVER, buttonOver);
				_asset.removeEventListener(FocusEvent.FOCUS_IN, buttonOver);
				_asset.removeEventListener(MouseEvent.ROLL_OUT, buttonOut);
				_asset.removeEventListener(FocusEvent.FOCUS_OUT, buttonOut);
				_asset.removeEventListener(MouseEvent.MOUSE_DOWN, buttonDown);
				if(DisplayUtils.hasFrameLabel(_asset, DISABLED)) _asset.gotoAndStop(DISABLED);
				else if(_selected && DisplayUtils.hasFrameLabel(_asset, SELECTED)) _asset.gotoAndStop(SELECTED);
				else if(DisplayUtils.hasFrameLabel(_asset, OUT)) _asset.gotoAndStop(OUT);
				else _asset.gotoAndStop(1);
			}
		}
		
		private function buttonOut(evt:Event=null):void
		{
			if(!_selected) 
			{
				_asset.addEventListener(MouseEvent.ROLL_OVER, buttonOver);
				_asset.addEventListener(FocusEvent.FOCUS_IN, buttonOver);
				if(_selected && DisplayUtils.hasFrameLabel(_asset, SELECTED)) _asset.gotoAndStop(SELECTED);
				else if(DisplayUtils.hasFrameLabel(_asset, OUT)) _asset.gotoAndStop(OUT);
				else _asset.gotoAndStop(1);
				if(_outFunction) _outFunction(evt);
			}
		}
		
		private function buttonOver(evt:Event=null):void
		{
			if(!_selected) 
			{
				_asset.removeEventListener(MouseEvent.ROLL_OVER, buttonOver);
				_asset.removeEventListener(FocusEvent.FOCUS_IN, buttonOver);
				if(DisplayUtils.hasFrameLabel(_asset, OVER)) _asset.gotoAndStop(OVER);
				if(_overSoundEvent) _asset.dispatchEvent(_overSoundEvent);
				if(_overFunction != null) _overFunction(evt);
			}
		}
		
		private function buttonDown(evt:Event=null):void
		{
			if(DisplayUtils.hasFrameLabel(_asset, DOWN)) _asset.gotoAndStop(DOWN);
			if(_downFunction) _downFunction(evt);
		}
		
		private function buttonClick(evt:MouseEvent):void
		{
			if(_clickSoundEvent) _asset.dispatchEvent(_clickSoundEvent);
			_clickFunction(evt);
		}
	}
}