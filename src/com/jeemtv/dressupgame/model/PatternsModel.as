/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.greensock.loading.LoaderMax;
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PatternsModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _patterns:Dictionary;
		
		private var _index:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PatternsModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		public function currentPattern(doll:uint):PatternVO
		{
			if(_index > _patterns[doll].length - 1) _index = 0;
			return _patterns[doll][_index];
		}
		
		public function currentCategoryPattern(doll:uint, category:uint):PatternVO
		{
			var patterns:Vector.<PatternVO> = _patterns[doll];
			var i:uint, pattern:PatternVO;
			while(pattern = patterns[i++])
			{
				if(pattern.category == category)
				{
					_index = i-1;
					return pattern;
				}
			}
			return null;
		}
		
		public function nextPattern(doll:uint):PatternVO
		{
			if(++_index > _patterns[doll].length - 1) _index = 0;
			return _patterns[doll][_index];
		}
		
		public function previousPattern(doll:uint):PatternVO
		{
			if(--_index < 0) _index = _patterns[doll].length - 1;
			else if(_index > _patterns[doll].length - 1) _index = 0;
			return _patterns[doll][_index];
		}
		
		public function getPattern(id:String, doll:uint):PatternVO
		{
			var vec:Vector.<PatternVO> = _patterns[doll];
			var pattern:PatternVO;
			for each(pattern in vec)
			{
				if(pattern.id == id) return pattern;
			}
			return null;
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function parseXML():void
		{
			_patterns = new Dictionary();
			
			var xml:XML = LoaderMax.getContent(GlobalConstants.PATTERNS_LOADER_NAME) as XML;
			var patterns:XMLList = xml.pattern, pattern:XML, vo:PatternVO;
			for each (pattern in patterns)
			{
				vo = new PatternVO(pattern.@id);
				vo.doll = pattern.@doll;
				vo.category = uint(pattern.@category);
				vo.assetClassName = pattern.@assetClassName;
				
				if(_patterns[vo.doll] == undefined) _patterns[vo.doll] = new Vector.<PatternVO>();
				(_patterns[vo.doll] as Vector.<PatternVO>).push(vo);
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
		
	}
}