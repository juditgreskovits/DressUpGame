/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.ClothesModel;
	import com.jeemtv.dressupgame.model.CustomClothesModel;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.LoaderService;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.ClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;

	import org.robotlegs.mvcs.Command;

	import flash.utils.Dictionary;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class DollsCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var dollsEvent:DollsEvent;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		[Inject]
		public var clothesModel:ClothesModel;
		
		[Inject]
		public var customClothesModel:CustomClothesModel;
		
		[Inject]
		public var outfitsModel:OutfitsModel;
		
		[Inject]
		public var loaderService:LoaderService;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(dollsEvent.type)
			{
				case DollsEvent.REQUEST_DOLL:
					var id:uint = dollsModel.id;
					dollsModel.id = dollsEvent.id;
					if(id != dollsModel.id) dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_DOLL, TrackingConstants.ACTION_SELECTED, TrackingConstants.LABELS_DOLLS[dollsModel.id - 1]));
					break;
					
				case DollsEvent.REQUEST_PREVIOUS_DOLL:
					if(GlobalConstants.DOLLS.indexOf(dollsModel.id) > 0) dollsModel.id--;
					else dollsModel.id = GlobalConstants.DOLLS[GlobalConstants.DOLLS.length - 1];
					dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_DOLL, TrackingConstants.ACTION_SELECTED, TrackingConstants.LABELS_DOLLS[dollsModel.id - 1]));
					break;
					
				case DollsEvent.REQUEST_NEXT_DOLL:
					if(GlobalConstants.DOLLS.indexOf(dollsModel.id) < GlobalConstants.DOLLS.length - 1) dollsModel.id++;
					else dollsModel.id = GlobalConstants.DOLLS[0];
					dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_DOLL, TrackingConstants.ACTION_SELECTED, TrackingConstants.LABELS_DOLLS[dollsModel.id - 1]));
					break;		
					
				case DollsEvent.REQUEST_CATEGORY:
					dollsModel.category = dollsEvent.category;
					break;
					
				case DollsEvent.REQUEST_PREVIOUS_CATEGORY:
					if(GlobalConstants.CATEGORIES.indexOf(dollsModel.category) > 0) dollsModel.category--;
					else dollsModel.category = GlobalConstants.CATEGORIES[GlobalConstants.CATEGORIES.length - 1];
					break;
					
				case DollsEvent.REQUEST_NEXT_CATEGORY:
					if(GlobalConstants.CATEGORIES.indexOf(dollsModel.category) < GlobalConstants.CATEGORIES.length - 1) dollsModel.category++;
					else dollsModel.category = GlobalConstants.CATEGORIES[0];
					break;	
					
				case DollsEvent.REQUEST_UPDATE_NAME:
					var track:Boolean = dollsModel.updateName(dollsEvent.name, loaderService.lang, dollsEvent.id);
					dispatch(EventFactory.updateDoll(dollsModel.doll, dollsModel.category));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					if(track) dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_DOLL, TrackingConstants.ACTION_RENAMED, dollsEvent.name));
					break;	
					
				case DollsEvent.REQUEST_UPDATE_SKIN:
					track = dollsModel.updateSkin(dollsEvent.skin, dollsEvent.id);
					dispatch(EventFactory.updateDoll(dollsModel.doll, dollsModel.category));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					if(track) dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_DOLL, TrackingConstants.ACTION_SKIN_TONE_CHANGED, TrackingConstants.LABELS_SKIN_TONE[dollsEvent.skin - 1]));
					break;		
				
				case DollsEvent.REQUEST_ADD_CLOTH:
					var cloth:AbstractClothVO;
					if(dollsModel.category == GlobalConstants.CATEGORY_OUTFITS)
					{
						var outfit:Dictionary = clothesModel.getClothesForOutfit(dollsEvent.cloth, dollsModel.id);
						var category:uint;
						for each (category in GlobalConstants.OUTFIT_CATEGORIES)
						{
							cloth = outfit[category];
							if(cloth) dollsModel.addCloth(cloth);
							else dollsModel.removeClothByCategory(category);
						}
						dollsModel.addOutfit(dollsEvent.cloth);
					}
					else
					{
						cloth = clothesModel.getCloth(dollsEvent.cloth, dollsModel.id, dollsModel.category);
						if(!cloth) cloth = customClothesModel.getCloth(dollsEvent.cloth, dollsModel.id, dollsModel.category);
						if(cloth) dollsModel.addCloth(cloth);
					}
					// here to check for whether we've unlocked an outfit...
					dollsModel.addOutfit(checkOutfit());
					dispatch(EventFactory.updateDoll(dollsModel.doll, dollsModel.category));
					// Save both add cloth and potential outfit unlock
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;
					
				case DollsEvent.REQUEST_REMOVE_CLOTH:
					dollsModel.removeClothById(dollsEvent.cloth);
					dollsModel.addOutfit(checkOutfit());
					dispatch(EventFactory.updateDoll(dollsModel.doll, dollsModel.category));
					// Save both add cloth
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;	
			}
		}
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		private function checkOutfit():String
		{
			var doll:DollVO = dollsModel.doll;
			var outfitId:String, category:uint, cloth:ClothVO;
			for each (category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				if(cloth = doll.getCloth(category) as ClothVO)
				{
					if(!outfitId && cloth.outfitId)
					{
						outfitId = cloth.outfitId;
						break;
					}
				}
			}
			
			if(outfitId)
			{
				var isOutfit:Boolean = true;
				var outfit:Dictionary = clothesModel.getClothesForOutfit(outfitId, doll.id);
				for each (category in GlobalConstants.OUTFIT_CATEGORIES)
				{
					if((!doll.getCloth(category) && outfit[category]) || (doll.getCloth(category) && !outfit[category]) || 
						(doll.getCloth(category) && outfit[category] && outfit[category].id != doll.getCloth(category).id))
					{
						isOutfit = false;
						break;
					}
				}
				if(isOutfit)
				{
					dispatch(EventFactory.requestOutfitUnlock(outfitId));
					return outfitId;
				}
			}
			return null;
		}
	}
}