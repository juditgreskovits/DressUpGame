/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.model.ClothesModel;
	import com.jeemtv.dressupgame.model.CustomClothesModel;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.IClothesModel;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class ClothesCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var clothesEvent:ClothesEvent;
		
		[Inject]
		public var clothesModel:ClothesModel;
		
		[Inject]
		public var customClothesModel:CustomClothesModel;
		
		[Inject]
		public var outfitsModel:OutfitsModel;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		// TODO think of combining this with OutfitsCommand
		//	- no need to have both, they don't do a lot
		//	- but will save us headaches with requesting things for categories!!!
		override public function execute():void
		{
			switch(clothesEvent.type)
			{
				case ClothesEvent.PARSE_XML:
					clothesModel.parseXML();
					break;
				
				case ClothesEvent.REQUEST_CLOTH:
					var cloth:AbstractClothVO = getIClothesModel(dollsModel.category).getCloth(clothesEvent.id, dollsModel.id, dollsModel.category);
					clothesEvent = new ClothesEvent(ClothesEvent.CLOTH);
					clothesEvent.cloth = cloth;
					dispatch(clothesEvent);
					break;
					
				case ClothesEvent.REQUEST_CLOTHES:
					
					var clothes:Vector.<AbstractClothVO> = getIClothesModel(dollsModel.category).getClothes(dollsModel.id, dollsModel.category);
					clothesEvent = new ClothesEvent(ClothesEvent.CLOTHES);
					clothesEvent.clothes = clothes;
					clothesEvent.category = dollsModel.category;
					dispatch(clothesEvent);
					break;		
			}
		}
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		private function getIClothesModel(category:uint):IClothesModel
		{
			if(GlobalConstants.OUTFIT_CATEGORIES.indexOf(category) != -1) return clothesModel;
			else if(GlobalConstants.CUSTOM_CATEGORIES.indexOf(category) != -1) return customClothesModel;
			else if(category == GlobalConstants.CATEGORY_OUTFITS) return outfitsModel;
			return clothesModel;
					
		}
	}
}