/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 15, 2013
 */
package com.jeemtv.dressupgame.preloader
{
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import flash.display.LoaderInfo;
	import com.google.analytics.GATracker;
	import flash.utils.setTimeout;
	import flash.utils.getDefinitionByName;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenu;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.view.views.utils.MovieClipBehaviour;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class Preloader extends Sprite
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _preloaderAsset:Preloader_design;
		private var _preloader:MovieClipBehaviour;
		
		private var _tracker:GATracker;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function Preloader()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onAddedToStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createTracker();
			configureStage();
			createPreloaderAsset();			
			createContextMenu();
		}
		
		private function createTracker():void
		{
			var flashVars:Object = LoaderInfo(stage.loaderInfo).parameters;
			var account:String = flashVars.gaAccount;
			_tracker = new GATracker(stage, account, "AS3", false);
			_tracker.trackEvent(TrackingConstants.CATEGORY_LOAD, TrackingConstants.ACTION_STARTED);
		}
		
		private function configureStage():void
		{
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function createContextMenu():void
		{
			var cm:ContextMenu = new ContextMenu();
			cm.builtInItems.forwardAndBack = false;
			cm.builtInItems.loop = false;
			cm.builtInItems.play = false;
			cm.builtInItems.print = true;
			cm.builtInItems.quality = true;
			cm.builtInItems.rewind = false;
			cm.builtInItems.save = false;
			cm.builtInItems.zoom = false;
			
			var cmc:Array = [
				new ContextMenuItem(GlobalConstants.CONTEXT_MENU_TITLE, false, false)
			];
			cm.customItems = cmc;
			contextMenu = cm;
		}
		
		private function createPreloaderAsset():void
		{
			_preloaderAsset = new Preloader_design();
			addChild(_preloaderAsset);
			_preloader = new MovieClipBehaviour(_preloaderAsset);
			_preloader.addFunctionToLabel(NavigationConstants.TRANSITION_IN_END, onTransitionInEnd);
			_preloader.addFunctionToLabel(NavigationConstants.TRANSITION_OUT_END, onTransitionOutEnd);
			_preloader.play(NavigationConstants.TRANSITION_IN_START);
		}
		
		private function onTransitionInEnd():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onTransitionOutEnd():void
		{
			var dressUpGameClass:Class;
			try
			{
				dressUpGameClass = Class(getDefinitionByName("DressUpGame"));
				var dressUpGame:Sprite = new dressUpGameClass(_tracker);
				dressUpGame.contextMenu = contextMenu;
				parent.addChild(dressUpGame);	
				
				_preloader.destroy();
				removeChild(_preloaderAsset);
				parent.removeChild(this);
			}
			catch(err:Error)
			{
				setTimeout(onTransitionOutEnd, 0.25);
			}
		}
		
		private function onEnterFrame(evt:Event):void
		{	
			var percentLoaded:Number = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
			var frame:uint = 35 + Math.round(percentLoaded * 100);
			_preloader.stop(frame);
			
			if(stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal)
			{				
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				_tracker.trackEvent(TrackingConstants.CATEGORY_LOAD, TrackingConstants.ACTION_COMPLETE);
				
				_preloader.play(NavigationConstants.TRANSITION_OUT_START);
			}
		}
		
	}
}