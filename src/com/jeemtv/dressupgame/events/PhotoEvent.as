/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 16, 2013
 */
package com.jeemtv.dressupgame.events
{
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import flash.display.Sprite;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	
	//------------------------------------------------------------------------
	//  IMPORT CLASSES
	//------------------------------------------------------------------------
	
	import flash.events.Event;
	
	public class PhotoEvent extends Event
	{
		//------------------------------------------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//------------------------------------------------------------------------
	
		public static const REQUEST_PHOTOS:String = "requestPhotos";
		public static const REQUEST_PREVIOUS_PHOTOS:String = "requestPreviousPhotos";
		public static const REQUEST_NEXT_PHOTOS:String = "requestNextPhotos";
		public static const PHOTOS:String = "photos";
		
		public static const REQUEST_PHOTO:String = "requestPhoto";
		public static const PHOTO:String = "photo";
	
		public static const REQUEST_ADD_PHOTO:String = "requestAddPhoto";
		public static const REQUEST_REMOVE_PHOTO:String = "requestRemovePhoto";
		public static const REQUEST_PRINT:String = "requestPrint";
		
		//------------------------------------------------------------------------
		//  PRIVATE PROPERTIES
		//------------------------------------------------------------------------
		
		private var _photos:Vector.<PhotoVO>;
		private var _hasNextAndPrevious:Boolean;
		private var _photo:PhotoVO;
		private var _id:String;
		private var _index:uint;
		private var _doll:DollVO;
		private var _print:Sprite;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function PhotoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------
		//  GETTERS & SETTERS
		//------------------------------------------------------------------------	
		
		public function set photos(value:Vector.<PhotoVO>):void { _photos = value; }
		public function get photos():Vector.<PhotoVO> { return _photos; }
		
		public function set hasNextAndPrevious(value:Boolean):void { _hasNextAndPrevious = value; }
		public function get hasNextAndPrevious():Boolean { return _hasNextAndPrevious; }
		
		public function set photo(value:PhotoVO):void { _photo = value; }
		public function get photo():PhotoVO { return _photo; }
		
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }
		
		public function set index(value:uint):void { _index = value; }
		public function get index():uint { return _index; }
		
		public function set doll(value:DollVO):void { _doll = value; }
		public function get doll():DollVO { return _doll; }
		
		public function set print(value:Sprite):void { _print = value; }
		public function get print():Sprite { return _print; }
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function clone():Event
		{
			var evt:PhotoEvent = new PhotoEvent (type, bubbles, cancelable);
			evt.photos = _photos;
			evt.hasNextAndPrevious = _hasNextAndPrevious;
			evt.photo = _photo;
			evt.id = _id;
			evt.index = _index;
			evt.doll = _doll;
			evt.print = _print;
			return evt;
		}
		
	}
	
}