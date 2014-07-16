/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.events
{
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class LoaderServiceEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const LOAD:String = "load";
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _lang:String;
		private var _configurationXMLPath:String;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function LoaderServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set lang(value:String):void { _lang = value; }
		public function get lang():String { return _lang; }
		
		public function set configurationXMLPath(value:String):void { _configurationXMLPath = value; }
		public function get configurationXMLPath():String { return _configurationXMLPath; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:LoaderServiceEvent = new LoaderServiceEvent (type, bubbles, cancelable);
			evt.lang = _lang;
			evt.configurationXMLPath = _configurationXMLPath;
			return evt;
		}
		
	}
	
}