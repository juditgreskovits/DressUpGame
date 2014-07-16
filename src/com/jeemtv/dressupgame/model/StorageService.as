/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.events.SoundEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObjectFlushStatus;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.net.SharedObject;
	import com.hurlant.util.Base64;
	import flash.utils.ByteArray;
	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class StorageService extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _so:SharedObject;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function StorageService()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function restore():void
		{
			if(!_so) _so = SharedObject.getLocal(GlobalConstants.SHARED_OBJECT_NAME);
			if(_so.data.data)
			{
				var s:String = _so.data.data;
				var ba:ByteArray = Base64.decodeToByteArray(s);
				ba.uncompress();
				var data:Object = ba.readObject();
				
				var storageServiceEvent:StorageServiceEvent = new StorageServiceEvent(StorageServiceEvent.RESTORE);
				storageServiceEvent.data = data;
				dispatch(storageServiceEvent);
			}
			else dispatch(new StorageServiceEvent(StorageServiceEvent.RESTORE));
			
			dispatch(EventFactory.requestPlayMusic(SoundConstants.MUSIC_LOOP));
			dispatch(new SoundEvent(SoundEvent.REQUEST_UPDATE));
		}
		
		// dolls + clothes 
		// custom clothes
		// unlocked outfits
		// photos
		public function save(data:Object):void
		{
			// convert to ByteArray
			var ba:ByteArray = new ByteArray();
			ba.writeObject(data);
			// compress
			ba.compress();
			var s:String = Base64.encodeByteArray(ba);
			// write to SO
			if(!_so) _so = SharedObject.getLocal(GlobalConstants.SHARED_OBJECT_NAME);
			_so.data.data = s;
			
			// test 
			var test:ByteArray = new ByteArray();
			test.writeUTFBytes(s);
			trace("****** " + test.length*0.000976562 + " ******");
			
			var status:String;
			try { status = _so.flush(); }
			catch (err:Error) { trace("StorageService.save ERROR"); }
			if(status)
			{
				switch(status)
				{
					case SharedObjectFlushStatus.PENDING:
						_so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;
						
					case SharedObjectFlushStatus.PENDING:
						dispatch(new StorageServiceEvent(StorageServiceEvent.SAVE));
						break;	
				}
			}
		}
		
		public function reset():void
		{
			SharedObject.getLocal(GlobalConstants.SHARED_OBJECT_NAME).clear();
			dispatch(new StorageServiceEvent(StorageServiceEvent.RESET));
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
		
		private function onFlushStatus(evt:NetStatusEvent):void
		{
			_so.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
			
			switch(evt.info.code)
			{
				case "SharedObject.Flush.Success":
                    dispatch(new StorageServiceEvent(StorageServiceEvent.SAVE));
                    break;
					
                case "SharedObject.Flush.Failed":
                    dispatch(new StorageServiceEvent(StorageServiceEvent.SAVE_ERROR));
                    break;
			}
		}
	}
}