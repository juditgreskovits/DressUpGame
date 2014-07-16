 /**
  * @author juditgreskovits
  * @version 0.1
  * @since Aug 29, 2013
  */
 package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.PatternsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.PatternsModel;
	import com.jeemtv.dressupgame.model.vo.PatternVO;

	import org.robotlegs.mvcs.Command;
 	
 	//------------------------------------------------------------------------
 	//  IMPORTS
 	//------------------------------------------------------------------------
 	
 	
 	public class PatternsCommand extends Command
 	{
 		
 		//------------------------------------------------------------------------
 		//  INJECTED PROPERTIES
 		//------------------------------------------------------------------------
 		
 		[Inject]
 		public var patternsEvent:PatternsEvent;
		
		[Inject]
 		public var patternsModel:PatternsModel;
		
		[Inject]
 		public var dollsModel:DollsModel;
 		
 		//------------------------------------------------------------------------
 		//  PUBLIC OVERRIDE METHODS
 		//------------------------------------------------------------------------
 		
 		override public function execute():void
 		{
 			switch(patternsEvent.type)
 			{
 				case PatternsEvent.PARSE_XML:
					patternsModel.parseXML();
 					break;
					
				case PatternsEvent.REQUEST_NEXT:
					var pattern:PatternVO = patternsModel.nextPattern(dollsModel.id);
					dispatch(EventFactory.requestPattern(pattern));
 					break;
					
				case PatternsEvent.REQUEST_PREVIOUS:
					var pattern:PatternVO = patternsModel.previousPattern(dollsModel.id);
					dispatch(EventFactory.requestPattern(pattern));
 					break;		
 			}
 		}
 	}
 }
