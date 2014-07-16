/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.google.analytics.GATracker;
	import com.jeemtv.dressupgame.events.TrackingServiceEvent;
	import org.robotlegs.base.ContextEvent;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.LoaderServiceEvent;
	import com.jeemtv.dressupgame.view.views.CheatView;
	import com.jeemtv.dressupgame.view.views.DesignStudioView;
	import com.jeemtv.dressupgame.view.views.DollsOverlayView;
	import com.jeemtv.dressupgame.view.views.DressUpView;
	import com.jeemtv.dressupgame.view.views.HelpOverlayView;
	import com.jeemtv.dressupgame.view.views.HomeView;
	import com.jeemtv.dressupgame.view.views.LocationsOverlayView;
	import com.jeemtv.dressupgame.view.views.MenuView;
	import com.jeemtv.dressupgame.view.views.OutfitOverlayView;
	import com.jeemtv.dressupgame.view.views.PhotoshootView;
	import com.jeemtv.dressupgame.view.views.SettingsOverlayView;
	import com.jeemtv.dressupgame.view.views.SkinAndNameOverlayView;
	import com.jeemtv.dressupgame.view.views.StartView;
	import com.jeemtv.dressupgame.view.views.TransitionView;
	import com.jeemtv.dressupgame.view.views.WarningMessagingView;

	import org.robotlegs.mvcs.Command;

	import flash.display.LoaderInfo;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class StartupCommand extends Command
	{		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var startupEvent:ContextEvent;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			var flashVars:Object = LoaderInfo(contextView.loaderInfo).parameters;
			
			startupView(flashVars);
			startupModel(flashVars);
		}
		
		//------------------------------------------------------------------------
		//  PRIVATE METHODS
		//------------------------------------------------------------------------
		
		private function startupView(flashVars:Object):void
		{
			contextView.addChild(new StartView());
			contextView.addChild(new HomeView());
			contextView.addChild(new DressUpView());
			contextView.addChild(new DesignStudioView());
			contextView.addChild(new PhotoshootView());
			
			contextView.addChild(new SkinAndNameOverlayView(flashVars.enableNameInput == "true", flashVars.lang));
			contextView.addChild(new OutfitOverlayView());
			contextView.addChild(new DollsOverlayView());
			contextView.addChild(new LocationsOverlayView());
			
			contextView.addChild(new TransitionView(new PreloaderToStartTransition_design(), NavigationConstants.TRANSITION_PRELOADER_TO_START));
			contextView.addChild(new TransitionView(new StartToHomeTransition_design(), NavigationConstants.TRANSITION_START_TO_HOME));
			contextView.addChild(new TransitionView(new CurtainTransition_design(), NavigationConstants.TRANSITION_CURTAINS, SoundConstants.CURTAINS));
			
			contextView.addChild(new MenuView());
			
			contextView.addChild(new SettingsOverlayView());
			contextView.addChild(new HelpOverlayView());
			contextView.addChild(new WarningMessagingView());
			
			if(flashVars.debug == "true") contextView.addChild(new CheatView());
		}
		
		private function startupModel(flashVars:Object):void
		{
			var loaderEvent:LoaderServiceEvent = new LoaderServiceEvent(LoaderServiceEvent.LOAD);
			loaderEvent.lang = flashVars.lang;
			loaderEvent.configurationXMLPath = flashVars.configurationXMLPath;
			dispatch(loaderEvent);
			
			var trackingServiceEvent:TrackingServiceEvent = new TrackingServiceEvent(TrackingServiceEvent.CREATE);
			trackingServiceEvent.tracker = startupEvent.body as GATracker;
			dispatch(trackingServiceEvent);
			
		}
	}
}