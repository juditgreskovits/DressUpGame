/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;

	import org.robotlegs.mvcs.Actor;

	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DollsModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _dolls:Dictionary;
		
		private var _id:uint;
		private var _category:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DollsModel()
		{
			super();
			
			_dolls = new Dictionary();
			_dolls[GlobalConstants.DOLL_1] = new DollVO(GlobalConstants.DOLL_1);
			_dolls[GlobalConstants.DOLL_2] = new DollVO(GlobalConstants.DOLL_2);
			_dolls[GlobalConstants.DOLL_3] = new DollVO(GlobalConstants.DOLL_3);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set id(value:uint):void
		{
			_id = value;
			dispatch(EventFactory.updateDoll(doll, category));
		}
		
		public function get id():uint
		{
			return _id;
		}
		
		// CATEGORY CAN ALSO BE "OUTIFT" AND ANY OF THE "CUSTOM" STUFF
		// outfit will make a difference when dressing - we'll need to change ALL the clothes
		// custom stuff should default to whatever it's non-custom type is - when dressing,
		// but when displaying, it should jsut be custom things... 
		public function set category(value:uint):void
		{
			if(_category != value)
			{
				_category = value;
				
				// think category DOESN't need to be dispatched - we'll respond to this with getting clothes... 
				var categoryEvent:DollsEvent = new DollsEvent(DollsEvent.CATEGORY);
				categoryEvent.category = _category;
				categoryEvent.doll = doll;
				dispatch(categoryEvent);
			}
		}
		
		public function get category():uint
		{
			return _category;
		}
		
		public function get doll():DollVO
		{
			return _dolls[_id];
		}
		
		public function get dolls():Dictionary
		{
			return _dolls;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateName(name:String, lang:String, id:uint=0):Boolean
		{
			var d:DollVO = id ? _dolls[id] : doll;
			if(d["name_" + lang] != name)
			{
				d["name_" + lang] = name;
				d.name = name;
				return true;
			}
			return false;
		}
		
		public function getName(id:uint=0):String
		{
			if(id) return _dolls[id].name;
			return doll.name;		
		}
		
		public function updateSkin(skin:uint, id:uint=0):Boolean
		{
			var d:DollVO = id ? _dolls[id] : doll;
			if(d.skin != skin)
			{
				d.skin = skin;
				return true;
			}
			return false;
		}
		
		public function addCloth(vo:AbstractClothVO, id:uint=0):void
		{
			if(id) _dolls[id].addCloth(vo);
			else doll.addCloth(vo);
		}
		
		public function addOutfit(outfit:String):void
		{
			doll.outfit = outfit;
		}
		
		public function removeClothById(cloth:String):void
		{
			doll.removeClothById(cloth);
		}
		
		public function removeClothByCategory(category:uint):void
		{
			doll.removeClothByCategory(category);
		}
		
		public function reset(lang:String):void
		{
			var id:uint, doll:DollVO, category:uint;
			for each(id in GlobalConstants.DOLLS)
			{
				doll = _dolls[id];
				doll.name_en = CopyData.getCopy("doll_" + doll.id + "_name_" + GlobalConstants.LANGUAGE_ENGLISH);
				doll.name_ar = CopyData.getCopy("doll_" + doll.id + "_name_" + GlobalConstants.LANGUAGE_ARABIC);
				doll.name = lang == GlobalConstants.LANGUAGE_ENGLISH ? doll.name_en : doll.name_ar;
				doll.skin = 1;
				for each(category in GlobalConstants.OUTFIT_CATEGORIES)
				{
					doll.removeClothByCategory(category);
				}
				dispatch(EventFactory.updateDoll(doll, category));
			}
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