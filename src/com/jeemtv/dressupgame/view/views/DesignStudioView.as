/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.greensock.TweenLite;
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.PatternsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.PatternVO;
	import com.jeemtv.dressupgame.model.vo.StampVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.ColourPickerBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.CustomClothBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.CustomClothRevealBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.CustomClothUtil;
	import com.jeemtv.dressupgame.view.views.utils.DisplayUtils;
	import com.jeemtv.dressupgame.view.views.utils.MaterialPickerBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.StampPickerBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DesignStudioView extends AbstractView
	{
		// private static constants
		
		private static const STAMP_OFFSET:Number = 5;
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _backButton:ButtonBehaviour;
		private var _doneButton:ButtonBehaviour;
		
		private var _undoButton:ButtonBehaviour;
		private var _redoButton:ButtonBehaviour;
		
		private var _clearButton:ButtonBehaviour;
		
		private var _previousPatternButton:ButtonBehaviour;
		private var _nextPatternButton:ButtonBehaviour;
		
		private var _stampPicker:StampPickerBehaviour;
		private var _stampColourPicker:ColourPickerBehaviour;
		private var _materialPicker:MaterialPickerBehaviour;
		private var _colourPicker:ColourPickerBehaviour;
		
		private var _clothBehaviour:CustomClothBehaviour;
		
		private var _stamp:StampVO;
		
		private var _cloth:Bitmap;
		
		private var _mouseStamp:Sprite;
		private var _ios:Vector.<InteractiveObject>;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DesignStudioView()
		{
			super(new DesignOutfit_design());
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
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.stampsTxt, CopyData.getCopy(CopyConstants.STAMPS_LABEL), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.stampColourBtn.label, CopyData.getCopy(CopyConstants.STAMP_COLOUR_BUTTON_LABEL), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.clothBtn.label, CopyData.getCopy(CopyConstants.CLOTH_BUTTON_LABEL), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.clothColourBtn.label, CopyData.getCopy(CopyConstants.CLOTH_COLOUR_BUTTON_LABEL), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.clearBtn.label, CopyData.getCopy(CopyConstants.CLEAR_BUTTON_LABEL), 14);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.undoBtn.label, CopyData.getCopy(CopyConstants.UNDO_BUTTON_LABEL), 14);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.redoBtn.label, CopyData.getCopy(CopyConstants.REDO_BUTTON_LABEL), 14);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.backBtn.label, CopyData.getCopy(CopyConstants.BACK_BUTTON_LABEL), 28);
			TLFTextFieldUtils.formatTLFTextField(designStudioAsset.doneBtn.label, CopyData.getCopy(CopyConstants.DONE_BUTTON_LABEL), 28);
			
			var tabIndex:uint = AccessibilityConstants.DESIGN_STUDIO_TAB_INDEX;
			_stampPicker = new StampPickerBehaviour(designStudioAsset, designStudioAsset.stampsBtn, "stamp", "stamp", onStamp, tabIndex);
			tabIndex += 29;
			_stampColourPicker = new ColourPickerBehaviour(designStudioAsset.stampColourBtn, designStudioAsset.stampColourPanel, designStudioAsset.stampColourPanel.colours, onStampColour, tabIndex++);
			_materialPicker = new MaterialPickerBehaviour(designStudioAsset.clothBtn, designStudioAsset.clothPanel, "fabricButton0", onMaterial, tabIndex++);
			tabIndex += 9;
			_colourPicker = new ColourPickerBehaviour(designStudioAsset.clothColourBtn, designStudioAsset.clothColourPanel, designStudioAsset.clothColourPanel.colours, onColour, tabIndex++);
			
			_previousPatternButton = new ButtonBehaviour(designStudioAsset.previousPatternBtn, tabIndex++, onPreviousPatternButtonClick, SoundConstants.CAROUSEL_SHIFT);
			
			designStudioAsset.customCloth.tabIndex = tabIndex++;
			designStudioAsset.customCloth.tabEnabled = true;
			designStudioAsset.customCloth.tabChildren = false;
			
			_nextPatternButton = new ButtonBehaviour(designStudioAsset.nextPatterBtn, tabIndex++, onNextPatternButtonClick, SoundConstants.CAROUSEL_SHIFT);
			
			_clearButton = new ButtonBehaviour(designStudioAsset.clearBtn, tabIndex++, onClearButtonClick);
			_undoButton = new ButtonBehaviour(designStudioAsset.undoBtn, tabIndex++, onUndoButtonClick);
			_redoButton = new ButtonBehaviour(designStudioAsset.redoBtn, tabIndex++, onRedoButtonClick);
			
			_doneButton = new ButtonBehaviour(designStudioAsset.doneBtn, tabIndex++, onDoneButtonClick, SoundConstants.CUT_OUT);
			_backButton = new ButtonBehaviour(designStudioAsset.backBtn, tabIndex++, onBackButtonClick);
			
			_clothBehaviour = new CustomClothBehaviour(designStudioAsset.customCloth);
			
			_stamp = new StampVO(1);
			_stamp.colour = 0x000000;
			
			_stampColourPicker.updateColour(0x000000);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_backButton.enabled = true;
			_doneButton.enabled = true;
			_clearButton.enabled = true;
			_previousPatternButton.enabled = true;
			_nextPatternButton.enabled = true;
			
			_stampPicker.enabled = true;
			_stampColourPicker.enabled = true;
			_materialPicker.enabled = true;
			_colourPicker.enabled = true;
			
			designStudioAsset.customCloth.addEventListener(MouseEvent.ROLL_OVER, onStampOver);
			designStudioAsset.customCloth.addEventListener(MouseEvent.ROLL_OUT, onStampOut);
			designStudioAsset.customCloth.addEventListener(MouseEvent.MOUSE_DOWN, onStampClick);
			designStudioAsset.customCloth.addEventListener(FocusEvent.FOCUS_IN, onStampOver);
			designStudioAsset.customCloth.addEventListener(FocusEvent.FOCUS_OUT, onStampOut);
		}
		
		override public function deactivate():void
		{
			_backButton.enabled = false;
			_doneButton.enabled = false;
			_undoButton.enabled = false;
			_redoButton.enabled = false;
			_clearButton.enabled = false;
			_previousPatternButton.enabled = false;
			_nextPatternButton.enabled = false;
			
			_stampPicker.enabled = false;
			_stampColourPicker.enabled = false;
			_materialPicker.enabled = false;
			_colourPicker.enabled = false;
			
			designStudioAsset.customCloth.removeEventListener(MouseEvent.ROLL_OVER, onStampOver);
			designStudioAsset.customCloth.removeEventListener(MouseEvent.ROLL_OUT, onStampOut);
			designStudioAsset.customCloth.removeEventListener(MouseEvent.MOUSE_DOWN, onStampClick);
			designStudioAsset.customCloth.removeEventListener(FocusEvent.FOCUS_IN, onStampOver);
			designStudioAsset.customCloth.removeEventListener(FocusEvent.FOCUS_OUT, onStampOut);
			
			if(_cloth)
			{
				if(designStudioAsset.contains(_cloth)) designStudioAsset.removeChild(_cloth);
				_cloth = null;
			}
			
			designStudioAsset.customCloth.alpha = 1.0;
			designStudioAsset.previousPatternBtn.alpha = 1.0;
			designStudioAsset.nextPatterBtn.alpha = 1.0;
			designStudioAsset.clearBtn.alpha = 1.0;
			designStudioAsset.undoBtn.alpha = 1.0;
			designStudioAsset.redoBtn.alpha = 1.0;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updatePattern(pattern:PatternVO):void
		{
			_clothBehaviour.updatePattern(pattern);
		}
		
		public function updateMaterial(material:uint):void
		{
			_clothBehaviour.updateMaterial(material);
			_materialPicker.updateMaterial(material);
			_stampPicker.updateMaterial(material);
		}
		
		public function updateColour(colour:uint):void
		{
			_clothBehaviour.updateColour(colour);
			_colourPicker.updateColour(colour);
			_stampPicker.updateColour(colour);
		}
		
		public function updateStamps(stamps:Vector.<StampVO>):void
		{
			var s:Vector.<StampVO> = new Vector.<StampVO>();
			var stamp:StampVO;
			for each(stamp in stamps)
			{
				s.push(stamp);
			}
			_clothBehaviour.updateStamps(s);
		}
		
		public function complete(cloth:Bitmap):void
		{
			var asset:MovieClip = designStudioAsset.customCloth;
			_cloth = designStudioAsset.addChild(cloth) as Bitmap;
			_cloth.x = asset.x + (asset.width - _cloth.width >> 1);
			_cloth.y = asset.y + (asset.height - _cloth.height >> 1);
			_cloth.alpha = 0.0;
			
			TweenLite.to(asset, 0.6, {alpha:0.0, delay:0.8});
			TweenLite.to(_cloth, 0.6, {alpha:1.0, delay:0.5});
			
			CustomClothRevealBehaviour.activateParticleEffect(_cloth);
			
			TweenLite.to(designStudioAsset.previousPatternBtn, 0.6, {alpha:0.0});
			TweenLite.to(designStudioAsset.nextPatterBtn, 0.6, {alpha:0.0});
			TweenLite.to(designStudioAsset.clearBtn, 0.6, {alpha:0.0});
			TweenLite.to(designStudioAsset.undoBtn, 0.6, {alpha:0.0});
			TweenLite.to(designStudioAsset.redoBtn, 0.6, {alpha:0.0});
			
			TweenLite.delayedCall(5.0, onCompleteComplete);
		}
		
		public function updateButtons(undo:Boolean, redo:Boolean):void
		{
			if(_undoButton.enabled != undo)
			{
				_undoButton.enabled = undo;
				if(_undoButton.enabled && _ios)
				{
					designStudioAsset.undoBtn.tabEnabled = false;
					_ios.push(designStudioAsset.undoBtn);
				}
			}
			if(_redoButton.enabled != redo)
			{
				_redoButton.enabled = redo;
				if(_redoButton.enabled && _ios)
				{
					designStudioAsset.redoBtn.tabEnabled = false;
					_ios.push(designStudioAsset.redoBtn);
				}
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
		
		private function onCompleteComplete():void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DRESS_UP));
		}
		
		// buttons / picking
		private function onBackButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DRESS_UP));
		}
		
		private function onDoneButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_COMPLETE));
		}
			
		private function onUndoButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_UNDO));
		}
			
		private function onRedoButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_REDO));
		}
			
		private function onClearButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_CLEAR));
		}
		
		private function onPreviousPatternButtonClick(evt:Event):void
		{
			dispatchEvent(new PatternsEvent(PatternsEvent.REQUEST_PREVIOUS));
		}
			
		private function onNextPatternButtonClick(evt:Event):void
		{
			dispatchEvent(new PatternsEvent(PatternsEvent.REQUEST_NEXT));
		}
		
		private function onStamp(id:uint):void
		{
			_stamp.id = id;
			_stampPicker.updateStamp(id);
		}
			
		private function onStampColour(colour:uint):void
		{
			_stamp.colour = colour;
			_stampColourPicker.updateColour(colour);
			_stampPicker.colourStamp(colour);
		}
			
		private function onMaterial(id:uint):void
		{
			dispatchEvent(EventFactory.requestMaterial(id));
		}
			
		private function onColour(colour:uint):void
		{
			dispatchEvent(EventFactory.requestColour(colour));
		}
		
		private function onStampOver(evt:Event=null):void
		{
			Mouse.hide();
			if(!_mouseStamp) _mouseStamp = addChild(CustomClothUtil.getStamp(_stamp)) as Sprite;
			_mouseStamp.mouseEnabled = false;	
			_mouseStamp.mouseChildren = false;	
			
			if(!_ios) _ios = DisplayUtils.disableTabbing(designStudioAsset.customCloth, stage);
			
			designStudioAsset.customCloth.addEventListener(MouseEvent.MOUSE_MOVE, onStampMove);
			designStudioAsset.customCloth.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);	
			
			var bounds:Rectangle = designStudioAsset.customCloth.getBounds(this);
			if(!bounds.contains(mouseX, mouseY))
			{
				_mouseStamp.x = bounds.x + (bounds.width >> 1);
				_mouseStamp.y = bounds.y + (bounds.height >> 1);
			}
			else onStampMove();
		}
		
		private function onStampOut(evt:Event=null):void
		{
			if(_mouseStamp)
			{
				if(contains(_mouseStamp)) removeChild(_mouseStamp);
				_mouseStamp = null;
			}
			Mouse.show();
			
			designStudioAsset.customCloth.removeEventListener(MouseEvent.MOUSE_MOVE, onStampMove);
			designStudioAsset.customCloth.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			if(_ios) DisplayUtils.enableTabbing(_ios);
			_ios = null;
		}
		
		private function onStampMove(evt:Event=null):void
		{
			_mouseStamp.x = mouseX;
			_mouseStamp.y = mouseY;
		}
		
		private function onStampClick(evt:Event=null):void
		{
			var stamp:StampVO = _stamp.clone();
			stamp.position = new Point(_mouseStamp.x - designStudioAsset.customCloth.x, _mouseStamp.y - designStudioAsset.customCloth.y);
			dispatchEvent(EventFactory.requestStampAdd(stamp));
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			switch(evt.keyCode)
			{
				case 13: // Enter
				case 32: // Space
					onStampClick();
					break;	
					
				case 27: // Esc	
					onStampOut();
					break;
				
				case 37: // Left 
					_mouseStamp.x -= STAMP_OFFSET;
					break;
				
				case 39: // Right
					_mouseStamp.x += STAMP_OFFSET;
					break;
				
				case 38: // Up
					_mouseStamp.y -= STAMP_OFFSET;
					break;
				
				case 40: // Down	
					_mouseStamp.y += STAMP_OFFSET;
					break;
			}
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get designStudioAsset():DesignOutfit_design
		{
			return _asset as DesignOutfit_design;
		}
	}
}