/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 30, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _asset:CustomCloth_design;
		
		private var _pattern:MovieClip;
		private var _colourTransform:ColorTransform;
		private var _stamps:Sprite;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CustomClothBehaviour(asset:CustomCloth_design)
		{
			super();
			
			_asset = asset;
			_asset.mouseChildren = false;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updatePattern(pattern:PatternVO):void
		{
			if(pattern)
			{
				var patternClass:Class = getDefinitionByName(pattern.assetClassName) as Class;
				if(!_pattern || (_pattern && !(_pattern is patternClass)))
				{
					if(_pattern && _asset.contains(_pattern)) _asset.removeChild(_pattern);
					_pattern = _asset.addChildAt(new patternClass(), 2) as MovieClip;
					_pattern.patternOutline.scaleX = _pattern.patternOutline.scaleY = GlobalConstants.PATTERN_SCALE;
					_pattern.patternMask.scaleX = _pattern.patternMask.scaleY = GlobalConstants.PATTERN_SCALE;
					_pattern.patternOutline.x = _pattern.patternOutline.y = 0;
					_pattern.patternMask.x = _pattern.patternMask.y = 0;
					_pattern.patternShading.x = _pattern.patternShading.y = 0;
					_pattern.hanger.visible = _pattern.patternShading.visible = _pattern.patternMask.visible = false;
					_pattern.x = (_asset.width - _pattern.patternMask.width)*0.5;
					_pattern.y = (_asset.height - _pattern.patternMask.height)*0.5;
				}
			}
		}
		
		public function updateMaterial(material:uint):void
		{
			if(material && _asset.currentFrame != material && material <= _asset.totalFrames) _asset.gotoAndStop(material);
		}
		
		public function updateColour(colour:uint):void
		{
			if(colour)
			{
				if(!_colourTransform) _colourTransform = new ColorTransform();
				if(_colourTransform.color != colour)
				{
					_colourTransform.color = colour;
					_asset.colour.transform.colorTransform = _colourTransform;
				}
			}
		}
		
		public function updateStamps(stamps:Vector.<StampVO>):void
		{
			var l:uint, stamp:MovieClip;
			if(stamps)
			{
				if(_stamps)
				{
					l = _stamps.numChildren;
					while(l)
					{
						stamp = _stamps.getChildAt(--l) as MovieClip;
						if(!stampMatch(stamp, stamps)) _stamps.removeChild(stamp);
					}
				}
				else _stamps = _asset.addChildAt(new Sprite(), 3) as Sprite;
				if(stamps.length)
				{
					var vo:StampVO, colourTransform:ColorTransform = new ColorTransform();
					for each(vo in stamps)
					{
						CustomClothUtil.addStamp(vo, colourTransform, _stamps);
					}
				}
			}
			else if(_stamps)
			{
				l = _stamps.numChildren;
				while(l)
				{
					_stamps.removeChildAt(--l);
				}
			}
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
		
		private function stampMatch(s:MovieClip, stamps:Vector.<StampVO>):Boolean
		{
			var i:uint = stamps.length, stamp:StampVO, position:Point;
			var colour:uint = s.transform.colorTransform.color;
			while(i)
			{
				stamp = stamps[--i];
				position = stamp.position;
				if(s.currentFrame == stamp.id && colour == stamp.colour && positionMatch(s, stamp.position))
				{
					stamps.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		private function positionMatch(s:MovieClip, position:Point):Boolean
		{
			return Math.round(s.x) == Math.round(position.x - (s.width >> 1)) && Math.round(s.y) == Math.round(position.y - (s.height >> 1));
		}
	}
}