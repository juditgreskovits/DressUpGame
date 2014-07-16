/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 16, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PhotoVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _id:String;
		private var _doll:DollVO;
		private var _location:LocationVO;
		private var _thumbBmpd:BitmapData;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PhotoVO(id:String)
		{
			super();
			
			_id = id;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get id():String { return _id; }
		
		public function set doll(value:DollVO):void { _doll = value; }
		public function get doll():DollVO { return _doll; }
		
		public function set location(value:LocationVO):void { _location = value; }
		public function get location():LocationVO { return _location; }
		
		public function set thumbBmpd(value:BitmapData):void { _thumbBmpd = value; }
		public function get thumbBmpd():BitmapData { return _thumbBmpd; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getThumbBmp():Bitmap
		{
			var bmp:Bitmap = new Bitmap(_thumbBmpd);
			bmp.smoothing = true;
			return bmp;
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
		
	}
}