/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.model
{
	import flashx.textLayout.formats.Direction;

	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.LoaderServiceEvent;
	import com.jeemtv.dressupgame.events.LocationsEvent;
	import com.jeemtv.dressupgame.events.OutfitsEvent;
	import com.jeemtv.dressupgame.events.PatternsEvent;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.utils.ForceCompile;
	import com.jeemtv.dressupgame.view.views.utils.DisplayUtils;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import org.robotlegs.mvcs.Actor;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	
	public class LoaderService extends Actor
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _loader:XMLLoader;
		
		private var _lang:String;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function LoaderService()
		{
			super();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function get lang():String
		{
			return _lang;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		// TODO once we have the rest of the xmls ready... turn this into a real queue & get the paths from an xml
		public function load(configurationXMLPath:String, lang:String):void
		{
			_lang = lang;
			
			new ForceCompile();

			if(_lang == GlobalConstants.LANGUAGE_ARABIC)
			{
				TLFTextFieldUtils.direction = Direction.RTL;
				TLFTextFieldUtils.fontName = GlobalConstants.FONT_ARABIC;
			}
			else TLFTextFieldUtils.fontName = GlobalConstants.FONT_ENGLISH;
			
			LoaderMax.activate([SWFLoader]);
			
			_loader = new XMLLoader(configurationXMLPath, {name:GlobalConstants.LOADER_NAME,
				onProgress:onLoaderProgress, onComplete:onLoaderComplete, onError:onLoaderError});
			_loader.load();
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
		
		private function onLoaderProgress(evt:LoaderEvent):void
		{
			trace("LoaderService.onLoaderProgress");
		}
		
		private function onLoaderComplete(evt:LoaderEvent):void
		{
			var copyXML:XML = _loader.getContent(GlobalConstants.COPY_LOADER_NAME) as XML;
			CopyData.parseCopyXML(copyXML);
			
			DisplayUtils.enumerateFonts();
			
			// hardcode the damn thing!!!
			/* var fonts:Array = Font.enumerateFonts();
			TLFTextFieldUtils.fontName = fonts[fonts.length - 1].fontName; */
			
			dispatch(new ClothesEvent(ClothesEvent.PARSE_XML));
			dispatch(new OutfitsEvent(OutfitsEvent.PARSE_XML));
			dispatch(new LocationsEvent(LocationsEvent.PARSE_XML));
			dispatch(new PatternsEvent(PatternsEvent.PARSE_XML));
			
			dispatch(new LoaderServiceEvent(LoaderServiceEvent.LOAD_COMPLETE));
		}
		
		private function onLoaderError(evt:LoaderEvent):void
		{
			trace("LoaderService.onLoaderError");
		}
	}
}