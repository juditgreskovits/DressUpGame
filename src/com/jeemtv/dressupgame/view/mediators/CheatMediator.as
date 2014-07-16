/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 9, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import flash.events.Event;
	import com.jeemtv.dressupgame.view.views.CheatView;
	import org.robotlegs.mvcs.Mediator;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CheatMediator extends Mediator
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var cheatView:CheatView;
		
		//------------------------------------------------------------------------
		//  CONSTRUCTOR
		//------------------------------------------------------------------------
		
		public function CheatMediator()
		{
			super();
		}
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			cheatView.create(this);
		}	
		
		//------------------------------------------------------------------------
		//  PUBLIC METHODS
		//------------------------------------------------------------------------
		
		public function dispatchCheat(evt:Event):void
		{
			dispatch(evt);
		}
		
		//------------------------------------------------------------------------
		//  PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
	}
	
}