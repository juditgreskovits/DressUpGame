/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.view.views.LocationsOverlayView;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class LocationsOverlayMediator extends AbstractOverlayMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function LocationsOverlayMediator()
		{
			super(NavigationConstants.OVERLAY_LOCATIONS);
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
			
			eventMap.mapListener(locationsOverlayView, LocationsEvent.REQUEST_LOCATIONS, dispatch);
			eventMap.mapListener(locationsOverlayView, LocationsEvent.REQUEST_PREVIOUS_LOCATIONS, dispatch);
			eventMap.mapListener(locationsOverlayView, LocationsEvent.REQUEST_NEXT_LOCATIONS, dispatch);
			eventMap.mapListener(locationsOverlayView, LocationsEvent.REQUEST_LOCATION, dispatch);
			
			eventMap.mapListener(eventDispatcher, LocationsEvent.LOCATIONS, onLocations);
			eventMap.mapListener(eventDispatcher, LocationsEvent.LOCATION, onLocation);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(locationsOverlayView, LocationsEvent.REQUEST_LOCATIONS, dispatch);
			eventMap.unmapListener(locationsOverlayView, LocationsEvent.REQUEST_PREVIOUS_LOCATIONS, dispatch);
			eventMap.unmapListener(locationsOverlayView, LocationsEvent.REQUEST_NEXT_LOCATIONS, dispatch);
			eventMap.unmapListener(locationsOverlayView, LocationsEvent.REQUEST_LOCATION, dispatch);
			
			eventMap.unmapListener(eventDispatcher, LocationsEvent.LOCATIONS, onLocations);
			eventMap.unmapListener(eventDispatcher, LocationsEvent.LOCATION, onLocation);
			
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
		
		private function onLocations(evt:LocationsEvent):void
		{
			locationsOverlayView.updateLocations(evt.locations);
		}
		
		private function onLocation(evt:LocationsEvent):void
		{
			locationsOverlayView.updateLocation(evt.location.name);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get locationsOverlayView():LocationsOverlayView
		{
			return abstractView as LocationsOverlayView; 
		}
		
	}
}