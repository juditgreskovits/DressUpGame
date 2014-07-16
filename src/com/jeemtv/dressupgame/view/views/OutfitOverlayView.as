/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class OutfitOverlayView extends AbstractOverlayView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _closeButton:ButtonBehaviour;
		private var _cancelButton:ButtonBehaviour;
		private var _locationButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function OutfitOverlayView()
		{
			super(new OutfitUnlocked_design());
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
			
			// copy 2 labels 2 buttons
			
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.outfitUnlocked_clip.outfitUnlocked, CopyData.getCopy(CopyConstants.OUTFIT_UNLOCKED_TITLE), 23);
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.locationUnlocked_clip.locationUnlocked, CopyData.getCopy(CopyConstants.LOCATION_UNLOCKED_TITLE), 23);
			
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.button1.label, CopyData.getCopy(CopyConstants.CLOSE_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.button2.label, CopyData.getCopy(CopyConstants.LOCATION_BUTTON_LABEL));
			
			// three buttons
			_closeButton = new ButtonBehaviour(outfitOverlayAsset.closeBtn, 1, close);
			_cancelButton = new ButtonBehaviour(outfitOverlayAsset.button1, 1, close);
			_locationButton = new ButtonBehaviour(outfitOverlayAsset.button2, 1, onLocationButtonClick);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_closeButton.enabled = true;
			_cancelButton.enabled = true;
			_locationButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_closeButton.enabled = false;
			_cancelButton.enabled = false;
			_locationButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function update(outfitName:String, locationName:String, locationLabel:String):void
		{
			// update them!
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.outfitUnlocked_clip.outfitName, outfitName, 23);
			TLFTextFieldUtils.formatTLFTextField(outfitOverlayAsset.locationUnlocked_clip.locationName, locationName, 23);
			outfitOverlayAsset.locationPhoto.gotoAndStop(locationLabel);
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
		
		private function onLocationButtonClick(evt:Event):void
		{
			addFunctionToTransitionComplete(dispatchEvent, [EventFactory.requestAddress(NavigationConstants.ADDRESS_PHOTOSHOOT)]);
			close();
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get outfitOverlayAsset():OutfitUnlocked_design
		{
			return _asset as OutfitUnlocked_design;
		}
		
	}
}