/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class LocationsOverlayView extends AbstractOverlayView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _previousLocationButton:ButtonBehaviour;
		private var _nextLocationButton:ButtonBehaviour;
		
		private var _cancelButton:ButtonBehaviour;
		private var _selectButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function LocationsOverlayView()
		{
			super(new LocationsOverlay_design());
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
			
			TLFTextFieldUtils.formatTLFTextField(locationsOverlayAsset.chooseLocationTitle.title, CopyData.getCopy(CopyConstants.LOCATION_TITLE), 20);
			TLFTextFieldUtils.formatTLFTextField(locationsOverlayAsset.yesBtn.label, CopyData.getCopy(CopyConstants.CANCEL_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(locationsOverlayAsset.noBtn.label, CopyData.getCopy(CopyConstants.SELECT_BUTTON_LABEL));
			
			var tabIndex:uint = AccessibilityConstants.LOCATIONS_TAB_INDEX;
			_previousLocationButton = new ButtonBehaviour(locationsOverlayAsset.locationNameSelector.button_arrowLeft, tabIndex++, onPreviousLocationButtonClick);
			_nextLocationButton = new ButtonBehaviour(locationsOverlayAsset.locationNameSelector.button_arrowRight, tabIndex++, onNextLocationButtonClick);
			_selectButton = new ButtonBehaviour(locationsOverlayAsset.noBtn, tabIndex++, onSelectButtonClick);
			_cancelButton = new ButtonBehaviour(locationsOverlayAsset.yesBtn, tabIndex++, close);
		}
		
		override public function activate():void
		{
			super.activate();
			
			dispatchEvent(new LocationsEvent(LocationsEvent.REQUEST_LOCATIONS));
			
			_previousLocationButton.enabled = true;
			_nextLocationButton.enabled = true;
			_cancelButton.enabled = true;
			_selectButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_previousLocationButton.enabled = false;
			_nextLocationButton.enabled = false;
			_cancelButton.enabled = false;
			_selectButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateLocations(locations:Vector.<LocationVO>):void
		{
			var i:uint, locationContainer:MovieClip, location:LocationVO, locationAsset:Sprite;
			var index:uint = GlobalConstants.DISPLAYED_LOCATIONS >> 1;
			while(locationContainer = locationsOverlayAsset.filmStrip["locationPhoto0" + ++i])
			{
				if(locationContainer.numChildren > 1) locationContainer.removeChildAt(1);
				location = locations[i-1];
				if(location.unlocked)
				{
					locationAsset = location.getAsset();
					locationAsset.width = locationContainer.width;
					locationAsset.height = locationContainer.height;
					locationContainer.addChild(locationAsset);
				}
				if(i-1 == index)
				{
					updateLocation(location.name);
					_selectButton.enabled = location.unlocked;
				}
			}
			if(locationsOverlayAsset.filmStrip.x != -407) TweenLite.to(locationsOverlayAsset.filmStrip, 0.3, {x:-407, ease:Sine.easeOut});
		}
		
		public function updateLocation(locationName:String):void
		{
			TLFTextFieldUtils.formatTLFTextField(locationsOverlayAsset.locationNameSelector.location, locationName, 20);
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
		
		private function onPreviousLocationButtonClick(evt:Event):void
		{
			locationsOverlayAsset.filmStrip.x -= 235;
			dispatchEvent(new LocationsEvent(LocationsEvent.REQUEST_PREVIOUS_LOCATIONS));
		}
		
		private function onNextLocationButtonClick(evt:Event):void
		{
			locationsOverlayAsset.filmStrip.x += 235;
			dispatchEvent(new LocationsEvent(LocationsEvent.REQUEST_NEXT_LOCATIONS));
		}
		
		private function onSelectButtonClick(evt:Event):void
		{
			dispatchEvent(new LocationsEvent(LocationsEvent.REQUEST_LOCATION));
			close();
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get locationsOverlayAsset():LocationsOverlay_design
		{
			return _asset as LocationsOverlay_design;
		}
	}
}