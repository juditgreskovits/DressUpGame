/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 17, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.geom.Matrix;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import flash.display.Sprite;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PhotoUtil
	{
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function createPhoto(asset:MovieClip, doll:DollVO, location:LocationVO):MovieClip
		{
			asset.addChildAt(location.getAsset(), 0);
			DollUtil.createDoll(asset.doll, doll, true);
			return asset;
		}
		
		public static function createThumb(asset:MovieClip, doll:DollVO, location:LocationVO):BitmapData
		{
			var photo:Sprite = createPhoto(asset, doll, location);
			var scale:Point = new Point(GlobalConstants.PHOTO_THUMB_SIZE.x/photo.width, GlobalConstants.PHOTO_THUMB_SIZE.y/photo.height);
			var bmpd:BitmapData = new BitmapData(GlobalConstants.PHOTO_THUMB_SIZE.x, GlobalConstants.PHOTO_THUMB_SIZE.y);
			var matrix:Matrix = new Matrix(scale.x, 0, 0, scale.y)
			bmpd.draw(photo, matrix);
			return bmpd;
		}
	}
}