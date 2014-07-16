/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.events.PhotoEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.DollBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class PhotoshootView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _dollButton:ButtonBehaviour;
		private var _locationButton:ButtonBehaviour;
		
		private var _photoButton:ButtonBehaviour;
		private var _printButton:ButtonBehaviour;
		
		private var _dressUpButton:ButtonBehaviour;
		
		private var _previousPhotoButton:ButtonBehaviour;
		private var _nextPhotoButton:ButtonBehaviour;
		
		private var _thumbButtons:Vector.<ButtonBehaviour>;
		private var _closeButtons:Vector.<ButtonBehaviour>;
		
		private var _doll:DollBehaviour;
		
		private var _vo:DollVO;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function PhotoshootView()
		{
			super(new Gallery_design());
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function create():void
		{
			super.create();
			
			TLFTextFieldUtils.formatTLFTextField(photoshootAsset.characterBtn.title, CopyData.getCopy(CopyConstants.DOLL_TITLE), 13);
			TLFTextFieldUtils.formatTLFTextField(photoshootAsset.locationBtn.title, CopyData.getCopy(CopyConstants.LOCATION_TITLE), 13);
			TLFTextFieldUtils.formatTLFTextField(photoshootAsset.photosTitle, CopyData.getCopy(CopyConstants.PHOTO_TITLE), 16, true, GlobalConstants.COLOUR_PURPLE);
			
			var tabIndex:uint = AccessibilityConstants.PHOTOSHOOT_TAB_INDEX;
			_locationButton = new ButtonBehaviour(photoshootAsset.locationBtn, tabIndex++, onLocationButtonClick);
			_dollButton = new ButtonBehaviour(photoshootAsset.characterBtn, tabIndex++, onDollButtonClick);
			
			_photoButton = new ButtonBehaviour(photoshootAsset.cameraBtn, tabIndex++, onPhotoButtonClick, SoundConstants.PHOTO);
			_printButton = new ButtonBehaviour(photoshootAsset.printBtn, tabIndex++, onPrintButtonClick);
			
			_previousPhotoButton = new ButtonBehaviour(photoshootAsset.arrowLeftBtn, tabIndex++, onPreviousPhotoButtonClick);
			
			var i:uint, thumbContainer:MovieClip, thumbButton:ButtonBehaviour, closeButton:ButtonBehaviour;
			_thumbButtons = new Vector.<ButtonBehaviour>();
			_closeButtons = new Vector.<ButtonBehaviour>();
			while(thumbContainer = photoshootAsset["photo" + ++i])
			{
				thumbButton = new ButtonBehaviour(thumbContainer, tabIndex++, onThumbButtonClick);
				_thumbButtons.push(thumbButton);
				closeButton = new ButtonBehaviour(thumbContainer.closeBtn, tabIndex++, onCloseButtonClick);
				_closeButtons.push(closeButton);
			}
			
			_nextPhotoButton = new ButtonBehaviour(photoshootAsset.arrowRightBtn, tabIndex++, onNextPhotoButtonClick);
			
			_dressUpButton = new ButtonBehaviour(photoshootAsset.dressupBtn, tabIndex++, onDressUpButtonClick);
			
			_doll = new DollBehaviour(photoshootAsset.photo.doll, true);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_dollButton.enabled = true;
			_locationButton.enabled = true;
			_photoButton.enabled = true;
			_printButton.enabled = true;
			_dressUpButton.enabled = true;
			
			dispatchEvent(new LocationsEvent(LocationsEvent.REQUEST_LOCATION));
			dispatchEvent(new PhotoEvent(PhotoEvent.REQUEST_PHOTOS));
		}
		
		override public function deactivate():void
		{
			_dollButton.enabled = false;
			_locationButton.enabled = false;
			_photoButton.enabled = false;
			_printButton.enabled = false;
			_dressUpButton.enabled = false;
			_previousPhotoButton.enabled = false;
			_nextPhotoButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateDoll(doll:DollVO):void
		{
			_doll.update(doll);
			TLFTextFieldUtils.formatTLFTextField(photoshootAsset.characterBtn.label, doll.name.toUpperCase(), 15, true, GlobalConstants.COLOUR_PURPLE);
			_vo = doll;
		}
		
		public function updateLocation(location:LocationVO):void
		{
			if(photoshootAsset.photo.numChildren > 1) photoshootAsset.photo.removeChildAt(0);
			photoshootAsset.photo.addChildAt(location.getAsset(), 0);
			TLFTextFieldUtils.formatTLFTextField(photoshootAsset.locationBtn.label, location.name.toUpperCase(), 15, true, GlobalConstants.COLOUR_PURPLE);
		}
		
		public function updatePhotos(photos:Vector.<PhotoVO>, hasNextAndPrevious:Boolean):void
		{
			var i:uint, thumbContainer:MovieClip, photo:PhotoVO;
			while(thumbContainer = photoshootAsset["photo" + ++i])
			{
				if(thumbContainer.thumb.numChildren) thumbContainer.thumb.removeChildAt(0);
				if(photos && photos.length >= i)
				{
					photo = photos[i-1];
					thumbContainer.thumb.addChild(photo.getThumbBmp());
					_thumbButtons[i-1].enabled = true;
					thumbContainer.mouseChildren = true;
					
					thumbContainer.closeBtn.visible = true;
					_closeButtons[i-1].enabled = true;
				}
				else
				{
					_thumbButtons[i-1].enabled = false;
					thumbContainer.closeBtn.visible = false;
					_closeButtons[i-1].enabled = false;
				}
			}
			
			_previousPhotoButton.enabled = _nextPhotoButton.enabled = hasNextAndPrevious;
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
		
		private function onDollButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestOverlay(NavigationConstants.OVERLAY_DOLLS));
		}
			
		private function onLocationButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestOverlay(NavigationConstants.OVERLAY_LOCATIONS));
		}
			
		private function onPhotoButtonClick(evt:MouseEvent):void
		{
			dispatchEvent(EventFactory.requestAddPhoto(_vo.clone()));
		}
			
		private function onPrintButtonClick(evt:Event):void
		{
			// hah
			dispatchEvent(EventFactory.requestPrint(photoshootAsset.photo));
		}
			
		private function onDressUpButtonClick(evt:Event):void
		{
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DRESS_UP));
		}
			
		private function onPreviousPhotoButtonClick(evt:Event):void
		{
			dispatchEvent(new PhotoEvent(PhotoEvent.REQUEST_PREVIOUS_PHOTOS));
		}
			
		private function onNextPhotoButtonClick(evt:Event):void
		{
			dispatchEvent(new PhotoEvent(PhotoEvent.REQUEST_NEXT_PHOTOS));
		}
		
		private function onThumbButtonClick(evt:Event):void
		{
			var index:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1)) - 1;
			dispatchEvent(EventFactory.requestPhotoByIndex(index));
		}
		
		private function onCloseButtonClick(evt:Event):void
		{
			var index:uint = uint((evt.currentTarget as Sprite).parent.name.substr(-1, 1)) - 1;
			dispatchEvent(EventFactory.requestRemovePhoto(index));
			evt.stopImmediatePropagation();
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get photoshootAsset():Gallery_design
		{
			return _asset as Gallery_design;
		}
		
	}
}