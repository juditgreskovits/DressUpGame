/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.utils.SoundBehaviour;

	import org.robotlegs.mvcs.Actor;

	import flash.media.SoundTransform;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	
	public class SoundModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _musicOn:Boolean;
		private var _soundOn:Boolean;
		
		private var _musicTransform:SoundTransform;
		private var _soundTransform:SoundTransform;
		
		private var _music:Vector.<SoundBehaviour>;
		private var _sounds:Vector.<SoundBehaviour>;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SoundModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set musicOn(value:Boolean):void
		{
			if(_musicOn != value || !_musicTransform)
			{
				_musicOn = value;
				
				if(!_musicTransform) _musicTransform = new SoundTransform();
				_musicTransform.volume = _musicOn ? 1 : 0;
				
				if(_music)
				{
					var music:SoundBehaviour;
					for each (music in _music)
					{
						music.updateVolume(_musicTransform);
					}
				}
			}
		}
		
		public function get musicOn():Boolean
		{
			return _musicOn;
		}
		
		public function set soundOn(value:Boolean):void
		{
			if(_soundOn != value || !_soundTransform)
			{
				_soundOn = value;
				
				if(!_soundTransform) _soundTransform = new SoundTransform();
				_soundTransform.volume = _soundOn ? 1 : 0;
				
				if(_sounds)
				{
					var sound:SoundBehaviour;
					for each (sound in _sounds)
					{
						sound.updateVolume(_soundTransform);
					}
				}
			}
		}
		
		public function get soundOn():Boolean
		{
			return _soundOn;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function playSound(soundId:String, soundType:String):void
		{
			if(soundType == GlobalConstants.SOUND_TYPE_EFFECT)
			{
				if(!_sounds) _sounds = new Vector.<SoundBehaviour>();
				var sound:SoundBehaviour = new SoundBehaviour(soundId, _soundTransform, onSoundComplete);
				_sounds.push(sound);
			}
			else if(soundType == GlobalConstants.SOUND_TYPE_MUSIC)
			{
				if(!_music) _music = new Vector.<SoundBehaviour>();
				var music:SoundBehaviour = new SoundBehaviour(soundId, _musicTransform, null, 999);
				_music.push(music);
			}
		}
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onSoundComplete(soundId:String):void
		{
			var i:uint, l:uint = _sounds.length;
			var sound:SoundBehaviour;
			for(; i<l; i++)
			{
				sound = _sounds[i];
				if(sound.soundId == soundId)
				{
					_sounds.splice(i, 1);
					sound.destroy();
					break;
				}
			}
		}
	}
}