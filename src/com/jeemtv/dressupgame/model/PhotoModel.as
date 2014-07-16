/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 16, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.view.views.utils.PhotoUtil;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	import org.robotlegs.mvcs.Actor;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PhotoModel extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _photos:Vector.<PhotoVO>;
		private var _currentPhotos:Vector.<PhotoVO>;
		
		private var _index:uint;
		
		private var _id:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PhotoModel()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get photos():Vector.<PhotoVO>
		{
			return _photos;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function getPhotoById(id:String):PhotoVO
		{
			var photo:PhotoVO;
			for each (photo in _photos)
			{
				if(photo.id == id) return photo;
			}
			return null;
		}
		
		public function getPhotoByIndex(index:uint):PhotoVO
		{
			return getCurrentPhotos()[index];
		}
		
		public function getCurrentPhotos():Vector.<PhotoVO>
		{
			if(!_photos) return null;
			if(_photos.length < GlobalConstants.DISPLAYED_PHOTOS) return _photos;
			_currentPhotos = new Vector.<PhotoVO>();
			var i:int, index:uint;
			while(i < GlobalConstants.DISPLAYED_PHOTOS)
			{
				index = normaliseIndex(_index + i++);
				_currentPhotos.push(_photos[index]);
			}
			return _currentPhotos;
		}
		
		public function getPreviousPhotos():Vector.<PhotoVO>
		{
			_index = normaliseIndex(_index - 1);
			return getCurrentPhotos();
		}
		
		public function getNextPhotos():Vector.<PhotoVO>
		{
			_index = normaliseIndex(_index + 1);
			return getCurrentPhotos();
		}
		
		public function addPhoto(doll:DollVO, location:LocationVO):Boolean
		{
			if(isNewPhoto(doll, location))
			{
				var photo:PhotoVO = new PhotoVO(String(_id++));
				photo.doll = doll;
				photo.location = location;
				photo.thumbBmpd = PhotoUtil.createThumb(new Photo(), photo.doll, photo.location);
				
				if(!_photos) _photos = new Vector.<PhotoVO>();
				_photos.push(photo);	
				if(_photos.length > GlobalConstants.MAX_PHOTOS) _photos.shift();
				_index = Math.max(0, _photos.length - GlobalConstants.DISPLAYED_PHOTOS);
				return true;
			}
			return false;
		}
		
		public function removePhoto(index:uint):Vector.<PhotoVO>
		{
			_photos.splice(_index + index, 1);
			return getCurrentPhotos();
		}
		
		public function reset():void
		{
			_photos = null;
		}
		
		public function hasNextAndPrevious():Boolean
		{
			return _photos && _photos.length > GlobalConstants.DISPLAYED_PHOTOS;
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
		
		private function isNewPhoto(doll:DollVO, location:LocationVO):Boolean
		{
			var photo:PhotoVO, category:uint, clothes:Boolean;
			for each (photo in _photos)
			{
				if(photo.location.id == location.id && photo.doll.id == doll.id && photo.doll.skin == doll.skin)
				{
					clothes = true;
					for each(category in GlobalConstants.OUTFIT_CATEGORIES)
					{
						if((photo.doll.getCloth(category) && !doll.getCloth(category)) ||
							(!photo.doll.getCloth(category) && doll.getCloth(category)) ||
							(photo.doll.getCloth(category) && doll.getCloth(category) && 
							photo.doll.getCloth(category).id != doll.getCloth(category).id)) clothes = false;
					}
					if(clothes == true) return false;
				}
			}
			return true;
		}
		
		private function normaliseIndex(index:int):uint
		{
			if(index > _photos.length - 1) index -= _photos.length;
			else if(index < 0) index += _photos.length;
			return index;
		}
		
	}
}