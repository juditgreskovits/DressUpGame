/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 30, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class StampPickerBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _pickerAsset:MovieClip;
		private var _buttonAsset:MovieClip;
		private var _buttonName:String;
		private var _stampName:String;
		
		private var _stampPickFunction:Function;
		
		private var _enabled:Boolean;
		
		private var _buttons:Vector.<ButtonBehaviour>;
		private var _selectedButton:ButtonBehaviour;
		
		private var _colourTransform:ColorTransform;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function StampPickerBehaviour(pickerAsset:MovieClip, buttonAsset:MovieClip, buttonName:String, stampName:String, stampPickFunction:Function, tabIndex:uint)
		{
			super();
			
			_pickerAsset = pickerAsset;
			_buttonAsset = buttonAsset;
			_buttonName = buttonName;
			_stampName = stampName;
			_stampPickFunction = stampPickFunction;
			
			createButtons(tabIndex);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				if(_enabled) enableButtons(true);
				else enableButtons(false);
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
		
		public function updateMaterial(material:uint):void
		{
			_buttonAsset.material.gotoAndStop(material);
		}
		
		public function updateColour(colour:uint):void
		{
			if(!_colourTransform) _colourTransform = new ColorTransform();
			_colourTransform.color = colour;
			_buttonAsset.colour.transform.colorTransform = _colourTransform;
		}
		
		public function updateStamp(stamp:uint):void
		{
			_buttonAsset.stamp.gotoAndStop(stamp);
		}
		
		public function colourStamp(colour:uint):void
		{
			var colourTransform:ColorTransform = new ColorTransform();
			colourTransform.color = colour;
			_buttonAsset.stamp.transform.colorTransform = colourTransform;
		}
		
		public function destroy():void
		{
			_buttonName = null;
			_stampPickFunction = null;
			
			var button:ButtonBehaviour;
			for each(button in _buttons)
			{
				button.destroy();
			}
			
			_buttons = null;
			_selectedButton = null;
			
			_pickerAsset = null;
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
		
		private function createButtons(tabIndex:uint):void
		{
			_buttons = new Vector.<ButtonBehaviour>();
			var buttonAsset:MovieClip, i:uint;
			while(buttonAsset = _pickerAsset[_buttonName + ++i])
			{
				buttonAsset.stamp.gotoAndStop(i);
				_buttons.push(new ButtonBehaviour(buttonAsset, tabIndex++, onMaterialButtonClick));
			}
		}
		
		private function enableButtons(e:Boolean):void
		{
			var button:ButtonBehaviour;
			for each(button in _buttons)
			{
				button.enabled = e;
			}
		}
		
		private function onMaterialButtonClick(evt:Event):void
		{
			var buttonName:String = (evt.currentTarget as Sprite).name;
			var id:uint = uint(buttonName.substring(_buttonName.length, buttonName.length));
			_stampPickFunction(id);
		}
	}
}