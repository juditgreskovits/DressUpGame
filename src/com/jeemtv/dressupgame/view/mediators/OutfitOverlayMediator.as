/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.model.vo.LocationVO;
	import com.jeemtv.dressupgame.model.vo.OutfitVO;
	import com.jeemtv.dressupgame.events.OutfitsEvent;
	import com.jeemtv.dressupgame.view.views.OutfitOverlayView;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class OutfitOverlayMediator extends AbstractOverlayMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function OutfitOverlayMediator()
		{
			super(NavigationConstants.OVERLAY_OUTFIT);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener(eventDispatcher, OutfitsEvent.OUTFIT_UNLOCKED, onOutfitUnlocked);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, OutfitsEvent.OUTFIT_UNLOCKED, onOutfitUnlocked);
			
			super.onRemove();
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
		
		private function onOutfitUnlocked(evt:OutfitsEvent):void
		{
			var outfit:OutfitVO = evt.outfit;
			var location:LocationVO = evt.location;
			outfitOverlayView.update(outfit.name, location.name, location.assetClassName);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get outfitOverlayView():OutfitOverlayView
		{
			return abstractView as OutfitOverlayView; 
		}
		
	}
}