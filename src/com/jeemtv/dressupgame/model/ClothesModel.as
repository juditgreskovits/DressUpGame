/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.greensock.loading.LoaderMax;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.ClothVO;

	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class ClothesModel extends AbstractClothesModel implements IClothesModel
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function ClothesModel()
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
		
		// method for getting all clothes for outfit!
		public function getClothesForOutfit(id:String, doll:uint):Dictionary
		{
			var outfit:Dictionary = new Dictionary();
			var category:uint, cloth:ClothVO;
			for each(category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				cloth = findOutfitCloth(id, _clothes[doll][category]);
				if(cloth) outfit[category] = cloth;
			}
			return outfit;
		}

		public function parseXML():void
		{
			_clothes = new Dictionary();
			
			var xml:XML = LoaderMax.getContent(GlobalConstants.CLOTHES_LOADER_NAME) as XML;
			var clothes:XMLList = xml.item, cloth:XML, vo:ClothVO;
			for each (cloth in clothes)
			{
				vo = new ClothVO(cloth.@id);
				vo.doll = cloth.@doll;
				vo.category = cloth.@category;
				vo.topBottom = cloth.@topBottom == "true";
				vo.assetClassNameOnHanger = cloth.@hangerAssetClassName;
				vo.assetClassNameOnDoll = cloth.@dollAssetClassName;
				vo.outfitId = cloth.@outfitId;
				
				if(_clothes[vo.doll] == undefined) _clothes[vo.doll] = new Dictionary();
				if(_clothes[vo.doll][vo.category] == undefined) _clothes[vo.doll][vo.category] = new Vector.<AbstractClothVO>();
				(_clothes[vo.doll][vo.category] as Vector.<AbstractClothVO>).push(vo);
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
		
		private function findOutfitCloth(id:String, clothes:Vector.<AbstractClothVO>):ClothVO
		{
			var cloth:ClothVO;
			for each(cloth in clothes)
			{
				if(cloth.outfitId == id) return cloth;
			}
			return null;
		}
	}
}