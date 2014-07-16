/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.events
{
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class StorageServiceEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const REQUEST_SAVE:String = "requestSave";
		public static const SAVE:String = "save";
		public static const SAVE_ERROR:String = "saveError";
		
		public static const REQUEST_RESTORE:String = "requestRestore";
		public static const RESTORE:String = "restore";
		
		public static const REQUEST_RESET:String = "requestReset";
		public static const RESET:String = "reset";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _data:Object;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function StorageServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set data(value:Object):void { _data = value; }
		public function get data():Object { return _data; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:StorageServiceEvent = new StorageServiceEvent (type, bubbles, cancelable);
			evt.data = _data;
			return evt;
		}
		
	}
	
}