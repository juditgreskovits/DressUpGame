/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.events.utils
{
	import com.jeemtv.dressupgame.events.TrackingServiceEvent;
	import flash.display.Sprite;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	import com.jeemtv.dressupgame.events.PhotoEvent;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.OutfitsEvent;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.model.vo.StampVO;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class EventFactory
	{
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		// navigation
		
		public static function requestAddress(address:String, transition:String=null):NavigationEvent
		{
			var navigationEvent:NavigationEvent = new NavigationEvent(NavigationEvent.REQUEST_ADDRESS);
			navigationEvent.address = address;
			navigationEvent.transition = transition ? transition : NavigationConstants.TRANSITION_CURTAINS;
			return navigationEvent;
		}
		
		public static function requestOverlay(overlay:String):NavigationEvent
		{
			var navigationEvent:NavigationEvent = new NavigationEvent(NavigationEvent.REQUEST_OVERLAY);
			navigationEvent.overlay = overlay;
			return navigationEvent;
		}
		
		public static function requestMessaging(messaging:String):NavigationEvent
		{
			var navigationEvent:NavigationEvent = new NavigationEvent(NavigationEvent.REQUEST_MESSAGING);
			navigationEvent.messaging = messaging;
			return navigationEvent;
		}
		
		// dolls
		
		public static function requestDoll(id:uint):DollsEvent
		{
			var dollsEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_DOLL);
			dollsEvent.id = id;
			return dollsEvent;
		}
		
		public static function requestSkin(skin:uint):DollsEvent
		{
			var dollsEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_UPDATE_SKIN);
			dollsEvent.skin = skin;
			return dollsEvent;
		}
		
		public static function requestName(name:String):DollsEvent
		{
			var dollsEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_UPDATE_NAME);
			dollsEvent.name = name;
			return dollsEvent;
		}
		
		public static function updateDoll(doll:DollVO, category:uint):DollsEvent
		{
			var dollsEvent:DollsEvent = new DollsEvent(DollsEvent.DOLL);
			dollsEvent.doll = doll;
			dollsEvent.category = category;
			return dollsEvent;
		}
		
		// categories
		
		public static function requestCategory(category:uint):DollsEvent
		{
			var dollsEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_CATEGORY);
			dollsEvent.category = category;
			return dollsEvent;
		}
		
		// clothes
		
		public static function requestCloth(id:String):ClothesEvent
		{
			var clothesEvent:ClothesEvent = new ClothesEvent(ClothesEvent.REQUEST_CLOTH);
			clothesEvent.id = id;
			return clothesEvent;
		}
		
		public static function requestDollAddCloth(cloth:String, bubbles:Boolean=false):DollsEvent
		{
			var clothesEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_ADD_CLOTH, bubbles);
			clothesEvent.cloth = cloth;
			return clothesEvent;
		}
		
		public static function requestDollRemoveCloth(cloth:String):DollsEvent
		{
			var clothesEvent:DollsEvent = new DollsEvent(DollsEvent.REQUEST_REMOVE_CLOTH);
			clothesEvent.cloth = cloth;
			return clothesEvent;
		}
		
		public static function requestOutfitUnlock(id:String):OutfitsEvent
		{
			var outfitsEvent:OutfitsEvent = new OutfitsEvent(OutfitsEvent.REQUEST_OUTFIT_UNLOCK);
			outfitsEvent.id = id;
			return outfitsEvent;
		}
		
		// custom clothes
		
		public static function requestPattern(pattern:PatternVO):CustomClothesEvent
		{
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.REQUEST_PATTERN_UPDATE);
			customClothesEvent.pattern = pattern;
			return customClothesEvent;
		}
		
		public static function requestMaterial(material:uint):CustomClothesEvent
		{
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.REQUEST_MATERIAL_UPDATE);
			customClothesEvent.material = material;
			return customClothesEvent;
		}
		
		public static function requestColour(colour:uint):CustomClothesEvent
		{
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.REQUEST_COLOUR_UPDATE);
			customClothesEvent.colour = colour;
			return customClothesEvent;
		}
		
		public static function requestStampAdd(stamp:StampVO):CustomClothesEvent
		{
			var customClothesEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.REQUEST_STAMP_ADD);
			customClothesEvent.stamp = stamp;
			return customClothesEvent;
		}
		
		// locations 
		
		public static function requestLocation(id:String):LocationsEvent
		{
			var locationsEvent:LocationsEvent = new LocationsEvent(LocationsEvent.REQUEST_LOCATION);
			locationsEvent.id = id;
			return locationsEvent;
		}
		
		public static function requestLocationUnlock(id:String):LocationsEvent
		{
			var locationsEvent:LocationsEvent = new LocationsEvent(LocationsEvent.REQUEST_LOCATION_UNLOCK);
			locationsEvent.id = id;
			return locationsEvent;
		}
		
		public static function updateLocation(location:LocationVO):LocationsEvent
		{
			var locationsEvent:LocationsEvent = new LocationsEvent(LocationsEvent.LOCATION);
			locationsEvent.location = location;
			return locationsEvent;
		}
		
		public static function updateLocations(locations:Vector.<LocationVO>):LocationsEvent
		{
			var locationsEvent:LocationsEvent = new LocationsEvent(LocationsEvent.LOCATIONS);
			locationsEvent.locations = locations;
			return locationsEvent;
		}
		
		// photos
		
		public static function requestPhotoByIndex(index:uint):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.REQUEST_PHOTO);
			photoEvent.index = index;
			return photoEvent;
		}
		
		public static function requestAddPhoto(doll:DollVO):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.REQUEST_ADD_PHOTO);
			photoEvent.doll = doll;
			return photoEvent;
		}
		
		public static function requestRemovePhoto(index:uint):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.REQUEST_REMOVE_PHOTO);
			photoEvent.index = index;
			return photoEvent;
		}
		
		public static function requestPrint(print:Sprite):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.REQUEST_PRINT);
			photoEvent.print = print;
			return photoEvent;
		}
		
		public static function updatePhotos(photos:Vector.<PhotoVO>, hasNextAndPrevious:Boolean):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.PHOTOS);
			photoEvent.photos = photos;
			photoEvent.hasNextAndPrevious = hasNextAndPrevious;
			return photoEvent;
		}
		
		public static function updatePhoto(photo:PhotoVO):PhotoEvent
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.PHOTO);
			photoEvent.photo = photo;
			return photoEvent;
		}
		
		// sound
		
		public static function requestSoundUpdate(musicOn:Boolean, soundOn:Boolean):SoundEvent
		{
			var soundEvent:SoundEvent = new SoundEvent(SoundEvent.REQUEST_UPDATE);
			soundEvent.musicOn = musicOn;
			soundEvent.soundOn = soundOn;
			return soundEvent;
		}
		
		public static function updateSound(musicOn:Boolean, soundOn:Boolean):SoundEvent
		{
			var soundEvent:SoundEvent = new SoundEvent(SoundEvent.UPDATE);
			soundEvent.musicOn = musicOn;
			soundEvent.soundOn = soundOn;
			return soundEvent;
		}
		
		public static function requestPlayMusic(soundId:String):SoundEvent
		{
			var soundEvent:SoundEvent = new SoundEvent(SoundEvent.REQUEST_PLAY_SOUND);
			soundEvent.soundId = soundId;
			soundEvent.soundType = GlobalConstants.SOUND_TYPE_MUSIC;
			return soundEvent;
		}
		
		public static function requestPlaySoundEffect(soundId:String, bubbles:Boolean=false):SoundEvent
		{
			var soundEvent:SoundEvent = new SoundEvent(SoundEvent.REQUEST_PLAY_SOUND, bubbles);
			soundEvent.soundId = soundId;
			soundEvent.soundType = GlobalConstants.SOUND_TYPE_EFFECT;
			return soundEvent;
		}
		
		// tracking
		
		/*public static function createTracking(account:String):TrackingServiceEvent
		{
			var trackingServiceEvent:TrackingServiceEvent = new TrackingServiceEvent(TrackingServiceEvent.CREATE);
			trackingServiceEvent.account = account;
			return trackingServiceEvent;
		}*/
		
		public static function trackEvent(category:String, action:String, label:String=null, value:Number=NaN):TrackingServiceEvent
		{
			var trackingServiceEvent:TrackingServiceEvent = new TrackingServiceEvent(TrackingServiceEvent.TRACK_EVENT);
			trackingServiceEvent.category = category;
			trackingServiceEvent.action = action;
			trackingServiceEvent.label = label;
			trackingServiceEvent.value = value;
			return trackingServiceEvent;
		}
		
		public static function trackPageview(pageURL:String):TrackingServiceEvent
		{
			var trackingServiceEvent:TrackingServiceEvent = new TrackingServiceEvent(TrackingServiceEvent.TRACK_PAGEVIEW);
			trackingServiceEvent.pageURL = pageURL;
			return trackingServiceEvent;
		}
		
	}
}