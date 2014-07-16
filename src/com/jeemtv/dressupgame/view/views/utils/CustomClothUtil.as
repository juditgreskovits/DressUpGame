/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 2, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothUtil
	{
		
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function create(vo:CustomClothVO):MovieClip
		{
			var asset:CustomCloth_design = new CustomCloth_design();
			asset.gotoAndStop(vo.material);
			var colourTransform:ColorTransform = new ColorTransform();
			colourTransform.color = vo.colour;
			asset.colour.transform.colorTransform = colourTransform;
			var stamps:Sprite = asset.addChild(new Sprite()) as Sprite;
			var stamp:StampVO;
			for each(stamp in vo.stamps)
			{
				addStamp(stamp, colourTransform, stamps);
			}
			
			var patternClass:Class = getDefinitionByName(vo.pattern.assetClassName) as Class;
			var pattern:MovieClip = new patternClass() as MovieClip;
			
			pattern.patternOutline.visible = false;
			
			pattern.addChildAt(asset, 1);
			asset.scaleX = asset.scaleY = 1/GlobalConstants.PATTERN_SCALE;
			asset.x = pattern.patternMask.x + (pattern.patternMask.width - asset.width)*0.5;
			asset.y = pattern.patternMask.y + (pattern.patternMask.height - asset.height)*0.5;
			asset.mask = pattern.patternMask;
			return pattern;
		}
		
		public static function createCustomClothBitmap(pattern:MovieClip):Bitmap
		{
			pattern.hanger.visible = false;
			
			var mask:Sprite = pattern.patternMask as Sprite;
			var scale:Number = GlobalConstants.PATTERN_SCALE;
			var bmpd:BitmapData = new BitmapData(mask.width*scale, mask.height*scale, true, 0x00000000);
			var matrix:Matrix = new Matrix(scale, 0, 0, scale, -mask.x*scale, -mask.y*scale);
			bmpd.draw(pattern, matrix);
			var bmp:Bitmap = new Bitmap(bmpd);
			bmp.smoothing = true;
			return bmp;
		}
		
		public static function createHangerBmpd(pattern:MovieClip):BitmapData
		{
			pattern.hanger.visible = true;
			
			var hanger:Sprite = pattern.hanger;
			var mask:Sprite = pattern.patternMask as Sprite;
			var scale:Number = 1;
			var bounds:Rectangle = new Rectangle();
			bounds.x = Math.min(hanger.x, mask.x);
			bounds.y = Math.min(hanger.y, mask.y);
			bounds.width = Math.max(hanger.width, mask.width);
			bounds.height = mask.y + mask.height - hanger.y;
			var bmpd:BitmapData = new BitmapData(bounds.width*scale, bounds.height*scale, true, 0x00000000);
			var matrix:Matrix = new Matrix(scale, 0, 0, scale, -bounds.x*scale, -bounds.y*scale);
			bmpd.draw(pattern, matrix);
			return bmpd;
		}
		
		public static function getHangerBmpPosition(pattern:MovieClip):Point
		{
			var hanger:Sprite = pattern.hanger;
			var hangerBounds:Rectangle = hanger.getBounds(hanger);
			return new Point(hangerBounds.x, hangerBounds.y);
		}
		
		public static function createDollBmpd(pattern:MovieClip):BitmapData
		{
			pattern.hanger.visible = false;
			
			var mask:Sprite = pattern.patternMask as Sprite;
			var scale:Number = 1;
			var bmpd:BitmapData = new BitmapData(mask.width*scale, mask.height*scale, true, 0x00000000);
			var matrix:Matrix = new Matrix(scale, 0, 0, scale, -mask.x, -mask.y);
			bmpd.draw(pattern, matrix);
			return bmpd;
		}
		
		public static function getDollBmpPosition(pattern:MovieClip):Point
		{
			var mask:Sprite = pattern.patternMask as Sprite;
			return new Point(mask.x, mask.y);
		}
		
		public static function addStamp(vo:StampVO, colourTransform:ColorTransform, stamps:Sprite):void
		{
			var stamp:Stamps_design = getStamp(vo, colourTransform);
			stamp.x = vo.position.x;
			stamp.y = vo.position.y;
			stamps.addChild(stamp);
		}
		
		public static function getStamp(vo:StampVO, colourTransform:ColorTransform=null):Stamps_design
		{
			var stamp:Stamps_design = new Stamps_design();
			stamp.gotoAndStop(vo.id);
			if(!colourTransform) colourTransform = new ColorTransform();
			colourTransform.color = vo.colour;
			stamp.scaleX = stamp.scaleY = GlobalConstants.STAMP_SCALE;
			stamp.transform.colorTransform = colourTransform;
			return stamp;
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
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