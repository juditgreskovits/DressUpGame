/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 30, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractPickerBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _pickerAsset:MovieClip;
		protected var _buttonAsset:MovieClip;
		
		protected var _open:Boolean;
		
		// private properties
		
		private var _button:ButtonBehaviour;
		
		private var _enabled:Boolean;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractPickerBehaviour(buttonAsset:MovieClip, pickerAsset:MovieClip, tabIndex:uint)
		{
			super();
			
			_buttonAsset = buttonAsset;
			_pickerAsset = pickerAsset;
			_pickerAsset.visible = false;
			
			_button = new ButtonBehaviour(_buttonAsset, tabIndex, onButtonClick);
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
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function destroy():void
		{
			enabled = false;
			
			_buttonAsset = null;
			_pickerAsset = null;
			_button = null;
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		protected function enable():void
		{
			_button.enabled = true;
		}
		
		protected function disable():void
		{
			_button.enabled = false;
		}
		
		protected function onButtonClick(evt:Event=null):void
		{
			if(_open)
			{
				_buttonAsset.visible = true;
				_pickerAsset.visible = false;
			}
			else
			{
				_buttonAsset.visible = false;
				_pickerAsset.visible = true;
			}
			_open = !_open;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
	}
}
