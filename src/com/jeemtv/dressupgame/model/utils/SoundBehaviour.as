/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 13, 2013
 */
package com.jeemtv.dressupgame.model.utils
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class SoundBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _soundId:String;
		
		private var _channel:SoundChannel;
		private var _soundCompleteFunction:Function;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SoundBehaviour(soundId:String, soundTransform:SoundTransform, soundCompleteFunction:Function, loops:uint=0)
		{
			super();
			
			_soundId = soundId;
			_soundCompleteFunction = soundCompleteFunction;
			
			create(loops, soundTransform);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get soundId():String
		{
			return _soundId;
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateVolume(soundTransform:SoundTransform):void
		{
			_channel.soundTransform = soundTransform;
		}
		
		public function destroy():void
		{
			_channel = null;
			_soundCompleteFunction = null;
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function create(loops:uint, soundTransform:SoundTransform):void
		{
			var soundClass:Class = getDefinitionByName(_soundId) as Class; 
			var sound:Sound = new soundClass();
			_channel = sound.play(0, loops, soundTransform);
			if(_soundCompleteFunction) _channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function onSoundComplete(evt:Event):void
		{
			_soundCompleteFunction(_soundId);
		}
	}
}