/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.LocationsModel;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.vo.LocationVO;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class LocationsCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var locationsEvent:LocationsEvent;
		
		[Inject]
		public var locationsModel:LocationsModel;
		
		[Inject]
		public var outfitsModel:OutfitsModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(locationsEvent.type)
			{
				case LocationsEvent.PARSE_XML:
					locationsModel.parseXML();
					parseUnlocked();
					break;
					
				case LocationsEvent.PARSE_UNLOCKED:
					parseUnlocked();
					break;
					
				case LocationsEvent.REQUEST_LOCATION:
					dispatch(EventFactory.updateLocation(locationsModel.getLocation(locationsEvent.id)));
					break;	
					
				case LocationsEvent.REQUEST_LOCATIONS:
					dispatch(EventFactory.updateLocations(locationsModel.getCurrentLocations()));
					break;	
					
				case LocationsEvent.REQUEST_PREVIOUS_LOCATIONS:
					dispatch(EventFactory.updateLocations(locationsModel.getPreviousLocations()));
					break;	
					
				case LocationsEvent.REQUEST_NEXT_LOCATIONS:
					dispatch(EventFactory.updateLocations(locationsModel.getNextLocations()));
					break;	
					
				case LocationsEvent.REQUEST_LOCATION_UNLOCK:
					var location:LocationVO = locationsModel.unlockLocation(locationsEvent.id);
					dispatch(EventFactory.updateLocation(location));
					break;				
				
			}
		}
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//-----------------------------------------------------------------------
		
		private function parseUnlocked():void
		{
			var location:LocationVO, locations:Vector.<LocationVO> = locationsModel.locations;
			for each(location in locations)
			{
				location.unlocked = !outfitsModel.getOutfitByLocation(location.id);
			}
		}
	}
}