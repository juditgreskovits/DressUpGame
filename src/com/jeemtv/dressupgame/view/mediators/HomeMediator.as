/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.view.views.HomeView;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	
	public class HomeMediator extends AbstractAddressMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _dollCounter:uint;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function HomeMediator()
		{
			super(NavigationConstants.ADDRESS_HOME);
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
			
			eventMap.mapListener(homeView, DollsEvent.REQUEST_DOLL, dispatch);
			eventMap.mapListener(homeView, DollsEvent.REQUEST_CATEGORY, dispatch);
			eventMap.mapListener(homeView, ClothesEvent.REQUEST_CLOTHES, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, DollsEvent.DOLL, onDoll);
			
			eventMap.unmapListener(homeView, DollsEvent.REQUEST_DOLL, dispatch);
			eventMap.unmapListener(homeView, DollsEvent.REQUEST_CATEGORY, dispatch);
			eventMap.unmapListener(homeView, ClothesEvent.REQUEST_CLOTHES, dispatch);
			
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
			var select:Boolean = ++_dollCounter > 3;
			homeView.updateDoll(evt.doll, select);
			if(select) homeView.enableDressUpButton();
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function get homeView():HomeView
		{
			return abstractView as HomeView;
		}
	}
}