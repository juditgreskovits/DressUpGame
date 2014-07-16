/**
 * @author juditgreskovits
 * @version 0.1
 * @since Oct 3, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.TrackingServiceEvent;
	import com.jeemtv.dressupgame.model.TrackingService;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class TrackingServiceCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var trackingServiceEvent:TrackingServiceEvent;
		
		[Inject]
		public var trackingService:TrackingService;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(trackingServiceEvent.type)
			{
				case TrackingServiceEvent.CREATE:
					// trackingService.create(contextView, trackingServiceEvent.account);
					trackingService.create(trackingServiceEvent.tracker);
					break;
					
				case TrackingServiceEvent.TRACK_EVENT:
					trackingService.trackEvent(trackingServiceEvent.category, trackingServiceEvent.action, trackingServiceEvent.label, trackingServiceEvent.value);
					break;
					
				case TrackingServiceEvent.TRACK_PAGEVIEW:
					trackingService.trackPageView(trackingServiceEvent.pageURL);
					break;		
				
			}
		}
	}
}
