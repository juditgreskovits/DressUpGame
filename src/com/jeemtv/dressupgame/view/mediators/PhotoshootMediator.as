/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.PhotoEvent;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.view.views.PhotoshootView;
	import com.jeemtv.dressupgame.events.DollsEvent;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	
	public class PhotoshootMediator extends AbstractAddressMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PhotoshootMediator()
		{
			super(NavigationConstants.ADDRESS_PHOTOSHOOT);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			eventMap.mapListener(eventDispatcher, LocationsEvent.LOCATION, onLocation);
			eventMap.mapListener(eventDispatcher, PhotoEvent.PHOTOS, onPhotos);
			eventMap.mapListener(eventDispatcher, PhotoEvent.PHOTO, onPhoto);
			
			eventMap.mapListener(photoshootView, LocationsEvent.REQUEST_LOCATION, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_PHOTOS, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_PREVIOUS_PHOTOS, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_NEXT_PHOTOS, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_PHOTO, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_ADD_PHOTO, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_REMOVE_PHOTO, dispatch);
			eventMap.mapListener(photoshootView, PhotoEvent.REQUEST_PRINT, dispatch);
			eventMap.mapListener(photoshootView, ClothesEvent.REQUEST_CLOTHES, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			eventMap.unmapListener(eventDispatcher, LocationsEvent.LOCATION, onLocation);
			eventMap.unmapListener(eventDispatcher, PhotoEvent.PHOTOS, onPhotos);
			eventMap.unmapListener(eventDispatcher, PhotoEvent.PHOTO, onPhoto);
			
			eventMap.unmapListener(photoshootView, LocationsEvent.REQUEST_LOCATION, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_PHOTOS, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_PREVIOUS_PHOTOS, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_NEXT_PHOTOS, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_PHOTO, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_ADD_PHOTO, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_REMOVE_PHOTO, dispatch);
			eventMap.unmapListener(photoshootView, PhotoEvent.REQUEST_PRINT, dispatch);
			eventMap.unmapListener(photoshootView, ClothesEvent.REQUEST_CLOTHES, dispatch);
			
			super.onRemove();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onDoll(evt:DollsEvent):void
		{
			photoshootView.updateDoll(evt.doll);
		}
		
		private function onLocation(evt:LocationsEvent):void
		{
			photoshootView.updateLocation(evt.location);
		}
		
		private function onPhotos(evt:PhotoEvent):void
		{
			photoshootView.updatePhotos(evt.photos, evt.hasNextAndPrevious);
		}
		
		private function onPhoto(evt:PhotoEvent):void
		{
			photoshootView.updateLocation(evt.photo.location);
			photoshootView.updateDoll(evt.photo.doll);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get photoshootView():PhotoshootView
		{
			return abstractView as PhotoshootView;
		}
	}
}