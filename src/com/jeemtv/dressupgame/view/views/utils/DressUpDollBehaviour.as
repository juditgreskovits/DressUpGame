/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 10, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DressUpDollBehaviour extends DollBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _clothUpFunction:Function;
		private var _tabIndex:uint;
		
		private var _mouseDownPosition:Point;
		
		private var _cloth:Sprite;
		private var _assetBounds:Rectangle;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DressUpDollBehaviour(asset:MovieClip, clothUpFunction:Function, tabIndex:uint)
		{
			super(asset);
			
			_clothUpFunction = clothUpFunction;
			_mouseDownPosition = new Point();
			_tabIndex = tabIndex;
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
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		override protected function addCloth(vo:AbstractClothVO):Sprite
		{
			var cloth:Sprite = super.addCloth(vo);
			cloth.buttonMode = true;
			cloth.mouseChildren = false;
			cloth.addEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
			
			cloth.tabEnabled = true;
			cloth.tabChildren = false;
			cloth.tabIndex = vo.category == GlobalConstants.CATEGORY_HEADWEAR ? _tabIndex : _tabIndex + vo.category;
			cloth.addEventListener(FocusEvent.FOCUS_IN, onClothFocusIn);
			return cloth;
		}
		
		override protected function removeCloth(category:uint):Sprite
		{
			var cloth:Sprite = super.removeCloth(category);
			if(cloth)
			{
				cloth.buttonMode = false;
				cloth.mouseChildren = true;
				cloth.removeEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
				
				cloth.tabEnabled = false;
				cloth.tabChildren = true;
				cloth.removeEventListener(FocusEvent.FOCUS_IN, onClothFocusIn);
			}
			return cloth;
		}
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onClothFocusIn(evt:FocusEvent):void
		{
			_cloth = evt.currentTarget as Sprite;
			_cloth.addEventListener(FocusEvent.FOCUS_OUT, onClothFocusOut);
			
			_cloth.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			if(evt.keyCode == 13 || evt.keyCode == 32)
			{
				onClothFocusOut();
				_clothUpFunction(_cloth.name);
				_cloth = null;
			}
		}
		
		private function onClothFocusOut(evt:FocusEvent=null):void
		{
			_cloth.removeEventListener(FocusEvent.FOCUS_OUT, onClothFocusOut);
			_cloth.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_cloth.stage.removeEventListener(MouseEvent.MOUSE_UP, onClothMouseUp);
			_cloth.stage.removeEventListener(Event.MOUSE_LEAVE, onClothMouseUp);
		}
		
		private function onClothDown(evt:MouseEvent):void
		{
			_cloth = evt.currentTarget as Sprite;
			
			_mouseDownPosition.x = _cloth.stage.mouseX;
			_mouseDownPosition.y = _cloth.stage.mouseY;
			
			_assetBounds = _asset.getBounds(_cloth.stage);
			
			_cloth.removeEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
			_cloth.stage.addEventListener(MouseEvent.MOUSE_UP, onClothMouseUp);
			_cloth.stage.addEventListener(Event.MOUSE_LEAVE, onClothMouseUp);
			
			var clothBounds:Rectangle = _cloth.getBounds(_cloth);
			_cloth.x = _asset.mouseX - clothBounds.x - (clothBounds.width >> 1);
			_cloth.y = _asset.mouseY - clothBounds.y - (clothBounds.height >> 1);
			var dragBounds:Rectangle = new Rectangle(-_asset.x - clothBounds.x, -_asset.y - clothBounds.y, _cloth.stage.stageWidth - clothBounds.width, _cloth.stage.stageHeight - clothBounds.height);
			_cloth.startDrag(false, dragBounds);
			
			var category:uint = getClothCategory(_cloth);
			if(category == GlobalConstants.CATEGORY_TOP) _asset.underwearTop.visible = true;
			if(category == GlobalConstants.CATEGORY_BOTTOM)
			{
				_asset.underwearBottom.visible = true;
				if(_topBottom) _asset.underwearTop.visible = true;
			}
		}
		
		private function onClothMouseUp(evt:Event):void
		{
			_cloth.stage.removeEventListener(MouseEvent.MOUSE_UP, onClothMouseUp);
			_cloth.stage.removeEventListener(Event.MOUSE_LEAVE, onClothMouseUp);
			_cloth.stopDrag();
			
			_cloth.removeEventListener(FocusEvent.FOCUS_OUT, onClothFocusOut);
			_cloth.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			if(DisplayUtils.isPositionWithinRange(_mouseDownPosition, new Point(_cloth.stage.mouseX, _cloth.stage.mouseY)) ||
			// if((_mouseDownPosition.x == _cloth.stage.mouseX && _mouseDownPosition.y == _cloth.stage.mouseY) ||
				!_assetBounds.contains(_cloth.stage.mouseX, _cloth.stage.mouseY))
			{	
				_clothUpFunction(_cloth.name);	
			}
			else
			{
				_cloth.x = 0;
				_cloth.y = 0;
				
				updateUnderwearVisibility();
			}
			
			_cloth.addEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
			_cloth = null;
			_assetBounds = null;
			
			_mouseDownPosition.x = -1;
			_mouseDownPosition.y = -1;
			
			/*if(_mouseDownPosition.x != _cloth.stage.mouseX || _mouseDownPosition.y != _cloth.stage.mouseY)
			{
				_cloth.stage.removeEventListener(MouseEvent.MOUSE_UP, onClothMouseUp);
				_cloth.stage.removeEventListener(Event.MOUSE_LEAVE, onClothMouseUp);
				_cloth.stopDrag();
				
				if(_assetBounds.contains(_cloth.stage.mouseX, _cloth.stage.mouseY))
				{	
					_cloth.x = 0;
					_cloth.y = 0;
				}
				else _clothUpFunction(_cloth.name);
				
				_cloth.addEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
				_cloth = null;
				_assetBounds = null;
			}
			_mouseDownPosition.x = -1;
			_mouseDownPosition.y = -1;*/
		}
	}
}
