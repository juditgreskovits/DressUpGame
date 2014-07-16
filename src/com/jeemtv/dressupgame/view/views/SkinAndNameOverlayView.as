/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import flashx.textLayout.formats.Direction;
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class SkinAndNameOverlayView extends AbstractOverlayView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _enableNameInput:Boolean;
		private var _lang:String;
		
		private var _skin1Button:ButtonBehaviour;
		private var _skin2Button:ButtonBehaviour;
		private var _skin3Button:ButtonBehaviour;
		
		private var _okButton:ButtonBehaviour;
		
		private var _closeButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function SkinAndNameOverlayView(enableNameInput:Boolean, lang:String)
		{
			super(new SkinAndNameOverlay_design());
			
			_enableNameInput = enableNameInput;
			_lang = lang;
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
			
			/*TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.chooseName, CopyData.getCopy(CopyConstants.NAME_TITLE), 18, false, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.chooseComplexion, CopyData.getCopy(CopyConstants.SKIN_TITLE), 18, false, GlobalConstants.COLOUR_PURPLE);*/
			TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.nameBox.nameTitle, CopyData.getCopy(CopyConstants.NAME_LABEL), 35, true, GlobalConstants.COLOUR_BRIGHT_PINK);
			TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.nameBox.okButton.label, CopyData.getCopy(CopyConstants.OK_BUTTON_LABEL));
			
			var tabIndex:uint = AccessibilityConstants.SKIN_AND_NAME_TAB_INDEX;
			_skin1Button = new ButtonBehaviour(skinAndNameOverlayAsset.skinToneButton_01, tabIndex++, onSkinButtonClick);
			_skin2Button = new ButtonBehaviour(skinAndNameOverlayAsset.skinToneButton_02, tabIndex++, onSkinButtonClick);
			_skin3Button = new ButtonBehaviour(skinAndNameOverlayAsset.skinToneButton_03, tabIndex++, onSkinButtonClick);
			
			_okButton = new ButtonBehaviour(skinAndNameOverlayAsset.nameBox.okButton, tabIndex++, onOkButtonClick);
			
			_closeButton = new ButtonBehaviour(skinAndNameOverlayAsset.button_close, tabIndex++, close);
		}
		
		override public function activate():void
		{
			super.activate();
			
			TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.titleContainer.title, CopyData.getCopy(CopyConstants.SKIN_TITLE), 18, false, GlobalConstants.COLOUR_PURPLE);
			
			_skin1Button.enabled = true;
			_skin2Button.enabled = true;
			_skin3Button.enabled = true;
			
			_okButton.enabled = true;
			
			_closeButton.enabled = true;
		}
		
		override public function deactivate():void
		{	
			_skin1Button.enabled = false;
			_skin2Button.enabled = false;
			_skin3Button.enabled = false;
			
			_okButton.enabled = false;
			
			_closeButton.enabled = false;
			
			enabled = false;
			onTransitionOutEnd();
			// super.deactivate();
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
			var frame:uint = 3*(doll.id - 1);
			skinAndNameOverlayAsset.skinToneButton_01.skinTone.gotoAndStop(++frame);
			skinAndNameOverlayAsset.skinToneButton_02.skinTone.gotoAndStop(++frame);
			skinAndNameOverlayAsset.skinToneButton_03.skinTone.gotoAndStop(++frame);
			
			var textAlign:String = _lang == GlobalConstants.LANGUAGE_ENGLISH ? "left" : "right";
			TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.nameBox.nameInput, doll.name, 35, true, 0xFFFFFF, textAlign);
			var maxChars:uint = _lang == GlobalConstants.LANGUAGE_ENGLISH ? GlobalConstants.MAX_NAME_CHARS_ENGLISH : GlobalConstants.MAX_NAME_CHARS_ARABIC;
			skinAndNameOverlayAsset.nameBox.nameInput.maxChars = maxChars;
			// skinAndNameOverlayAsset.nameBox.nameInput.text = doll.name;
		}
		
		public function updateSkin(doll:DollVO):void
		{
			var frame:uint = 3*(doll.id - 1) + doll.skin;
			skinAndNameOverlayAsset.skinToneButton_selected.skinTone.gotoAndStop(frame);
			skinAndNameOverlayAsset.skinToneButton_selected.gotoAndStop(1);
			if(_enableNameInput && skinAndNameOverlayAsset.currentFrameLabel == NavigationConstants.TRANSITION_IN_END)
			{
				_transitionBehaviour.play("transitionToNameStart");
				TLFTextFieldUtils.formatTLFTextField(skinAndNameOverlayAsset.titleContainer.title, CopyData.getCopy(CopyConstants.NAME_TITLE), 18, false, GlobalConstants.COLOUR_PURPLE);
			}
			else
			{
				dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DRESS_UP));
				close();
			}
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
		
		private function onSkinButtonClick(evt:Event):void
		{
			var skin:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			dispatchEvent(EventFactory.requestSkin(skin));
		}
		
		private function onOkButtonClick(evt:Event):void
		{
			var dollName:String = skinAndNameOverlayAsset.nameBox.nameInput.text;
			dispatchEvent(EventFactory.requestName(dollName));
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get skinAndNameOverlayAsset():SkinAndNameOverlay_design
		{
			return _asset as SkinAndNameOverlay_design;
		}
		
	}
}