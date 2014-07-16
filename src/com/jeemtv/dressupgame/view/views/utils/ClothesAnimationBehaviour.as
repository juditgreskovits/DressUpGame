/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 5, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class ClothesAnimationBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _asset:MovieClip;
		
		// private properties
		
		private var _animation:MovieClipBehaviour;
		private var _clothDownFunction:Function;
		private var _transitionOutEndFunction:Function;
		private var _designStudioButtonClickFunction:Function;
		private var _editButtonClickFunction:Function;
		
		private var _tabIndex:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function ClothesAnimationBehaviour(asset:MovieClip, clothDownFunction:Function, transitionOutEndFunction:Function, tabIndex:uint)
		{
			super();
			
			_asset = asset;
			_animation = new MovieClipBehaviour(_asset);
			_clothDownFunction = clothDownFunction;
			_transitionOutEndFunction = transitionOutEndFunction;
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
		
		public function transitionIn(clothes:Vector.<AbstractClothVO>):void
		{	
			var i:uint;
			var cloth:AbstractClothVO, clothClass:Class, clothAsset:Sprite, clothContainer:MovieClip;
			while(clothContainer = _asset["item0" + ++i])
			{
				removeClothButton(clothContainer);
				createClothButton(clothes, i, clothContainer);
			}
			_animation.play(NavigationConstants.TRANSITION_IN_START);
			_asset.visible = true;
		}
		
		public function transtionOut(clothes:Vector.<AbstractClothVO>, category:uint):void
		{
			if(_asset.visible)
			{
				var i:uint;
				var clothAsset:Sprite, clothContainer:Sprite;
				while(clothContainer = _asset["item0" + ++i])
				{
					if(clothContainer.numChildren > 1)
					{
						clothAsset = clothContainer.getChildAt(1) as Sprite;
						clothAsset.removeEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
					}
				}
			
				_animation.addFunctionToLabel(NavigationConstants.TRANSITION_OUT_END, onTransitionOutEnd, [clothes, category]);
				_animation.play(NavigationConstants.TRANSITION_OUT_START);
			}
		}
		
		public function updateClothesVisibility(doll:DollBehaviour):void
		{
			if(_asset.visible)
			{
				var i:uint, clothContainer:MovieClip, cloth:Sprite, category:uint, visible:Boolean;
				while(clothContainer = _asset["item0" + ++i])
				{
					cloth = clothContainer.numChildren == 2 || clothContainer.numChildren == 4 ? 
						clothContainer.getChildAt(1) as Sprite : null;
					if(cloth)
					{
						visible = true;
						for each (category in GlobalConstants.OUTFIT_CATEGORIES)
						{
							if(cloth.name == doll.getCloth(category)) visible = false;
						}
						// if(!found && doll.outfit) found = cloth.name == doll.outfit;
						setClothVisbility(clothContainer, visible);
					}
					else if(clothContainer.numChildren > 1) clothContainer.hanger.visible = true;
				}
			}
		}
		
		public function updateClothVisibility(id:String, visible:Boolean):void
		{
			if(_asset.visible)
			{
				var i:uint, clothContainer:MovieClip, cloth:Sprite;
				while(clothContainer = _asset["item0" + ++i])
				{
					if(clothContainer.numChildren > 1)
					{
						cloth = clothContainer.getChildAt(1) as Sprite;
						if(cloth && cloth.name == id) setClothVisbility(clothContainer, visible);
					}
				}
			}
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		protected function setClothVisbility(clothContainer:MovieClip, visible:Boolean):void
		{
			clothContainer.getChildAt(1).visible = visible;
			clothContainer.hanger.visible = !visible;
		}
		
		protected function removeClothButton(clothContainer:MovieClip):void
		{
			if(clothContainer.numChildren > 1)
			{
				var clothAsset:Sprite = clothContainer.removeChildAt(1) as Sprite;
				
				clothAsset.buttonMode = false;
				clothAsset.mouseChildren = true;
				clothAsset.addEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
				
				clothAsset.tabEnabled = false;
				clothAsset.tabChildren = true;
				clothAsset.removeEventListener(FocusEvent.FOCUS_IN, onClothFocusIn);
			}
		}
		
		protected function createClothButton(clothes:Vector.<AbstractClothVO>, index:uint, clothContainer:MovieClip):void
		{
			if(clothes && index <= clothes.length)
			{
				var cloth:AbstractClothVO = clothes[index-1];
				var clothAsset:Sprite = cloth.getAssetOnHanger();
				clothAsset.name = cloth.id;
				clothContainer.addChildAt(clothAsset, 1);
				clothAsset.buttonMode = true;
				clothAsset.mouseChildren = false;
				clothAsset.addEventListener(MouseEvent.MOUSE_DOWN, onClothDown);
				
				clothAsset.tabEnabled = true;
				clothAsset.tabChildren = false;
				clothAsset.tabIndex = _tabIndex + index;
				clothAsset.addEventListener(FocusEvent.FOCUS_IN, onClothFocusIn);
			}
			else clothContainer.hanger.visible = false;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onClothFocusIn(evt:FocusEvent):void
		{
			var clothAsset:Sprite = evt.currentTarget as Sprite;
			clothAsset.addEventListener(FocusEvent.FOCUS_OUT, onClothFocusOut);
			
			clothAsset.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			if(evt.keyCode == 13 || evt.keyCode == 32)
			{
				var clothAsset:Sprite = evt.currentTarget as Sprite;
				clothAsset.dispatchEvent(EventFactory.requestDollAddCloth(clothAsset.name, true));
				clothAsset.dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CLOTHING_ADD, true));
				onClothFocusOut(evt);
			}
		}
		
		private function onClothFocusOut(evt:Event):void
		{
			var clothAsset:Sprite = evt.currentTarget as Sprite;
			clothAsset.removeEventListener(FocusEvent.FOCUS_OUT, onClothFocusOut);
			clothAsset.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onClothDown(evt:MouseEvent):void
		{
			_clothDownFunction(evt);
		}
		
		private function onTransitionOutEnd(clothes:Vector.<AbstractClothVO>, category:uint):void
		{
			_asset.visible = false;
			_transitionOutEndFunction(clothes, category);
		}
	}
}
