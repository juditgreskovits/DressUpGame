/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model.vo
{
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class ClothVO extends AbstractClothVO
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _assetClassNameOnHanger:String;
		private var _assetClassNameOnDoll:String;
		private var _outfitId:String;
		
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function ClothVO(id:String)
		{
			super(id);
			
			unlocked = true;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set assetClassNameOnHanger(value:String):void { _assetClassNameOnHanger = value; }
		
		public function set assetClassNameOnDoll(value:String):void { _assetClassNameOnDoll = value; }
		
		public function set outfitId(value:String):void { _outfitId = value; }
		public function get outfitId():String { return _outfitId; }
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function getAssetOnHanger():Sprite
		{
			var clothClass:Class = getDefinitionByName(_assetClassNameOnHanger) as Class;
			return new clothClass() as Sprite;
		}
		
		override public function getAssetOnDoll():Sprite
		{
			var clothClass:Class = getDefinitionByName(_assetClassNameOnDoll) as Class;
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