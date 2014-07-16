/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothVO extends AbstractClothVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		private var _pattern:PatternVO;
		private var _material:uint;
		private var _colour:uint;
		private var _stamps:Vector.<StampVO>;
		
		private var _customClothBmp:Bitmap;
		private var _hangerBmpd:BitmapData;
		private var _dollBmpd:BitmapData;
		private var _hangerBmpPosition:Point;
		private var _dollBmpPosition:Point;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CustomClothVO(id:String)
		{
			super(id);
			
			unlocked = true;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set pattern(value:PatternVO):void { _pattern = value; }
		public function get pattern():PatternVO { return _pattern; }
		
		public function set material(value:uint):void { _material = value; }
		public function get material():uint { return _material; }
		
		public function set colour(value:uint):void { _colour = value; }
		public function get colour():uint { return _colour; }
		
		public function set stamps(value:Vector.<StampVO>):void { _stamps = value; }
		public function get stamps():Vector.<StampVO> { return _stamps; }
		
		public function set customClothBmp(value:Bitmap):void { _customClothBmp = value; }
		public function get customClothBmp():Bitmap { return _customClothBmp; }
		
		public function set hangerBmpd(value:BitmapData):void { _hangerBmpd = value; }
		public function get hangerBmpd():BitmapData { return _hangerBmpd; }
		
		public function set dollBmpd(value:BitmapData):void { _dollBmpd = value; }
		public function get dollBmpd():BitmapData { return _dollBmpd; }
		
		public function set hangerBmpPosition(value:Point):void { _hangerBmpPosition = value; }
		public function get hangerBmpPosition():Point { return _hangerBmpPosition; }
		
		public function set dollBmpPosition(value:Point):void { _dollBmpPosition = value; }
		public function get dollBmpPosition():Point { return _dollBmpPosition; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function getAssetOnHanger():Sprite
		{
			var bmp:Bitmap = new Bitmap(_hangerBmpd);
			bmp.smoothing = true;
			var asset:Sprite = new Sprite();
			asset.addChild(bmp);
			bmp.x = _hangerBmpPosition.x;
			return asset;
		}
		
		override public function getAssetOnDoll():Sprite
		{
			var bmp:Bitmap = new Bitmap(_dollBmpd);
			bmp.smoothing = true;
			var asset:Sprite = new Sprite();
			asset.addChild(bmp);
			bmp.x = _dollBmpPosition.x;
			bmp.y = _dollBmpPosition.y;
			return asset;
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function clone():CustomClothVO
		{
			var vo:CustomClothVO = new CustomClothVO(id);
			vo.doll = doll;
			vo.category = category;
			vo.material = _material;
			vo.colour = _colour;
			vo.pattern = _pattern;
			vo.stamps = cloneStamps();
			vo.customClothBmp = _customClothBmp;
			vo.hangerBmpd = _hangerBmpd;
			vo.dollBmpd = _dollBmpd;
			vo.hangerBmpPosition = _hangerBmpPosition;
			vo.dollBmpPosition = _dollBmpPosition;
			return vo;
		}
		
		public function cloneStamps():Vector.<StampVO>
		{
			var s:Vector.<StampVO> = new Vector.<StampVO>();
			var vo:StampVO;
			for each (vo in _stamps)
			{
				s.push(vo);
			}
			return s;
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