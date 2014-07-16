/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 30, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class ColourPickerBehaviour extends AbstractPickerBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _coloursAsset:Sprite;
		
		private var _colourPickFunction:Function;
		
		private var _colours:BitmapData;
		
		private var _colourTransform:ColorTransform;
		
		private var _colourDisplay:Shape;
		private var _colourPosition:Point;
		private var _ios:Vector.<InteractiveObject>;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function ColourPickerBehaviour(buttonAsset:MovieClip, pickerAsset:MovieClip, coloursAsset:Sprite, colourPickFunction:Function, tabIndex:uint)
		{
			super(buttonAsset, pickerAsset, tabIndex++);
			
			_coloursAsset = coloursAsset;
			_colourPickFunction = colourPickFunction;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		public function updateColour(colour:uint):void
		{
			if(!_colourTransform) _colourTransform = new ColorTransform();
			_colourTransform.color = colour;
			_buttonAsset.colour.transform.colorTransform = _colourTransform;
		}
		
		public override function destroy():void
		{
			_coloursAsset = null;
		
			_colourPickFunction = null;
			_colours.dispose();
			_colours = null;
			
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
			
			if(!_colours) _colours = DisplayUtils.drawBitmapData(_coloursAsset);
			_coloursAsset.addEventListener(MouseEvent.CLICK, onColoursClick);
			_coloursAsset.addEventListener(MouseEvent.MOUSE_OVER, onColoursOver);
			_coloursAsset.addEventListener(MouseEvent.MOUSE_OUT, onColoursOut);
		}
		
		protected override function disable():void
		{
			_coloursAsset.removeEventListener(MouseEvent.CLICK, onColoursClick);
			_coloursAsset.removeEventListener(MouseEvent.MOUSE_OVER, onColoursOver);
			_coloursAsset.removeEventListener(MouseEvent.MOUSE_OUT, onColoursOut);
			
			super.disable();
		}	
		
		protected override function onButtonClick(evt:Event=null):void
		{
			super.onButtonClick(evt);
			
			if(_open)
			{
				if(!_buttonAsset.stage.focus) _buttonAsset.stage.focus = _pickerAsset;
				
				createColourDisplay();
				if(_coloursAsset.getBounds(_coloursAsset).contains(_coloursAsset.mouseX, _coloursAsset.mouseY))
				{
					onColoursMove();
				}
				else
				{
					_colourPosition.x = _coloursAsset.width >> 1;
					_colourPosition.y = _coloursAsset.height >> 1;
					updateColourDisplay();
				}
			}
		}
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			switch(evt.keyCode)
			{
				case 13: // Enter
				case 32: // Space
					var colour:uint = getColour(_colourPosition.x, _colourPosition.y);
					_colourPickFunction(colour);
					onButtonClick();
					
				// case 27: // Esc
					removeColourDisplay();
					break;	
				
				case 37: // Left 
					_colourPosition.x--;
					if(_colourPosition.x < 0 ) _colourPosition.x = 0;
					updateColourDisplay();
					break;
				
				case 39: // Right
					_colourPosition.x++;
					if(_colourPosition.x > _coloursAsset.width - 1) _colourPosition.x = _coloursAsset.width - 1;
					updateColourDisplay();
					break;
				
				case 38: // Up
					_colourPosition.y--;
					if(_colourPosition.y < 0) _colourPosition.y = 0;
					updateColourDisplay();
					break;
				
				case 40: // Down	
					_colourPosition.y++;
					if(_colourPosition.y > _coloursAsset.height - 1) _colourPosition.y = _coloursAsset.height - 1;
					updateColourDisplay();
					break;
			}
		}
		
		private function createColourDisplay():void
		{
			if(!_ios) _ios = DisplayUtils.disableTabbing(_pickerAsset, _pickerAsset.stage);
			if(!_colourDisplay) _colourDisplay = new Shape();
			_pickerAsset.addChild(_colourDisplay);
			if(!_colourPosition) _colourPosition = new Point();
			
			_pickerAsset.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_coloursAsset.addEventListener(MouseEvent.MOUSE_MOVE, onColoursMove);
		}
		
		private function updateColourDisplay():void
		{
			_colourDisplay.graphics.clear();
			var colour:uint = getColour(_colourPosition.x, _colourPosition.y);
			_colourDisplay.graphics.beginFill(colour);
			_colourDisplay.graphics.lineStyle(1, 0xFFFFFF);
			_colourDisplay.graphics.drawRect(-8, -8, 16, 16);
			_colourDisplay.graphics.endFill();
			_colourDisplay.x = _coloursAsset.x + _colourPosition.x;
			_colourDisplay.y = _coloursAsset.x + _colourPosition.y;
		}
		
		private function removeColourDisplay():void
		{
			_coloursAsset.removeEventListener(MouseEvent.MOUSE_MOVE, onColoursMove);
			_pickerAsset.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			if(_pickerAsset.contains(_colourDisplay)) _pickerAsset.removeChild(_colourDisplay);
			
			if(_ios) DisplayUtils.enableTabbing(_ios);
			_ios = null;
		}
		
		private function onColoursOver(evt:Event):void
		{
			createColourDisplay();
		}
		
		private function onColoursMove(evt:Event=null):void
		{
			_colourPosition.x = _coloursAsset.mouseX*_coloursAsset.scaleX;
			_colourPosition.y = _coloursAsset.mouseY*_coloursAsset.scaleY;
			updateColourDisplay();
		}
		 
		private function onColoursOut(evt:Event):void
		{
			removeColourDisplay();
		}
		
		private function onColoursClick(evt:Event):void
		{
			removeColourDisplay();
			var x:Number = _coloursAsset.mouseX*_coloursAsset.scaleX;
			var y:Number = _coloursAsset.mouseY*_coloursAsset.scaleY;
			var colour:uint = getColour(x, y);
			_colourPickFunction(colour);
			onButtonClick();
		}
		
		private function getColour(x:Number, y:Number):uint
		{
			return _colours.getPixel(x, y);
		}
	}
}
