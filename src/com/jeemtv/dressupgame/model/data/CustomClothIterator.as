/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model.data
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothIterator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		// private var _reset:CustomClothVO;
		
		private var _history:Vector.<CustomClothVO>;
		
		private var _index:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CustomClothIterator(vo:CustomClothVO)
		{
			super();
			
			// _reset = vo;
			reset(vo);
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
		
		public function clone():CustomClothVO
		{
			// get rid of the history that's after this new modification
			if(_index < _history.length - 1) _history.splice(_index + 1, _history.length - _index);
			var vo:CustomClothVO = _history[_index++];
			_history.push(vo.clone());
			// check if we are over the max amount on history, and if so, remove from front!
			if(_history.length > GlobalConstants.MAX_CUSTOM_CLOTH_HISTORY) _history.unshift();
			return current();
		}
		
		public function current():CustomClothVO
		{
			return _history[_index];
		}
		
		public function hasPrevious():Boolean
		{
			return _index > 0;
		}
		
		public function hasNext():Boolean
		{
			return _index < _history.length - 1;
		}
		
		public function previous():CustomClothVO
		{
			return _history[--_index];
		}
		
		public function next():CustomClothVO
		{
			return _history[++_index];
		}
		
		// reset happens when creating a new one
		// editing an existing one
		// resetting one being edited
		
		public function reset(vo:CustomClothVO=null):CustomClothVO
		{
			if(!vo)
			{
				vo = current();
				vo.colour = 0xFFFFFF;
				vo.material = 1;
				vo.stamps = null;
			}
			
			_history = new Vector.<CustomClothVO>();
			_history.push(vo);
			_index = 0;
			return current();
		}
		
		public function destroy():void
		{
			_history = null;		
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