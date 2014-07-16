/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DollVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:uint;
		private var _name:String;
		private var _name_en:String;
		private var _name_ar:String;
		private var _skin:uint;
		private var _clothes:Dictionary;
		private var _outfit:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DollVO(id:uint)
		{
			super();
			
			_id = id;
			_skin = 1;
			_clothes = new Dictionary();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get id():uint { return _id; }
		
		public function set name(value:String):void { _name = value; }
		public function get name():String { return _name; }
		
		public function set name_en(value:String):void { _name_en = value; }
		public function get name_en():String { return _name_en; }
		
		public function set name_ar(value:String):void { _name_ar = value; }
		public function get name_ar():String { return _name_ar; }
		
		public function set skin(value:uint):void { _skin = value; }
		public function get skin():uint { return _skin; }
		
		public function set outfit(value:String):void { _outfit = value; }
		public function get outfit():String { return _outfit; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		// TODO consider doing this just by cloth id, rather than by ClothVO
		public function addCloth(vo:AbstractClothVO):void
		{
			_clothes[vo.category] = vo;
			if(vo.category == GlobalConstants.CATEGORY_TOP && _clothes[GlobalConstants.CATEGORY_BOTTOM] && _clothes[GlobalConstants.CATEGORY_BOTTOM].topBottom)
			{
				removeClothByCategory(GlobalConstants.CATEGORY_BOTTOM);
			}
			else if(vo.category == GlobalConstants.CATEGORY_BOTTOM && vo.topBottom) removeClothByCategory(GlobalConstants.CATEGORY_TOP);
			if(!(vo is ClothVO) || (vo as ClothVO).outfitId != outfit) _outfit = null;
		}
		
		public function removeClothById(cloth:String):void
		{
			var category:uint, vo:AbstractClothVO;
			for each(category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				vo = _clothes[category];
				if(vo && vo.id == cloth)
				{
					_clothes[category] = null;
					break;
				}
			}
			_outfit = null;
		}
		
		public function removeClothByCategory(category:uint):void
		{
			_clothes[category] = null;
			_outfit = null;
		}
		
		public function getCloth(category:uint):AbstractClothVO
		{
			if(_clothes && _clothes[category] != undefined) return _clothes[category] as AbstractClothVO;
			return null;
		}
		
		public function clone():DollVO
		{
			var vo:DollVO = new DollVO(_id);
			vo.name = _name;
			vo.skin = _skin;
			var category:uint;
			for each (category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				if(_clothes[category] != undefined) vo.addCloth(_clothes[category]);
			}
			
			vo.outfit = _outfit;
			return vo;
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
		
	}
}