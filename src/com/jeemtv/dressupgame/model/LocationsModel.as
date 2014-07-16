/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 27, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.greensock.loading.LoaderMax;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.model.vo.LocationVO;

	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class LocationsModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _locations:Vector.<LocationVO>;
		private var _currentLocations:Vector.<LocationVO>;
		private var _index:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function LocationsModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get locations():Vector.<LocationVO>
		{
			return _locations;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getLocation(id:String=null):LocationVO
		{
			if(id)
			{
				var i:uint, l:uint = _locations.length, location:LocationVO;
				for(; i<l; i++)
				{
					location = _locations[i];
					if(location.id == id)
					{
						_index = i;
						return location;
					}
				}
			}
			return _locations[_index];
		}
		
		public function getCurrentLocations():Vector.<LocationVO>
		{
			_currentLocations = new Vector.<LocationVO>();
			var i:int, j:int, l:uint = GlobalConstants.DISPLAYED_LOCATIONS >> 1, index:uint;
			while(i <= l)
			{
				index = normaliseIndex(_index + i++);
				_currentLocations.push(_locations[index]);
			}
			while(j < l)
			{
				index = normaliseIndex(_index - ++j);
				_currentLocations.unshift(_locations[index]);
			}

			return _currentLocations;
		}
		
		public function getPreviousLocations():Vector.<LocationVO>
		{
			_index = normaliseIndex(_index - 1);
			return getCurrentLocations();
		}
		
		public function getNextLocations():Vector.<LocationVO>
		{
			_index = normaliseIndex(_index + 1);
			return getCurrentLocations();
		}
		
		public function parseXML():void
		{
			_locations = new Vector.<LocationVO>();
			
			var xml:XML = LoaderMax.getContent(GlobalConstants.LOCATIONS_LOADER_NAME) as XML;
			var locations:XMLList = xml.location, location:XML, vo:LocationVO;
			for each(location in locations)
			{
				vo = new LocationVO(location.@id);
				vo.name = String(location);
				vo.assetClassName = location.@locationAssetClassName;
				_locations.push(vo);
			}
		}
		
		public function unlockLocation(id:String):LocationVO
		{
			var location:LocationVO = getLocation(id);
			location.unlocked = true;
			return location;
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
		
		private function normaliseIndex(index:int):uint
		{
			if(index > _locations.length - 1) index -= _locations.length;
			else if(index < 0) index += _locations.length;
			return index;
		}
	}
}
