/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 3, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DollUtil
	{
		
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function createDoll(asset:MovieClip, doll:DollVO, photoShoot:Boolean=false):Sprite
		{
			var frame:uint = 3*(doll.id - 1) + doll.skin;
			asset.gotoAndStop(frame);
			
			asset.getChildAt(0).visible = photoShoot;
			asset.getChildAt(1).visible = !photoShoot;
			
			var cloth:AbstractClothVO, category:uint, depth:uint;
			for each (category in GlobalConstants.OUTFIT_CATEGORIES)
			{
				cloth = doll.getCloth(category);
				depth = category == GlobalConstants.CATEGORY_ACCESSORY || category == GlobalConstants.CATEGORY_TOP ?
					asset.numChildren : 3;
				if(cloth) asset.addChildAt(cloth.getAssetOnDoll(), depth);
			}
			return asset;
		}
	}
}
