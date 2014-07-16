/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.model.NavigationModel;

	import org.robotlegs.mvcs.Command;
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
		
	
	public class NavigationCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var navigationEvent:NavigationEvent;
		
		[Inject]
		public var navigationModel:NavigationModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(navigationEvent.type)
			{
				case NavigationEvent.REQUEST_ADDRESS:
					navigationModel.requestAddress(navigationEvent.address, navigationEvent.transition);
					break;
					
				case NavigationEvent.REQUEST_DEACTIVATE_ADDRESS:
					navigationModel.requestDeactivateAddress();
					break;
					
				case NavigationEvent.REQUEST_ACTIVATE_ADDRESS:
					navigationModel.requestActivateAddress();
					break;	
					
				case NavigationEvent.REQUEST_OVERLAY:
					navigationModel.requestOverlay(navigationEvent.overlay);
					break;
					
				case NavigationEvent.REQUEST_MESSAGING:
					navigationModel.requestMessaging(navigationEvent.messaging);
					break;		
			}
		}
	}
}