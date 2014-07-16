/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.ClothesModel;
	import com.jeemtv.dressupgame.model.CustomClothesModel;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.LoaderService;
	import com.jeemtv.dressupgame.model.LocationsModel;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.PatternsModel;
	import com.jeemtv.dressupgame.model.PhotoModel;
	import com.jeemtv.dressupgame.model.SoundModel;
	import com.jeemtv.dressupgame.model.StorageService;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.OutfitVO;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;

	import org.robotlegs.mvcs.Command;

	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class StorageServiceCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var storageServiceEvent:StorageServiceEvent;
		
		[Inject]
		public var storageService:StorageService;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		[Inject]
		public var clothesModel:ClothesModel;
		
		[Inject]
		public var customClothesModel:CustomClothesModel;
		
		[Inject]
		public var patternsModel:PatternsModel;
		
		[Inject]
		public var outfitsModel:OutfitsModel;
		
		[Inject]
		public var locationsModel:LocationsModel;
		
		[Inject]
		public var photoModel:PhotoModel;
		
		[Inject]
		public var soundModel:SoundModel;
		
		[Inject]
		public var loaderService:LoaderService;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(storageServiceEvent.type)
			{
				case StorageServiceEvent.REQUEST_SAVE:
					var data:Object = {};
					data.settings = getSettingsData();
					data.dolls = getDollsData();
					data.customClothes = getCustomClothesData();
					data.outfits = getOutfitsData();
					data.photos = getPhotosData();
					storageService.save(data);
					break;
					
				case StorageServiceEvent.REQUEST_RESTORE:
					storageService.restore();
					break;	
					
				case StorageServiceEvent.RESTORE:
					data = storageServiceEvent.data;
					if(data)
					{
						if(data.customClothes) restoreCustomClothes(data.customClothes);
						if(data.outfits) restoreOutfits(data.outfits);
						if(data.dolls) restoreDolls(data.dolls);
						if(data.photos) restorePhotos(data.photos);
						restoreSettings(data.settings);
					}
					else
					{
						var doll:uint;
						for each (doll in GlobalConstants.DOLLS)
						{
							if(loaderService.lang == GlobalConstants.LANGUAGE_ENGLISH)
							{
								dollsModel.updateName(CopyData.getCopy("doll_" + doll + "_name_" + GlobalConstants.LANGUAGE_ARABIC), GlobalConstants.LANGUAGE_ARABIC, doll);
								dollsModel.updateName(CopyData.getCopy("doll_" + doll + "_name_" + GlobalConstants.LANGUAGE_ENGLISH), GlobalConstants.LANGUAGE_ENGLISH, doll);
							}
							else
							{
								dollsModel.updateName(CopyData.getCopy("doll_" + doll + "_name_" + GlobalConstants.LANGUAGE_ENGLISH), GlobalConstants.LANGUAGE_ENGLISH, doll);
								dollsModel.updateName(CopyData.getCopy("doll_" + doll + "_name_" + GlobalConstants.LANGUAGE_ARABIC), GlobalConstants.LANGUAGE_ARABIC, doll);
							}
						}
						restoreSettings();
					}
					
					dispatch(EventFactory.requestAddress(NavigationConstants.ADDRESS_START, NavigationConstants.TRANSITION_PRELOADER_TO_START));
					break;
					
				case StorageServiceEvent.REQUEST_RESET:
					storageService.reset();
					break;	
					
				case StorageServiceEvent.RESET:
					customClothesModel.reset();
					outfitsModel.reset();
					dollsModel.reset(loaderService.lang);
					photoModel.reset();
					dispatch(new LocationsEvent(LocationsEvent.PARSE_UNLOCKED));
					dispatch(EventFactory.requestAddress(NavigationConstants.ADDRESS_HOME));
					break;			
				
			}
		}
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		private function restoreOutfits(data:Array):void
		{
			var outfit:String, vo:OutfitVO;
			for each (outfit in data)
			{
				vo = outfitsModel.unlockOutfit(outfit);
				locationsModel.unlockLocation(vo.locationId);
			}
		}
		
		private function restoreCustomClothes(data:Object):void
		{
			var doll:uint, category:uint, dollClothes:Object, categoryClothes:Array;
			var cloth:Object, customCloth:CustomClothVO, stamps:Array, stamp:Object, vo:StampVO;
			for each (doll in GlobalConstants.DOLLS)
			{
				dollClothes = data[doll];
				if(dollClothes)
				{
					for each (category in GlobalConstants.OUTFIT_CATEGORIES)
					{
						categoryClothes = dollClothes[category];
						if(categoryClothes)
						{
							for each (cloth in categoryClothes)
							{
								customCloth = new CustomClothVO(cloth.id);
								customCloth.doll = doll;
								customCloth.category = category;
								customCloth.pattern = patternsModel.getPattern(cloth.p, doll);
								customCloth.material = cloth.m;
								customCloth.colour = cloth.c;
								if(cloth.s && cloth.s.length)
								{
									stamps = cloth.s;
									customCloth.stamps = new Vector.<StampVO>();
									for each (stamp in stamps)
									{
										vo = new StampVO(stamp.id);
										vo.colour = stamp.c;
										vo.position = new Point(stamp.x, stamp.y);
										customCloth.stamps.push(vo);
									}
								}
								customClothesModel.addCloth(customCloth);
							}
						}
					}
				}
			}
		}
		
		private function restoreDolls(data:Object):void
		{
			var doll:uint, category:uint, clothes:Object, id:String, cloth:AbstractClothVO;
			for each (doll in GlobalConstants.DOLLS)
			{
				if(loaderService.lang == GlobalConstants.LANGUAGE_ENGLISH)
				{
					dollsModel.updateName(data[doll]["n_" + GlobalConstants.LANGUAGE_ARABIC], GlobalConstants.LANGUAGE_ARABIC, doll);
					dollsModel.updateName(data[doll]["n_" + GlobalConstants.LANGUAGE_ENGLISH], GlobalConstants.LANGUAGE_ENGLISH, doll);
				}
				else
				{
					dollsModel.updateName(data[doll]["n_" + GlobalConstants.LANGUAGE_ENGLISH], GlobalConstants.LANGUAGE_ENGLISH, doll);
					dollsModel.updateName(data[doll]["n_" + GlobalConstants.LANGUAGE_ARABIC], GlobalConstants.LANGUAGE_ARABIC, doll);
				}
				
				dollsModel.updateSkin(data[doll].s, doll);
				
				clothes = data[doll].c;
				for each (category in GlobalConstants.OUTFIT_CATEGORIES)
				{
					id = clothes[category];
					if(clothes[category])
					{
						cloth = clothesModel.getCloth(id, doll, category);
						if(!cloth) cloth = customClothesModel.getCloth(id, doll, category);
						if(cloth) dollsModel.addCloth(cloth, doll);
					}
				}
			}
		}
		
		private function restoreSettings(data:Object=null):void
		{
			soundModel.musicOn = data ? data.musicOn : true;
			soundModel.soundOn = data ? data.soundOn : true;
		}
		
		private function restorePhotos(data:Object):void
		{
			var photo:Object, doll:DollVO, location:LocationVO;
			for each (photo in data)
			{
				location = locationsModel.getLocation(photo.l);
				doll = new DollVO(photo.d.id);
				doll.name = dollsModel.getName(doll.id);
				doll.skin = photo.d.s;
				var id:String, category:uint, cloth:AbstractClothVO;
				var clothes:Object = photo.d.c;
				for each (category in GlobalConstants.OUTFIT_CATEGORIES)
				{
					id = clothes[category];
					if(clothes[category])
					{
						cloth = clothesModel.getCloth(id, doll.id, category);
						if(!cloth) cloth = customClothesModel.getCloth(id, doll.id, category);
						doll.addCloth(cloth);
					}
				}
				photoModel.addPhoto(doll, location);
			}
		}
		
		private function getPhotosData():Array
		{
			var data:Array = [];
			var photos:Vector.<PhotoVO> = photoModel.photos;
			if(photos && photos.length)
			{
				var vo:PhotoVO, photo:Object;
				for each(vo in photos)
				{
					photo = {};
					photo.id = vo.id;
					photo.l = vo.location.id;
					photo.d = {id:vo.doll.id, s:vo.doll.skin, c:getClothesData(vo.doll)};
					data.push(photo);
				}
			}
			return data;
		}
		
		private function getSettingsData():Object
		{
			return {musicOn:soundModel.musicOn, soundOn:soundModel.soundOn};
		}
		
		private function getDollsData():Object
		{
			var data:Object = {};
			var dolls:Dictionary = dollsModel.dolls;
			var id:uint, doll:DollVO, clothes:Object;
			for each (id in GlobalConstants.DOLLS)
			{
				doll = dolls[id];
				clothes = getClothesData(doll);
				data[id] = {n_en:doll.name_en, n_ar:doll.name_ar, s:doll.skin, c:clothes};
			}
			return data;
		}
		
		private function getClothesData(doll:DollVO):Object
		{
			var clothes:Object = {};
			var category:uint, cloth:AbstractClothVO;
			for each (category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				cloth = doll.getCloth(category);
				if(cloth) clothes[category] = cloth.id;
			}
			return clothes;
		}
		
		private function getCustomClothesData():Object
		{
			
			var clothes:Dictionary = customClothesModel.clothes;
			if(clothes)
			{
				var data:Object = [];
				var doll:uint, category:uint, dollClothes:Dictionary, categoryClothes:Vector.<AbstractClothVO>;
				var cloth:CustomClothVO, customCloth:Object, stamps:Vector.<StampVO>, stamp:StampVO;
				for each (doll in GlobalConstants.DOLLS)
				{
					dollClothes = clothes[doll];
					
					if(dollClothes)
					{
						for each (category in GlobalConstants.OUTFIT_CATEGORIES)
						{
							categoryClothes = dollClothes[category];
							if(categoryClothes && categoryClothes.length)
							{
								if(!data) data = {};
								if(!data[doll]) data[doll] = {};
								if(!data[doll][category]) data[doll][category] = [];
								for each (cloth in categoryClothes)
								{
									customCloth = {id:cloth.id, p:cloth.pattern.id, m:cloth.material, c:cloth.colour};
									stamps = cloth.stamps;
									if(stamps)
									{
										if(stamps.length) customCloth.s = [];
										for each (stamp in stamps)
										{
											customCloth.s.push({id:stamp.id, c:stamp.colour, x:stamp.position.x, y:stamp.position.y});
										}
									}
									data[doll][category].push(customCloth);
								}
							}
						}
					}
				}
				return data;
			}
			return null;
		}
		
		private function getOutfitsData():Array
		{
			var data:Array = [];
			var outfits:Dictionary = outfitsModel.outfits;
			var doll:uint, dollOutfits:Vector.<AbstractClothVO>, outfit:OutfitVO;
			for each (doll in GlobalConstants.DOLLS)
			{
				dollOutfits = outfits[doll];
				for each (outfit in dollOutfits)
				{
					if(outfit.unlocked) data.push(outfit.id);
				}
			}
			return data;
		}
	}
}
