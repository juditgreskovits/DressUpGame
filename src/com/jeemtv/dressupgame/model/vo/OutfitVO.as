/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class OutfitVO extends AbstractClothVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _name:String;
		private var _assetClassName:String;
		private var _locationId:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function OutfitVO(id:String)
		{
			super(id);
			
			category = GlobalConstants.CATEGORY_OUTFITS;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set name(value:String):void { _name = value; }
		public function get name():String { return _name; }
		
		public function set assetClassName(value:String):void { _assetClassName = value; }
		public function get assetClassName():String { return _assetClassName; }
		
		public function set locationId(value:String):void { _locationId = value; }
		public function get locationId():String { return _locationId; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function getAssetOnHanger():Sprite
		{
			var clothClass:Class = getDefinitionByName(_assetClassName) as Class;
			var assetOnHanger:Sprite = new clothClass() as Sprite;
			if(!unlocked)
			{
				var colourTransform:ColorTransform = new ColorTransform();
				colourTransform.color = GlobalConstants.COLOUR_LOCKED;
				assetOnHanger.transform.colorTransform = colourTransform;
			}
			return assetOnHanger;
		}
		
		override public function getAssetOnDoll():Sprite
		{
			var clothClass:Class = getDefinitionByName(_assetClassName) as Class;
			return new clothClass() as Sprite;
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