/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 3, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DollBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _asset:MovieClip;
		protected var _photoShoot:Boolean;
		
		protected var _topBottom:Boolean;
		
		// private properties
		
		private var _clothes:Dictionary;
		private var _outfit:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DollBehaviour(asset:MovieClip, photoShoot:Boolean=false)
		{
			super();
			
			_asset = asset;
			_photoShoot = photoShoot;
			_clothes = new Dictionary();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get outfit():String { return _outfit; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function update(doll:DollVO):void
		{
			var category:uint;
			var frame:uint = 3*(doll.id - 1);
			if(_asset.currentFrame <= frame || _asset.currentFrame > frame + 3)
			{
				for each(category in GlobalConstants.OUTFIT_CATEGORIES)
				{
					removeCloth(category);
				}
			}
			frame += doll.skin;
			//if(_asset.currentFrame != frame)
			//{
				_asset.gotoAndStop(frame);
				_asset.underwearTop.gotoAndStop(doll.id);
				_asset.underwearBottom.gotoAndStop(doll.id);
			//}
			
			_asset.getChildAt(0).visible = _photoShoot;
			_asset.getChildAt(1).visible = !_photoShoot;
			
			for each(category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				var cloth:AbstractClothVO = doll.getCloth(category);
				if(cloth)
				{
					if(_clothes[category] != undefined)
					{
						if(_clothes[category].name != cloth.id)
						{
							removeCloth(category);
							addCloth(cloth);
						}
					}
					else addCloth(cloth);
				}
				else if(_clothes[category] != undefined) removeCloth(category);
			}
			_outfit = doll.outfit;
		}
		
		public function getCloth(category:uint):String
		{
			if(_clothes && _clothes[category]) return _clothes[category].name;
			return null;
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		protected function addCloth(vo:AbstractClothVO):Sprite
		{
			var cloth:Sprite = vo.getAssetOnDoll();
			var category:uint = vo.category;
			cloth.name = vo.id;
			cloth.x = cloth.y = 0;
			_clothes[category] = cloth;
			if(category == GlobalConstants.CATEGORY_BOTTOM) _topBottom = vo.topBottom;
			var depth:uint = 5, top:uint = Math.max(_asset.numChildren, depth);
			if(category == GlobalConstants.CATEGORY_ACCESSORY) depth = top;
			else if(category == GlobalConstants.CATEGORY_TOP) depth = _clothes[GlobalConstants.CATEGORY_ACCESSORY] == undefined ? top : _asset.numChildren - 1;
			else if(category == GlobalConstants.CATEGORY_BOTTOM && _clothes[GlobalConstants.CATEGORY_SHOES] != undefined) depth = 6;
			_asset.addChildAt(cloth, depth);
			updateUnderwearVisibility();
			return cloth;
		}
		
		protected function removeCloth(category:uint):Sprite
		{
			if(_clothes[category] != undefined)
			{
				var cloth:Sprite = _clothes[category] as Sprite;
				if(_asset.contains(cloth)) _asset.removeChild(cloth);
				_clothes[category] = undefined;
				if(category == GlobalConstants.CATEGORY_BOTTOM) _topBottom = false;
				updateUnderwearVisibility();
				return cloth;
			}
			return null;
		}
		
		protected function getClothCategory(cloth:Sprite):uint
		{
			var category:uint;
			for each (category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				if(_clothes[category] == cloth) return category;
			}
			return 0;
		}
		
		protected function updateUnderwearVisibility():void
		{
			trace("DollBehaviour.updateUnderwearVisibility _topBottom = " + _topBottom);
			_asset.underwearTop.visible = _clothes[GlobalConstants.CATEGORY_TOP] == undefined && !_topBottom;
			_asset.underwearBottom.visible = _clothes[GlobalConstants.CATEGORY_BOTTOM] == undefined;
		}
	}
}
