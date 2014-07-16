/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.OutfitsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.LocationsModel;
	import com.jeemtv.dressupgame.model.OutfitsModel;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.OutfitVO;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class OutfitsCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var outfitsEvent:OutfitsEvent;
		
		[Inject]
		public var outfitsModel:OutfitsModel;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		[Inject]
		public var locationsModel:LocationsModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(outfitsEvent.type)
			{
				case OutfitsEvent.PARSE_XML:
					outfitsModel.parseXML();
					break;
					
				case OutfitsEvent.REQUEST_OUTFIT_UNLOCK:
					var outfit:OutfitVO = outfitsModel.unlockOutfit(outfitsEvent.id, dollsModel.id);
					if(outfit)
					{
						var location:LocationVO = locationsModel.getLocation(outfit.locationId);
						
						outfitsEvent = new OutfitsEvent(OutfitsEvent.OUTFIT_UNLOCKED);
						outfitsEvent.outfit = outfit;
						outfitsEvent.location = location;
						dispatch(outfitsEvent);
						
						dispatch(EventFactory.requestOverlay(NavigationConstants.OVERLAY_OUTFIT));
						dispatch(EventFactory.requestPlaySoundEffect(SoundConstants.OUTFIT_FOUND));
						dispatch(EventFactory.requestLocationUnlock(outfit.locationId));
						
						dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_OUTFIT, TrackingConstants.ACTION_UNLOCKED, outfit.id));
					}
					else dispatch(EventFactory.requestPlaySoundEffect(SoundConstants.OUTFIT_REFOUND));
					break;		
			}
		}
	}
}