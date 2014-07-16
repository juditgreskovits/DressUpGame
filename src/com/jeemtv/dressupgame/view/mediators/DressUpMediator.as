/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.view.views.DressUpView;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	
	public class DressUpMediator extends AbstractAddressMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DressUpMediator()
		{
			super(NavigationConstants.ADDRESS_DRESS_UP);
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
			eventMap.mapListener(eventDispatcher, DollsEvent.CATEGORY, onCategory);
			
			eventMap.mapListener(eventDispatcher, ClothesEvent.CLOTHES, onClothes);
			eventMap.mapListener(eventDispatcher, ClothesEvent.CLOTH, onCloth);
			
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_DOLL, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_PREVIOUS_DOLL, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_NEXT_DOLL, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_CATEGORY, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_PREVIOUS_CATEGORY, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_NEXT_CATEGORY, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_ADD_CLOTH, dispatch);
			eventMap.mapListener(dressUpView, DollsEvent.REQUEST_REMOVE_CLOTH, dispatch);
			
			eventMap.mapListener(dressUpView, ClothesEvent.REQUEST_CLOTHES, dispatch);
			eventMap.mapListener(dressUpView, ClothesEvent.REQUEST_CLOTH, dispatch);
			
			eventMap.mapListener(dressUpView, CustomClothesEvent.REQUEST_CREATE, dispatch);
			eventMap.mapListener(dressUpView, CustomClothesEvent.REQUEST_EDIT, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			eventMap.unmapListener(eventDispatcher, DollsEvent.CATEGORY, onCategory);
			
			eventMap.unmapListener(eventDispatcher, ClothesEvent.CLOTHES, onClothes);
			eventMap.unmapListener(eventDispatcher, ClothesEvent.CLOTH, onCloth);
			
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_DOLL, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_PREVIOUS_DOLL, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_NEXT_DOLL, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_CATEGORY, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_PREVIOUS_CATEGORY, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_NEXT_CATEGORY, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_ADD_CLOTH, dispatch);
			eventMap.unmapListener(dressUpView, DollsEvent.REQUEST_REMOVE_CLOTH, dispatch);
			
			eventMap.unmapListener(dressUpView, ClothesEvent.REQUEST_CLOTHES, dispatch);
			eventMap.unmapListener(dressUpView, ClothesEvent.REQUEST_CLOTH, dispatch);
			
			eventMap.unmapListener(dressUpView, CustomClothesEvent.REQUEST_CREATE, dispatch);
			eventMap.unmapListener(dressUpView, CustomClothesEvent.REQUEST_EDIT, dispatch);
			
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
		
		private function onDoll(evt:DollsEvent):void
		{
			dressUpView.updateDoll(evt.doll, evt.category);
		}
		
		private function onCategory(evt:DollsEvent):void
		{
			dressUpView.updateCategory(evt.category, evt.doll);
		}
		
		private function onCloth(evt:ClothesEvent):void
		{
			dressUpView.updateCloth(evt.cloth);
		}
		
		private function onClothes(evt:ClothesEvent):void
		{
			dressUpView.updateClothes(evt.clothes, evt.category);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get dressUpView():DressUpView
		{
			return abstractView as DressUpView;
		}
	}
}