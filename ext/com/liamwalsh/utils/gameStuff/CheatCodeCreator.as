package com.liamwalsh.utils.gameStuff {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * @author evil_liam
	 */
		public class CheatCodeCreator extends EventDispatcher {
		private var _stage : Stage;
		private var _cheatCodes : Vector.<CheatCode>;
		
		public function CheatCodeCreator($stage : Stage) {
			_stage = $stage;
			privateInit();
		}
		
		private function privateInit() : void {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress, false, 0, true);
			_cheatCodes = new Vector.<CheatCode>();
		}
		
		private function onKeyPress($event : KeyboardEvent) : void {
			var $code : uint = $event.charCode;
			var $l : int = _cheatCodes.length;
			for(var i : int = 0; i<$l; i++)
			{
				if(_cheatCodes[i].advance($code))
				{
					dispatchEvent(new Event(_cheatCodes[i].eventType));
					_cheatCodes[i].reset();	
				}
				
			}
		}
		
		public function addCheatCode($cheatCode : String, $eventType : String, $callback : Function) : void {
			_cheatCodes.push(new CheatCode($cheatCode, $eventType, $callback));
			addEventListener($eventType, $callback, false, 0, true);	
		}

		public function destroy() : void {
			for(var i : int = 0; i<_cheatCodes.length; i++)
			{
				removeEventListener(_cheatCodes[i].eventType, _cheatCodes[i].callback);
			}
		}
	}
}

internal class CheatCode {
	private var _cheatCode : String;
	private var _eventType : String;
	private var _index : int = 0;
	public var callback : Function;
	
	public function CheatCode($code : String, $eventType : String, $callback : Function) {
		_cheatCode = $code;
		_eventType = $eventType;
		callback = $callback;
	}
	
	public function advance($charCode : int) : Boolean {
		if($charCode == _cheatCode.charCodeAt(_index))
		{
			_index++;
		}
		else{
			_index = 0;
		}
		return _index >= (_cheatCode.length);
	}
	
	public function reset() : void {
		_index = 0;
	}
	
	public function get eventType() : String {
		return _eventType;
	}
	
}
