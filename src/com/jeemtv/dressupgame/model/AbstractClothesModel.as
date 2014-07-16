/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 5, 2013
 */
package com.jeemtv.dressupgame.model
{
	import flash.utils.Dictionary;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractClothesModel extends Actor implements IClothesModel
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _clothes:Dictionary;
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractClothesModel()
		{
			super();
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
		
		public function getClothes(doll:uint, category:uint):Vector.<AbstractClothVO>
		{
			if(_clothes && _clothes[doll] && _clothes[doll][category]) return _clothes[doll][category] as Vector.<AbstractClothVO>;
			return null;
		}
		
		public function getCloth(id:String, doll:uint, category:uint):AbstractClothVO
		{
			return findCloth(id, _clothes[doll][category]);
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		protected function findCloth(id:String, clothes:Vector.<AbstractClothVO>):AbstractClothVO
		{
			if(clothes)
			{
				var cloth:AbstractClothVO;
				for each(cloth in clothes)
				{
					if(cloth.id == id) return cloth;
				}
			}
			return null;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
	}
}