/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.events
{
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class SoundEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
		
		public static const REQUEST_MUSIC_TOGGLE:String = "requestMusicToggle";
		public static const REQUEST_SOUND_TOGGLE:String = "requestSoundToggle";
		public static const REQUEST_TOGGLE:String = "requestToggle";
		
		public static const REQUEST_UPDATE:String = "requestUpdate";
		public static const UPDATE:String = "update";
		
		public static const REQUEST_PLAY_SOUND:String = "playSoud";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _musicOn:Boolean;
		private var _soundOn:Boolean;
		
		private var _soundId:String;
		private var _soundType:String;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function SoundEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set soundId(value:String):void { _soundId = value; }
		public function get soundId():String { return _soundId; }
		
		public function set musicOn(value:Boolean):void { _musicOn = value; }
		public function get musicOn():Boolean { return _musicOn; }
		
		public function set soundOn(value:Boolean):void { _soundOn = value; }
		public function get soundOn():Boolean { return _soundOn; }
		
		public function set soundType(value:String):void { _soundType = value; }
		public function get soundType():String { return _soundType; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:SoundEvent = new SoundEvent (type, bubbles, cancelable);
			evt.musicOn = _musicOn;
			evt.soundOn = _soundOn;
			evt.soundId = _soundId;
			evt.soundType = _soundType;
			return evt;
		}
		
	}
	
}