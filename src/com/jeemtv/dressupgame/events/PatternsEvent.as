 /**
  * @author juditgreskovits
  * @version 0.1
  * @since Aug 29, 2013
  */
 package com.jeemtv.dressupgame.events
{
	import flash.events.Event;
 	
 	//------------------------------------------------------------------------
 	//  IMPORT CLASSES
 	//------------------------------------------------------------------------
 	
 	
 	public class PatternsEvent extends Event
 	{
 		//------------------------------------------------------------------------
 		//  PUBLIC STATIC CONSTANTS
 		//------------------------------------------------------------------------
 		
 		public static const PARSE_XML:String = "parsePatternsXML";
		
		public static const REQUEST_NEXT:String = "requestNextPattern";
		public static const REQUEST_PREVIOUS:String = "requestPreviousPattern";
 		
 		//------------------------------------------------------------------------
 		//  PRIVATE PROPERTIES
 		//------------------------------------------------------------------------
 		
 		//------------------------------------------------------------------------
 		//  CONSTRUCTOR
 		//------------------------------------------------------------------------
 		
 		public function PatternsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
 		{
 			super(type, bubbles, cancelable);
 		}
 		
 		//------------------------------------------------------------------------
 		//  GETTERS & SETTERS
 		//------------------------------------------------------------------------
 		
 		//------------------------------------------------------------------------
 		//  PUBLIC OVERRIDE METHODS
 		//------------------------------------------------------------------------
 		
 		override public function clone():Event
 		{
 			var evt:PatternsEvent = new PatternsEvent(type, bubbles, cancelable);
 			return evt;
 		}
 		
 	}
 	
 }