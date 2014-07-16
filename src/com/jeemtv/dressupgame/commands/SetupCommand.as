/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.events.LoaderServiceEvent;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.events.OutfitsEvent;
	import com.jeemtv.dressupgame.events.PatternsEvent;
	import com.jeemtv.dressupgame.events.PhotoEvent;
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.TrackingServiceEvent;
	import com.jeemtv.dressupgame.model.ClothesModel;
	import com.jeemtv.dressupgame.model.CustomClothesModel;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.LoaderService;
	import com.jeemtv.dressupgame.model.LocationsModel;
	import com.jeemtv.dressupgame.model.NavigationModel;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.PatternsModel;
	import com.jeemtv.dressupgame.model.PhotoModel;
	import com.jeemtv.dressupgame.model.SoundModel;
	import com.jeemtv.dressupgame.model.StorageService;
	import com.jeemtv.dressupgame.model.TrackingService;
	import com.jeemtv.dressupgame.view.mediators.CheatMediator;
	import com.jeemtv.dressupgame.view.mediators.DesignStudioMediator;
	import com.jeemtv.dressupgame.view.mediators.DollsOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.DressUpMediator;
	import com.jeemtv.dressupgame.view.mediators.HelpOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.HomeMediator;
	import com.jeemtv.dressupgame.view.mediators.LocationsOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.MenuMediator;
	import com.jeemtv.dressupgame.view.mediators.OutfitOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.PhotoshootMediator;
	import com.jeemtv.dressupgame.view.mediators.SettingsOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.SkinAndNameOverlayMediator;
	import com.jeemtv.dressupgame.view.mediators.StartMediator;
	import com.jeemtv.dressupgame.view.mediators.TransitionMediator;
	import com.jeemtv.dressupgame.view.mediators.WarningMessagingMediator;
	import com.jeemtv.dressupgame.view.views.AbstractView;
	import com.jeemtv.dressupgame.view.views.CheatView;
	import com.jeemtv.dressupgame.view.views.DesignStudioView;
	import com.jeemtv.dressupgame.view.views.DollsOverlayView;
	import com.jeemtv.dressupgame.view.views.DressUpView;
	import com.jeemtv.dressupgame.view.views.HelpOverlayView;
	import com.jeemtv.dressupgame.view.views.HomeView;
	import com.jeemtv.dressupgame.view.views.LocationsOverlayView;
	import com.jeemtv.dressupgame.view.views.MenuView;
	import com.jeemtv.dressupgame.view.views.OutfitOverlayView;
	import com.jeemtv.dressupgame.view.views.PhotoshootView;
	import com.jeemtv.dressupgame.view.views.SettingsOverlayView;
	import com.jeemtv.dressupgame.view.views.SkinAndNameOverlayView;
	import com.jeemtv.dressupgame.view.views.StartView;
	import com.jeemtv.dressupgame.view.views.TransitionView;
	import com.jeemtv.dressupgame.view.views.WarningMessagingView;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class SetupCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			createModel();
			createView();
			createCommands();
		}
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		private function createModel():void
		{
			injector.mapSingleton(LoaderService);
			injector.mapSingleton(NavigationModel);
			injector.mapSingleton(SoundModel);
			
			injector.mapSingleton(DollsModel);
			injector.mapSingleton(ClothesModel);
			injector.mapSingleton(OutfitsModel);
			injector.mapSingleton(LocationsModel);
			injector.mapSingleton(PatternsModel);
			injector.mapSingleton(CustomClothesModel);
			injector.mapSingleton(PhotoModel);
			
			injector.mapSingleton(StorageService);
			injector.mapSingleton(TrackingService);
		}
		
		private function createView():void
		{
			mediatorMap.mapView(StartView, StartMediator, AbstractView);
			mediatorMap.mapView(HomeView, HomeMediator, AbstractView);
			mediatorMap.mapView(DressUpView, DressUpMediator, AbstractView);
			mediatorMap.mapView(DesignStudioView, DesignStudioMediator, AbstractView);
			mediatorMap.mapView(PhotoshootView, PhotoshootMediator, AbstractView);
			
			mediatorMap.mapView(MenuView, MenuMediator);
			
			mediatorMap.mapView(TransitionView, TransitionMediator);
			
			mediatorMap.mapView(SettingsOverlayView, SettingsOverlayMediator, AbstractView);
			mediatorMap.mapView(HelpOverlayView, HelpOverlayMediator, AbstractView);
			mediatorMap.mapView(SkinAndNameOverlayView, SkinAndNameOverlayMediator, AbstractView);
			mediatorMap.mapView(OutfitOverlayView, OutfitOverlayMediator, AbstractView);
			mediatorMap.mapView(DollsOverlayView, DollsOverlayMediator, AbstractView);
			mediatorMap.mapView(LocationsOverlayView, LocationsOverlayMediator, AbstractView);
			
			mediatorMap.mapView(WarningMessagingView, WarningMessagingMediator, AbstractView);
			
			mediatorMap.mapView(CheatView, CheatMediator);
		}
		
		private function createCommands():void
		{
			// loader
			commandMap.mapEvent(LoaderServiceEvent.LOAD, LoaderServiceCommand);
			commandMap.mapEvent(LoaderServiceEvent.LOAD_COMPLETE, LoaderServiceCommand);
			
			// navigation
			commandMap.mapEvent(NavigationEvent.REQUEST_ADDRESS, NavigationCommand);
			commandMap.mapEvent(NavigationEvent.REQUEST_DEACTIVATE_ADDRESS, NavigationCommand);
			commandMap.mapEvent(NavigationEvent.REQUEST_ACTIVATE_ADDRESS, NavigationCommand);
			commandMap.mapEvent(NavigationEvent.REQUEST_OVERLAY, NavigationCommand);
			commandMap.mapEvent(NavigationEvent.REQUEST_MESSAGING, NavigationCommand);
			
			// sound
			commandMap.mapEvent(SoundEvent.REQUEST_MUSIC_TOGGLE, SoundCommand);
			commandMap.mapEvent(SoundEvent.REQUEST_SOUND_TOGGLE, SoundCommand);
			commandMap.mapEvent(SoundEvent.REQUEST_TOGGLE, SoundCommand);
			commandMap.mapEvent(SoundEvent.REQUEST_UPDATE, SoundCommand);
			commandMap.mapEvent(SoundEvent.REQUEST_PLAY_SOUND, SoundCommand);
			
			// dolls
			commandMap.mapEvent(DollsEvent.REQUEST_DOLL, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_PREVIOUS_DOLL, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_NEXT_DOLL, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_CATEGORY, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_PREVIOUS_CATEGORY, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_NEXT_CATEGORY, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_UPDATE_NAME, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_UPDATE_SKIN, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_ADD_CLOTH, DollsCommand);
			commandMap.mapEvent(DollsEvent.REQUEST_REMOVE_CLOTH, DollsCommand);
			
			// clothes, outfits
			commandMap.mapEvent(ClothesEvent.PARSE_XML, ClothesCommand);
			commandMap.mapEvent(ClothesEvent.REQUEST_CLOTH, ClothesCommand);
			commandMap.mapEvent(ClothesEvent.REQUEST_CLOTHES, ClothesCommand);
			
			commandMap.mapEvent(OutfitsEvent.PARSE_XML, OutfitsCommand);
			commandMap.mapEvent(OutfitsEvent.REQUEST_OUTFIT_UNLOCK, OutfitsCommand);
			/*commandMap.mapEvent(OutfitsEvent.REQUEST_OUTFIT, OutfitsCommand);
			commandMap.mapEvent(OutfitsEvent.REQUEST_OUTFITS, OutfitsCommand);*/
			
			// photoshoot
			commandMap.mapEvent(LocationsEvent.PARSE_XML, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.PARSE_UNLOCKED, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.REQUEST_LOCATION, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.REQUEST_LOCATIONS, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.REQUEST_PREVIOUS_LOCATIONS, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.REQUEST_NEXT_LOCATIONS, LocationsCommand);
			commandMap.mapEvent(LocationsEvent.REQUEST_LOCATION_UNLOCK, LocationsCommand);
			
			commandMap.mapEvent(PhotoEvent.REQUEST_PHOTOS, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_PREVIOUS_PHOTOS, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_NEXT_PHOTOS, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_PHOTO, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_ADD_PHOTO, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_REMOVE_PHOTO, PhotoCommand);
			commandMap.mapEvent(PhotoEvent.REQUEST_PRINT, PhotoCommand);
			
			// custom clothes
			commandMap.mapEvent(PatternsEvent.PARSE_XML, PatternsCommand);
			commandMap.mapEvent(PatternsEvent.REQUEST_NEXT, PatternsCommand);
			commandMap.mapEvent(PatternsEvent.REQUEST_PREVIOUS, PatternsCommand);
			
			commandMap.mapEvent(CustomClothesEvent.REQUEST_CREATE, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_EDIT, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_COMPLETE, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_PATTERN_UPDATE, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_MATERIAL_UPDATE, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_COLOUR_UPDATE, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_STAMP_ADD, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_UNDO, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_REDO, CustomClothesCommand);
			commandMap.mapEvent(CustomClothesEvent.REQUEST_CLEAR, CustomClothesCommand);
			
			// storage service
			commandMap.mapEvent(StorageServiceEvent.REQUEST_SAVE, StorageServiceCommand);
			commandMap.mapEvent(StorageServiceEvent.REQUEST_RESTORE, StorageServiceCommand);
			commandMap.mapEvent(StorageServiceEvent.RESTORE, StorageServiceCommand);
			commandMap.mapEvent(StorageServiceEvent.REQUEST_RESET, StorageServiceCommand);
			commandMap.mapEvent(StorageServiceEvent.RESET, StorageServiceCommand);
			
			// tracking service
			commandMap.mapEvent(TrackingServiceEvent.CREATE, TrackingServiceCommand);
			commandMap.mapEvent(TrackingServiceEvent.TRACK_EVENT, TrackingServiceCommand);
			commandMap.mapEvent(TrackingServiceEvent.TRACK_PAGEVIEW, TrackingServiceCommand);
		}
	}
}