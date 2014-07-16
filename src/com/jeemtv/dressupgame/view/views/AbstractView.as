/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class AbstractView extends Sprite
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		protected var _asset:MovieClip;
		protected var _enabled:Boolean;
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function AbstractView(asset:MovieClip=null)
		{
			super();
			
			_asset = asset;
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				mouseEnabled = _enabled;
				mouseChildren = _enabled;
				tabEnabled = _enabled;
				tabChildren = _enabled;
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		public function create():void
		{
			// TMP, so that things don't flicker like crazy!
			
			// DisplayUtils.stopMovieClips(_asset);
			
			// TODO here we shoudl cycle through all props of the asset, and setup all textfields to work with the font / embedding etc
		}
		
		public function activate():void
		{
			if(_asset) addChild(_asset);
		}
		
		public function deactivate():void
		{
			if(_asset && contains(_asset)) removeChild(_asset);
		}
		
		public function destroy():void
		{
			deactivate();
			
			_asset = null;
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