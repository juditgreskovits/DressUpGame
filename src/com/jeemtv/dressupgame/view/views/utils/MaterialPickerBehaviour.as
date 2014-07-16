/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 30, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class MaterialPickerBehaviour extends AbstractPickerBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _buttonName:String;
		
		private var _materialPickFunction:Function;
		
		private var _buttons:Vector.<ButtonBehaviour>;
		private var _selectedButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function MaterialPickerBehaviour(buttonAsset:MovieClip, pickerAsset:MovieClip, buttonName:String, materialPickFunction:Function, tabIndex:uint)
		{
			super(buttonAsset, pickerAsset, tabIndex++);
			
			_buttonName = buttonName;
			_materialPickFunction = materialPickFunction;
			createButtons(tabIndex);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		public function updateMaterial(material:uint):void
		{
			_buttonAsset.material.gotoAndStop(material);
		}
		
		public override function destroy():void
		{
			_buttonName = null;
			_materialPickFunction = null;
			
			var button:ButtonBehaviour;
			for each(button in _buttons)
			{
				button.destroy();
			}
			
			_buttons = null;
			_selectedButton = null;
			
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		protected override function enable():void
		{
			super.enable();
			
			enableButtons(true);
		}
		
		protected override function disable():void
		{
			enableButtons(false);
			
			super.disable();
		}
		
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
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			_materialPickFunction(id);
			onButtonClick();
		}
	}
}
