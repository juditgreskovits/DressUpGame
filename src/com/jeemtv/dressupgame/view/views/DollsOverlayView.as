/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DollsOverlayView extends AbstractOverlayView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _doll1Name:String;
		private var _doll2Name:String;
		private var _doll3Name:String;
		
		private var _doll1Button:ButtonBehaviour;
		private var _doll2Button:ButtonBehaviour;
		private var _doll3Button:ButtonBehaviour;
		
		private var _closeButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DollsOverlayView()
		{
			super(new DollsOverlay_design());
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function create():void
		{
			super.create();
			
			var tabIndex:uint = AccessibilityConstants.DOLLS_TAB_INDEX;
			_doll3Button = new ButtonBehaviour(dollsOverlayAsset.buttonCharacter3, tabIndex++, onDollButtonClick);
			_doll2Button = new ButtonBehaviour(dollsOverlayAsset.buttonCharacter2, tabIndex++, onDollButtonClick);
			_doll1Button = new ButtonBehaviour(dollsOverlayAsset.buttonCharacter1, tabIndex++, onDollButtonClick);
			
			_closeButton = new ButtonBehaviour(dollsOverlayAsset.button_close, tabIndex++, close);
			
			_doll1Button.overFunction = _doll2Button.overFunction = _doll3Button.overFunction = onDollButtonOver;
			_doll1Button.outFunction = _doll2Button.outFunction = _doll3Button.outFunction = onDollButtonOut;
			_doll1Button.downFunction = _doll2Button.downFunction = _doll3Button.downFunction = onDollButtonDown;
		}
		
		override public function activate():void
		{
			super.activate();
			
			_doll1Button.enabled = true;
			_doll2Button.enabled = true;
			_doll3Button.enabled = true;
			
			_closeButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_doll1Button.enabled = false;
			_doll2Button.enabled = false;
			_doll3Button.enabled = false;
			
			_closeButton.enabled = true;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateDoll(doll:DollVO):void
		{
			var frame:uint = 3*(doll.id - 1) + doll.skin;
			dollsOverlayAsset["buttonCharacter" + doll.id].skinTone.gotoAndStop(frame);
			
			this["_doll" + doll.id + "Name"] = doll.name;
			updateDollButtonLabel(doll.id);
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
		
		private function onDollButtonOver(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateDollButtonLabel(id, GlobalConstants.COLOUR_PURPLE);
		}
		
		private function onDollButtonOut(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateDollButtonLabel(id);
		}
		
		private function onDollButtonDown(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateDollButtonLabel(id, GlobalConstants.COLOUR_PINK);
		}
		
		private function onDollButtonClick(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			dispatchEvent(EventFactory.requestDoll(id));
			dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CHARACTER_SELECTED));
			close();
			
			var doll:uint;
			for each (doll in GlobalConstants.DOLLS)
			{
				updateDollButtonLabel(doll);
			}
		}
		
		private function updateDollButtonLabel(id:uint, colour:uint=0xFFFFFF):void
		{
			TLFTextFieldUtils.formatTLFTextField(dollsOverlayAsset["buttonCharacter" + id].label, this["_doll" + id + "Name"].toUpperCase(), 24, true, colour);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get dollsOverlayAsset():DollsOverlay_design
		{
			return _asset as DollsOverlay_design;
		}
		
	}
}