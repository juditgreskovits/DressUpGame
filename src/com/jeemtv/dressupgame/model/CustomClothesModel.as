/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CustomClothIterator;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;
	import com.jeemtv.dressupgame.view.views.utils.CustomClothUtil;

	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothesModel extends AbstractClothesModel implements IClothesModel
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
	
		private var _currentClothes:Dictionary; // by dolls, then Vec / Vec
		
		private var _id:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CustomClothesModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get clothes():Dictionary
		{
			return _clothes;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		override public function getClothes(doll:uint, category:uint):Vector.<AbstractClothVO>
		{
			return super.getClothes(doll, GlobalConstants.customCategoryToCategory(category));
		}
		
		override public function getCloth(id:String, doll:uint, category:uint):AbstractClothVO
		{
			return super.getCloth(id, doll, GlobalConstants.customCategoryToCategory(category));
		}
		
		
		// when we create, we'll need to know
		// - which doll to assign this to
		// - we'll need to give it a unique id
		// - assign default properties to it and 
		// - make it the "current" one
		public function createCloth(pattern:PatternVO, doll:uint):void
		{
			var vo:CustomClothVO = new CustomClothVO("c" + _id);
			vo.doll = doll;
			vo.pattern = pattern;
			vo.category = pattern.category;
			vo.colour = 0xFFFFFF;
			vo.material = 1;
			
			editCloth(vo, doll);
		}
		
		public function editCloth(vo:CustomClothVO, doll:uint):void
		{
			var it:CustomClothIterator = new CustomClothIterator(vo);
			
			if(!_currentClothes) _currentClothes = new Dictionary();
			if(_currentClothes[doll] == undefined) _currentClothes[doll] = new Vector.<CustomClothIterator>();
			_currentClothes[doll].push(it);
			updateCloth(vo, it);
		}
		
		// when we update, we'll have a "current" one - which this will act on.
		public function updatePattern(pattern:PatternVO, doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			var vo:CustomClothVO = it.clone();
			vo.pattern = pattern;
			vo.category = pattern.category;
			updateCloth(vo, it);
		}
		
		public function updateMaterial(material:uint, doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			var vo:CustomClothVO = it.clone();
			vo.material = material;
			updateCloth(vo, it);
		}
		
		public function updateColour(colour:uint, doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			var vo:CustomClothVO = it.clone();
			vo.colour = colour;
			updateCloth(vo, it);
		}
		
		public function addStamp(stamp:StampVO, doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			var vo:CustomClothVO = it.clone();
			vo.stamps.push(stamp);
			if(vo.stamps.length > GlobalConstants.MAX_STAMPS) vo.stamps.shift();
			updateCloth(vo, it);
		}
		
		public function completeCloth(doll:uint):void
		{
			var it:CustomClothIterator = _currentClothes[doll].pop();
			var vo:CustomClothVO = it.current();
			it.destroy();
			
			addCloth(vo);
			
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.COMPLETE);
			customClothesEvent.cloth = vo;
			dispatch(customClothesEvent);
			
			var customCategory:uint = GlobalConstants.categoryToCustomCategory(vo.category);
			dispatch(EventFactory.requestCategory(customCategory));
			dispatch(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
		}
		
		public function addCloth(vo:CustomClothVO):void
		{
			var pattern:MovieClip = CustomClothUtil.create(vo);
			vo.customClothBmp = CustomClothUtil.createCustomClothBitmap(pattern);
			vo.hangerBmpd = CustomClothUtil.createHangerBmpd(pattern);
			vo.dollBmpd = CustomClothUtil.createDollBmpd(pattern);
			vo.hangerBmpPosition = CustomClothUtil.getHangerBmpPosition(pattern);
			vo.dollBmpPosition = CustomClothUtil.getDollBmpPosition(pattern);
			
			var doll:uint = vo.doll;
			var category:uint = vo.category;
			if(!_clothes) _clothes = new Dictionary();
			if(_clothes[doll] == undefined) _clothes[doll] = new Dictionary();
			if(_clothes[doll][category] == undefined) _clothes[doll][category] = new Vector.<AbstractClothVO>();
			var vec:Vector.<AbstractClothVO> = _clothes[doll][category];
			var i:uint, l:uint = vec.length, index:uint = l;
			for(; i<l; i++)
			{
				if(vec[i].id == vo.id)
				{
					index = i;
					break;
				}
			}
			vec[index] = vo;
			if(vec.length > GlobalConstants.MAX_CUSTOM_CLOTHES) vec.shift();
			
			_id++;
		}
		
		public function undo(doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			if(it.hasPrevious())
			{
				var vo:CustomClothVO = it.previous();
				updateCloth(vo, it);
			}
		}
		
		public function redo(doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			if(it.hasNext())
			{
				var vo:CustomClothVO = it.next();
				updateCloth(vo, it);
			}
		}
		
		public function clear(doll:uint):void
		{
			var it:CustomClothIterator = currentIterator(doll);
			var vo:CustomClothVO = it.reset();
			updateCloth(vo, it);
		}
		
		public function reset():void
		{
			_clothes = null;
			_currentClothes = null;
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
		
		private function currentIterator(doll:uint):CustomClothIterator
		{
			var vec:Vector.<CustomClothIterator> = _currentClothes[doll];
			return vec[vec.length - 1];
		}
		
		private function updateCloth(vo:CustomClothVO, it:CustomClothIterator):void
		{
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.UPDATE);
			customClothesEvent.cloth = vo;
			customClothesEvent.hasNext = it.hasNext();
			customClothesEvent.hasPrevious = it.hasPrevious();
			dispatch(customClothesEvent);
		}
	}
}
