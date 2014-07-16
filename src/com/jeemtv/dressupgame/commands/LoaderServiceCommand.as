/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.LoaderServiceEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.model.LoaderService;

	import org.robotlegs.mvcs.Command;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class LoaderServiceCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var loaderEvent:LoaderServiceEvent;
		
		[Inject]
		public var loaderService:LoaderService;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(loaderEvent.type)
			{
				case LoaderServiceEvent.LOAD:
					loaderService.load(loaderEvent.configurationXMLPath, loaderEvent.lang);
					break;
					
				case LoaderServiceEvent.LOAD_COMPLETE:
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_RESTORE));
					break;	
				
			}
		}
	}
}