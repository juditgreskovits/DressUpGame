/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.SoundModel;

	import org.robotlegs.mvcs.Command;
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
		
	
	public class SoundCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var soundEvent:SoundEvent;
		
		[Inject]
		public var soundModel:SoundModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(soundEvent.type)
			{
				case SoundEvent.REQUEST_MUSIC_TOGGLE:
					soundModel.musicOn = !soundModel.musicOn;
					dispatch(EventFactory.updateSound(soundModel.musicOn, soundModel.soundOn));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;
				
				case SoundEvent.REQUEST_SOUND_TOGGLE:
					soundModel.soundOn = !soundModel.soundOn;
					dispatch(EventFactory.updateSound(soundModel.musicOn, soundModel.soundOn));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;
					
				case SoundEvent.REQUEST_TOGGLE:
					var on:Boolean = !soundModel.musicOn && !soundModel.soundOn;
					soundModel.musicOn = on;
					soundModel.soundOn = on;
					dispatch(EventFactory.updateSound(soundModel.musicOn, soundModel.soundOn));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;	
					
				case SoundEvent.REQUEST_UPDATE:
					dispatch(EventFactory.updateSound(soundModel.musicOn, soundModel.soundOn));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;	
					
				case SoundEvent.REQUEST_PLAY_SOUND:
					soundModel.playSound(soundEvent.soundId, soundEvent.soundType);
					break;
				
			}
		}
	}
}