/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.constants
{
	import flash.geom.Point;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class GlobalConstants
	{
		// public static constants

		public static const CONTEXT_MENU_TITLE:String = "JeemTV - Dress up game";

		public static const LOADER_NAME:String = "DressUpGameLoader";
		public static const COPY_LOADER_NAME:String = "copyLoader";
		public static const CLOTHES_LOADER_NAME:String = "clothesLoader";
		public static const OUTFITS_LOADER_NAME:String = "outfitsLoader";
		public static const LOCATIONS_LOADER_NAME:String = "locationsLoader";
		public static const PATTERNS_LOADER_NAME:String = "patternsLoader";
		public static const FONT_LOADER_NAME:String = "fontLoader";
		
		public static const LANGUAGE_ENGLISH:String = "en";
		public static const LANGUAGE_ARABIC:String = "ar";
		
		public static const FONT_ENGLISH:String = "Droid";
		public static const FONT_ARABIC:String = "DroidKufi";
		
		public static const SOUND_TYPE_MUSIC:String = "soundTypeMusic";
		public static const SOUND_TYPE_EFFECT:String = "soundTypeEffect";
		
		public static const SHARED_OBJECT_NAME:String = "JeemTVDressUpGame";
		
		public static const COLOUR_PURPLE:uint = 0x9479A9;
		public static const COLOUR_BRIGHT_PURPLE:uint = 0xAF49ED;
		public static const COLOUR_BLUE:uint = 0x5FB5E2;
		public static const COLOUR_LOCKED:uint = 0x333333;
		public static const COLOUR_PINK:uint = 0xFF66FF;
		public static const COLOUR_BRIGHT_PINK:uint = 0xE274EF;
		
		public static const DOLL_1:uint = 1;
		public static const DOLL_2:uint = 2;
		public static const DOLL_3:uint = 3;
		public static const DOLLS:Vector.<uint> = new <uint>[DOLL_1, DOLL_2, DOLL_3];
		
		public static const CATEGORY_TOP:uint = 1;
		public static const CATEGORY_BOTTOM:uint = 2;
		public static const CATEGORY_SHOES:uint = 3;
		public static const CATEGORY_HEADWEAR:uint = 4;
		public static const CATEGORY_ACCESSORY:uint = 5;
		
		public static const CATEGORY_CUSTOM_TOP:uint = 6;
		public static const CATEGORY_CUSTOM_BOTTOM:uint = 7;
		public static const CATEGORY_CUSTOM_HEADWEAR:uint = 8;
		
		public static const CATEGORY_OUTFITS:uint = 9;
		
		public static const OUTFIT_CATEGORIES:Vector.<uint> = 
			new <uint>[CATEGORY_TOP, CATEGORY_BOTTOM, CATEGORY_SHOES, CATEGORY_HEADWEAR, CATEGORY_ACCESSORY];
			
		public static const CUSTOM_CATEGORIES:Vector.<uint> = 
			new <uint>[CATEGORY_CUSTOM_TOP, CATEGORY_CUSTOM_BOTTOM, CATEGORY_CUSTOM_HEADWEAR];
																	
		public static const CATEGORIES:Vector.<uint> = OUTFIT_CATEGORIES.concat(CUSTOM_CATEGORIES).concat(
			new <uint>[CATEGORY_OUTFITS]);		
			
		public static function customCategoryToCategory(customCategory:uint):uint
		{
			if(customCategory == GlobalConstants.CATEGORY_CUSTOM_TOP) return GlobalConstants.CATEGORY_TOP;
			if(customCategory == GlobalConstants.CATEGORY_CUSTOM_BOTTOM) return GlobalConstants.CATEGORY_BOTTOM;
			if(customCategory == GlobalConstants.CATEGORY_CUSTOM_HEADWEAR) return GlobalConstants.CATEGORY_HEADWEAR;
			return customCategory;
		}
		
		public static function categoryToCustomCategory(category:uint):uint
		{
			if(category == GlobalConstants.CATEGORY_TOP) return GlobalConstants.CATEGORY_CUSTOM_TOP;
			if(category == GlobalConstants.CATEGORY_BOTTOM) return GlobalConstants.CATEGORY_CUSTOM_BOTTOM;
			if(category == GlobalConstants.CATEGORY_HEADWEAR) return GlobalConstants.CATEGORY_CUSTOM_HEADWEAR;
			return category;
		}	
		
		public static const CATEGORY_TYPE_OUTFIT:uint = 0;
		public static const CATEGORY_TYPE_CUSTOM:uint = 1;
		public static const CATEGORY_TYPE_OUTFITS:uint = 2;
		
		public static function getCategoryType(category:uint):uint
		{
			if(category == CATEGORY_OUTFITS) return CATEGORY_TYPE_OUTFITS;
			else if(GlobalConstants.CUSTOM_CATEGORIES.indexOf(category) != -1) return CATEGORY_TYPE_CUSTOM;
			return CATEGORY_TYPE_OUTFIT;
		}
			
		public static const MAX_CUSTOM_CLOTH_HISTORY:uint = 10;
		public static const MAX_CUSTOM_CLOTHES:uint = 4;
		public static const MAX_STAMPS:uint = 600;
		public static const MAX_PHOTOS:uint = 100;	
		
		public static const PATTERN_SCALE:Number = 2.25;	
		public static const STAMP_SCALE:Number = 2.0;	
		
		public static const DISPLAYED_LOCATIONS:uint = 7;
		public static const DISPLAYED_PHOTOS:uint = 6;		
		
		public static const PHOTO_THUMB_SIZE:Point = new Point(105, 60);	
		
		public static const MAX_NAME_CHARS_ENGLISH:uint = 12;	
		public static const MAX_NAME_CHARS_ARABIC:uint = 12;								
	}
}