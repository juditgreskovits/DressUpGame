/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.greensock.loading.LoaderMax;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.OutfitVO;

	import org.robotlegs.mvcs.Actor;

	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class OutfitsModel extends Actor implements IClothesModel
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _outfits:Dictionary;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function OutfitsModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get outfits():Dictionary
		{
			return _outfits;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getClothes(doll:uint, category:uint):Vector.<AbstractClothVO>
		{
			return _outfits[doll] as Vector.<AbstractClothVO>;
		}
		
		public function getCloth(id:String, doll:uint, category:uint):AbstractClothVO
		{
			return findOutfit(id, _outfits[doll]);
		}
		
		public function getOutfitByLocation(location:String):OutfitVO
		{
			var doll:uint, dollOutfits:Vector.<AbstractClothVO>, outfit:AbstractClothVO;
			for each (doll in GlobalConstants.DOLLS)
			{
				dollOutfits = _outfits[doll];
				for each (outfit in dollOutfits)
				{
					if((outfit as OutfitVO).locationId == location) return outfit as OutfitVO;
				}
			}
			return null;
		}
		
		public function parseXML():void
		{
			_outfits = new Dictionary();
			
			var xml:XML = LoaderMax.getContent(GlobalConstants.OUTFITS_LOADER_NAME) as XML;
			var outfits:XMLList = xml.outfit, outfit:XML, vo:OutfitVO;
			for each(outfit in outfits)
			{
				vo = new OutfitVO(outfit.@id);
				vo.name = String(outfit);
				vo.doll = outfit.@doll;
				vo.assetClassName = outfit.@outfitAssetClassName;
				vo.locationId = outfit.@locationId;
				
				if(_outfits[vo.doll] == undefined) _outfits[vo.doll] = new Vector.<AbstractClothVO>();
				(_outfits[vo.doll] as Vector.<AbstractClothVO>).push(vo);
			}
		}
		
		public function unlockOutfit(id:String, doll:uint=0):OutfitVO
		{
			var outfit:OutfitVO;
			if(doll)
			{
				outfit = findOutfit(id, _outfits[doll]);
			}
			else
			{
				for each (doll in GlobalConstants.DOLLS)
				{
					outfit = findOutfit(id, _outfits[doll]);
					if(outfit) break;
				}
			}
			if(!outfit.unlocked)
			{
				outfit.unlocked = true;
				return outfit;
			}
			return null;
		}
		
		public function reset():void
		{
			var dollOutfits:Vector.<AbstractClothVO>, doll:uint, outfit:OutfitVO;
			for each(doll in GlobalConstants.DOLLS)
			{
				dollOutfits = _outfits[doll];
				for each(outfit in dollOutfits)
				{
					outfit.unlocked = false;
				}
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
		
		private function findOutfit(id:String, outfits:Vector.<AbstractClothVO>):OutfitVO
		{
			var outfit:OutfitVO;
			for each (outfit in outfits)
			{
				if(outfit.id == id) return outfit;
			}
			return null;
		}
	}
}