/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.view.views.SkinAndNameOverlayView;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class SkinAndNameOverlayMediator extends AbstractOverlayMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SkinAndNameOverlayMediator()
		{
			super(NavigationConstants.OVERLAY_SKIN_AND_NAME);
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
			
			eventMap.mapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			
			eventMap.mapListener(skinAndNameOverlayView, DollsEvent.REQUEST_UPDATE_SKIN, dispatch);
			eventMap.mapListener(skinAndNameOverlayView, DollsEvent.REQUEST_UPDATE_NAME, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			
			eventMap.unmapListener(skinAndNameOverlayView, DollsEvent.REQUEST_UPDATE_SKIN, dispatch);
			eventMap.unmapListener(skinAndNameOverlayView, DollsEvent.REQUEST_UPDATE_NAME, dispatch);
			
			super.onRemove();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		private function onDoll(evt:DollsEvent):void
		{
			if(_active) skinAndNameOverlayView.updateSkin(evt.doll);
			else skinAndNameOverlayView.updateDoll(evt.doll);
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
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get skinAndNameOverlayView():SkinAndNameOverlayView
		{
			return abstractView as SkinAndNameOverlayView; 
		}
		
	}
}