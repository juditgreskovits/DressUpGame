/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.view.views.StartView;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	
	public class StartMediator extends AbstractAddressMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function StartMediator()
		{
			super(NavigationConstants.ADDRESS_START);
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
			
			eventMap.mapListener(startView, DollsEvent.REQUEST_DOLL, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.mapListener(startView, DollsEvent.REQUEST_DOLL, dispatch);
			
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
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get startView():StartView
		{
			return abstractView as StartView;
		}
	}
}