/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.DollBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.MovieClipBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class HomeView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _dressUpButton:ButtonBehaviour;
		private var _photoshootButton:ButtonBehaviour;
		
		private var _doll1Name:String;
		private var _doll2Name:String;
		private var _doll3Name:String;
		
		private var _doll1:DollBehaviour;
		private var _doll2:DollBehaviour;
		private var _doll3:DollBehaviour;
		
		private var _doll1Button:ButtonBehaviour;
		private var _doll2Button:ButtonBehaviour;
		private var _doll3Button:ButtonBehaviour;
		
		private var _selectedDollButton:ButtonBehaviour;
		private var _selectedDollButtonIndex:uint;
		
		private var _transitionIn:Boolean;
		private var _animation:MovieClipBehaviour;
		
		private var _dollSelected:Boolean;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function HomeView()
		{
			super(new ChooseCharacter_design());
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			
			if(enabled)
			{
				if(_transitionIn) _animation.play(NavigationConstants.TRANSITION_IN_START);
				else _animation.stop(NavigationConstants.TRANSITION_IN_END);
				
				_transitionIn = false;
			}
		}
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function create():void
		{
			super.create();
			
			TLFTextFieldUtils.formatTLFTextField(homeAsset.title, CopyData.getCopy(CopyConstants.HOME_INSTRUCTION), 18, false, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(homeAsset.dressUpBtn.label, CopyData.getCopy(CopyConstants.DRESS_UP_BUTTON_LABEL));
			
			var doll:uint;
			for each (doll in GlobalConstants.DOLLS)
			{
				homeAsset["doll" + doll].gotoAndStop(doll);
				// updateDollButtonLabel(doll);
			}
			
			_doll1 = new DollBehaviour(homeAsset.doll1);
			_doll2 = new DollBehaviour(homeAsset.doll2);
			_doll3 = new DollBehaviour(homeAsset.doll3);
			
			var tabIndex:uint = AccessibilityConstants.HOME_TAB_INDEX;
			_doll3Button = new ButtonBehaviour(homeAsset.dollBtn3, tabIndex++, onDollButtonClick, SoundConstants.CLICK, SoundConstants.ROLLOVER_CHARACTER);
			_doll2Button = new ButtonBehaviour(homeAsset.dollBtn2, tabIndex++, onDollButtonClick, SoundConstants.CLICK, SoundConstants.ROLLOVER_CHARACTER);
			_doll1Button = new ButtonBehaviour(homeAsset.dollBtn1, tabIndex++, onDollButtonClick, SoundConstants.CLICK, SoundConstants.ROLLOVER_CHARACTER);
			
			_doll1Button.overFunction = _doll2Button.overFunction = _doll3Button.overFunction = onDollButtonOver;
			_doll1Button.outFunction = _doll2Button.outFunction = _doll3Button.outFunction = onDollButtonOut;
			
			_dressUpButton = new ButtonBehaviour(homeAsset.dressUpBtn, tabIndex++, onStartButtonClick);
			_photoshootButton = new ButtonBehaviour(homeAsset.cameraBtn, tabIndex, onPhotoshootButtonClick);
			
			_animation = new MovieClipBehaviour(homeAsset);
			_animation.addFunctionToLabel("doll1", playTransitionInSoundEffect);
			_animation.addFunctionToLabel("doll2", playTransitionInSoundEffect);
			_animation.addFunctionToLabel("doll3", playTransitionInSoundEffect);
			
			_transitionIn = true;
			
			homeAsset.dressUpBtn.visible = false;
		}
		
		override public function activate():void
		{
			super.activate();
			
			_doll1Button.enabled = true;
			_doll2Button.enabled = true;
			_doll3Button.enabled = true;
			
			if(_dollSelected)
			{
				_dressUpButton.enabled = true;
				_photoshootButton.enabled = true;
			}
			
			var doll:uint;
			while(++doll <= 3)
			{
				if(doll == _selectedDollButtonIndex) updateDollButtonLabel(doll, GlobalConstants.COLOUR_PURPLE);
				else updateDollButtonLabel(doll);
			}
		}
		
		override public function deactivate():void
		{
			_doll1Button.enabled = false;
			_doll2Button.enabled = false;
			_doll3Button.enabled = false;
			
			_dressUpButton.enabled = false;
			_photoshootButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateDoll(doll:DollVO, select:Boolean):void
		{
			this["_doll" + doll.id + "Name"] = doll.name;
			
			if(_selectedDollButton)
			{
				_selectedDollButton.selected = false;
				// _selectedDollButton.enabled = true;
				updateDollButtonLabel(_selectedDollButtonIndex);
			}
			if(select)
			{
				_selectedDollButtonIndex = doll.id;
				_selectedDollButton = this["_doll" + _selectedDollButtonIndex + "Button"] as ButtonBehaviour;
				// _selectedDollButton.enabled = false;
				_selectedDollButton.selected = true;
				updateDollButtonLabel(_selectedDollButtonIndex, GlobalConstants.COLOUR_PURPLE);
				_dollSelected = true;
			}
			else updateDollButtonLabel(doll.id);
			
			
			(this["_doll" + doll.id] as DollBehaviour).update(doll);
		}
		
		// when we have a doll selected...
		public function enableDressUpButton():void
		{
			_dressUpButton.enabled = true;
			_photoshootButton.enabled = true;
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
			updateDollButtonLabel(id);
		}
		
		private function onDollButtonOut(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateDollButtonLabel(id);
		}
		
		private function onDollButtonClick(evt:Event):void
		{
			var id:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			dispatchEvent(EventFactory.requestDoll(id));
			dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CHARACTER_SELECTED));
			dispatchEvent(EventFactory.requestCategory(1));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
			
			dispatchEvent(EventFactory.requestOverlay(NavigationConstants.OVERLAY_SKIN_AND_NAME));
		}
		
		private function updateDollButtonLabel(id:uint, colour:uint=0xFFFFFF):void
		{
			TLFTextFieldUtils.formatTLFTextField(homeAsset["dollBtn" + id].label, this["_doll" + id + "Name"].toUpperCase(), 24, false, colour);
		}
		
		private function onStartButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DRESS_UP));
		}
		
		private function onPhotoshootButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_PHOTOSHOOT));
		}
		
		private function playTransitionInSoundEffect():void
		{
			dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.BEAM_ME_UP));
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get homeAsset():ChooseCharacter_design
		{
			return _asset as ChooseCharacter_design;
		}
	}
}