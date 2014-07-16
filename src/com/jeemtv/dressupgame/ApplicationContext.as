/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame
{
	import com.google.analytics.GATracker;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	import com.jeemtv.dressupgame.commands.StartupCommand;
	import com.jeemtv.dressupgame.commands.SetupCommand;
	import org.robotlegs.base.ContextEvent;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.Context;
	
	public class ApplicationContext extends Context
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _tracker:GATracker;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function ApplicationContext(contextView:DisplayObjectContainer, tracker:GATracker)
		{
			_tracker = tracker;
			
			super(contextView);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		public override function startup():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP, SetupCommand);
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand);
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP, _tracker));
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