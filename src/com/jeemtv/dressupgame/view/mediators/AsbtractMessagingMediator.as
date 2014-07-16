/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AsbtractMessagingMediator extends AbstractMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _messaging:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AsbtractMessagingMediator(messaging:String)
		{
			super();
			
			_messaging = messaging;
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
		}
		
		override public function onRemove():void
		{
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
		
	}
}