/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.view.views.utils.DisplayUtils;
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.greensock.TweenLite;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.constants.SoundConstants;
	import com.jeemtv.dressupgame.events.ClothesEvent;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.DollsEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	import com.jeemtv.dressupgame.model.vo.DollVO;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.ClothesAnimationBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.CustomClothesAnimationBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.DressUpDollBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.MovieClipBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DressUpView extends AbstractView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _homeButton:ButtonBehaviour;
		private var _designStudioButton:ButtonBehaviour;
		private var _photoshootButton:ButtonBehaviour;
		
		private var _previousDollButton:ButtonBehaviour;
		private var _nextDollButton:ButtonBehaviour;
		
		private var _previousCategoryButton:ButtonBehaviour;
		private var _nextCategoryButton:ButtonBehaviour;
		
		private var _categoryDropdownButton:ButtonBehaviour;
		private var _categoryDropdownAnimation:MovieClipBehaviour;
		private var _categoryButtons:Vector.<ButtonBehaviour>;
		private var _categoriesOpen:Boolean;
		
		private var _clothes:ClothesAnimationBehaviour;
		private var _customClothes:ClothesAnimationBehaviour;
		private var _outfits:ClothesAnimationBehaviour;
		
		private var _cloth:Sprite;
		private var _dragCloth:Sprite;
		
		private var _doll:DressUpDollBehaviour;
		
		private var _mouseDownPosition:Point;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DressUpView()
		{
			super(new ChooseOutfit_design());
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
			
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.title, CopyData.getCopy(CopyConstants.DRESS_UP_INSTRUCTION), 15, false, GlobalConstants.COLOUR_PURPLE);
			
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.homeBtn.label, CopyData.getCopy(CopyConstants.HOME_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.cameraBtn.label, CopyData.getCopy(CopyConstants.PHOTOSHOOT_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.designBtn.label, CopyData.getCopy(CopyConstants.DESIGN_STUDIO_BUTTON_LABEL));
			
			var tabIndex:uint = AccessibilityConstants.DRESS_UP_TAB_INDEX;
			
			_previousCategoryButton = new ButtonBehaviour(dressUpAsset.previousCategoryBtn, tabIndex++, onPreviousCategoryButtonClick, SoundConstants.CAROUSEL_SHIFT);
			
			_categoryDropdownButton = new ButtonBehaviour(dressUpAsset.categoryButton, tabIndex++, onCategoryDropdownButtonClick);
			_categoryDropdownAnimation = new MovieClipBehaviour(dressUpAsset.categoryDropdownClip);
			dressUpAsset.categoryDropdownClip.addEventListener(MouseEvent.MOUSE_OVER, onDropdownOver);
			dressUpAsset.categoryDropdownClip.addEventListener(MouseEvent.MOUSE_OUT, onDropdownOut);
			
			_categoryButtons = new Vector.<ButtonBehaviour>();
			var category:uint, categoryButton:ButtonBehaviour;
			for each(category in GlobalConstants.CATEGORIES)
			{
				updateCategoryButtonLabel(category, GlobalConstants.COLOUR_BLUE);
				categoryButton = new ButtonBehaviour(dressUpAsset.categoryDropdownClip.categoryDropdown["categoryBtn0" + category], tabIndex++, onCategoryButtonClick, SoundConstants.CAROUSEL_SHIFT);
				categoryButton.overFunction = onCategoryButtonOver;
				categoryButton.outFunction = onCategoryButtonOut;
				categoryButton.downFunction = onCategoryButtonDown;
				_categoryButtons.push(categoryButton);
			}
			
			_nextCategoryButton = new ButtonBehaviour(dressUpAsset.nextCategoryBtn, tabIndex++, onNextCategoryButtonClick, SoundConstants.CAROUSEL_SHIFT);
			
			_doll = new DressUpDollBehaviour(dressUpAsset.doll, onDollClothUp, tabIndex);
			tabIndex += 5;
			
			_clothes = new ClothesAnimationBehaviour(dressUpAsset.clothesAnimation, onClothDown, onClothesTransitionOutEnd, tabIndex);
			_customClothes = new CustomClothesAnimationBehaviour(dressUpAsset.customClothesAnimation, onClothDown, onClothesTransitionOutEnd, onClothDesignStudioButtonClick, onClothEditButtonClick, tabIndex);
			_outfits = new ClothesAnimationBehaviour(dressUpAsset.outfitsAnimation, onClothDown, onClothesTransitionOutEnd, tabIndex);
			dressUpAsset.customClothesAnimation.visible = dressUpAsset.outfitsAnimation.visible = false;
			tabIndex += 6;
			
			_previousDollButton = new ButtonBehaviour(dressUpAsset.previousDollBtn, tabIndex++, onPreviousDollButtonClick, SoundConstants.CAROUSEL_SHIFT);
			_nextDollButton = new ButtonBehaviour(dressUpAsset.nextDollBtn, tabIndex++, onNextDollButtonClick, SoundConstants.CAROUSEL_SHIFT);
			
			_homeButton = new ButtonBehaviour(dressUpAsset.homeBtn, tabIndex++, onHomeButtonClick);
			_photoshootButton = new ButtonBehaviour(dressUpAsset.cameraBtn, tabIndex++, onPhotoshootButtonClick);
			_designStudioButton = new ButtonBehaviour(dressUpAsset.designBtn, tabIndex++, onDesignStudioButtonClick);
			
			_mouseDownPosition = new Point();
		}
		
		override public function activate():void
		{
			super.activate();
			
			_homeButton.enabled = true;
			_designStudioButton.enabled = true;
			_photoshootButton.enabled = true;
			
			_previousDollButton.enabled = true;
			_nextDollButton.enabled = true;
			
			_previousCategoryButton.enabled = true;
			_nextCategoryButton.enabled = true;
			
			_categoryDropdownButton.enabled = true;
			
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.homeBtn.label, CopyData.getCopy(CopyConstants.HOME_BUTTON_LABEL));
			
			var category:uint;
			for each(category in GlobalConstants.CATEGORIES)
			{
				updateCategoryButtonLabel(category, GlobalConstants.COLOUR_BLUE);
			}
		}
		
		override public function deactivate():void
		{
			_homeButton.enabled = false;
			_designStudioButton.enabled = false;
			_photoshootButton.enabled = false;
			
			_previousDollButton.enabled = false;
			_nextDollButton.enabled = false;
			
			_previousCategoryButton.enabled = false;
			_nextCategoryButton.enabled = false;
			
			_categoryDropdownButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		public function updateDoll(doll:DollVO, category:uint):void
		{
			_doll.update(doll);
			// var dollName:String = CopyData.getCopy("doll_" + doll.id + "_name").toUpperCase();
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.dollLabel, doll.name.toUpperCase(), 15, false, GlobalConstants.COLOUR_PURPLE);

			updateClothesVisibility();
		}
		
		public function updateCategory(category:uint, doll:DollVO):void
		{
			var categoryName:String = CopyData.getCopy("category_" + category).toUpperCase();
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.categoryButton.label, categoryName, 16, false);
		}
		
		public function updateClothes(clothes:Vector.<AbstractClothVO>, category:uint):void
		{
			_customClothes.transtionOut(clothes, category);
			_clothes.transtionOut(clothes, category);
			_outfits.transtionOut(clothes, category);
		}
		
		public function updateCloth(cloth:AbstractClothVO):void
		{
			if(_dragCloth) onClothUp();
			
			if(cloth.unlocked)
			{
				_dragCloth = cloth.getAssetOnDoll();
				_dragCloth.name = cloth.id;
				var clothBounds:Rectangle = _dragCloth.getBounds(_dragCloth);
				_dragCloth.x = mouseX - clothBounds.x - (clothBounds.width >> 1);
				_dragCloth.y = mouseY - clothBounds.y - (clothBounds.height >> 1);
				addChild(_dragCloth);
				var dragBounds:Rectangle = new Rectangle(-clothBounds.x, -clothBounds.y, stage.stageWidth - clothBounds.width, stage.stageHeight - clothBounds.height);
				_dragCloth.startDrag(false, dragBounds);
				
				updateClothVisibility(cloth.id, false);
				
				stage.addEventListener(MouseEvent.MOUSE_UP, onClothUp);
				stage.addEventListener(Event.MOUSE_LEAVE, onClothUp);
			}
			else 
			{
				_cloth = null;
				updateClothVisibility(cloth.id, true);
			
				_mouseDownPosition.x = -1;
				_mouseDownPosition.y = -1;
				dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.OUTFIT_NO));
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
		
		private function onDropdownOver(evt:Event=null):void
		{
			TweenLite.killDelayedCallsTo(openCloseCategoryDropdown);
			// openCloseCategoryDropdown(true);
		}
		
		private function onDropdownOut(evt:Event):void
		{
			TweenLite.killDelayedCallsTo(openCloseCategoryDropdown);
			TweenLite.delayedCall(1.0, openCloseCategoryDropdown, [false]);
		}
		
		private function onClothesTransitionOutEnd(clothes:Vector.<AbstractClothVO>, category:uint):void
		{
			var categoryType:uint = clothes ? GlobalConstants.getCategoryType(category) : GlobalConstants.CATEGORY_TYPE_CUSTOM;
			switch(categoryType)
			{
				case GlobalConstants.CATEGORY_TYPE_OUTFITS:
					_outfits.transitionIn(clothes);
					_outfits.updateClothesVisibility(_doll);
					break;
					
				case GlobalConstants.CATEGORY_TYPE_CUSTOM:
					_customClothes.transitionIn(clothes);
					_customClothes.updateClothesVisibility(_doll);
					break;
					
				case GlobalConstants.CATEGORY_TYPE_OUTFIT:
					_clothes.transitionIn(clothes);
					_clothes.updateClothesVisibility(_doll);
					break;		
			}
		}
		
		private function onClothDown(evt:Event):void
		{
			_cloth = evt.currentTarget as Sprite;
			_clothes.updateClothVisibility(_cloth.name, false);
			_customClothes.updateClothVisibility(_cloth.name, false);
			_outfits.updateClothVisibility(_cloth.name, false);

			var id:String = _cloth.name;
			dispatchEvent(EventFactory.requestCloth(id));
			
			_mouseDownPosition.x = mouseX;
			_mouseDownPosition.y = mouseY;
		}
		
		private function onClothUp(evt:Event=null):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onClothUp);
			stage.removeEventListener(Event.MOUSE_LEAVE, onClothUp);
			
			var cloth:String = _dragCloth.name;
			_dragCloth.stopDrag();
			if(contains(_dragCloth)) removeChild(_dragCloth);
			_dragCloth = null;
				
			if(DisplayUtils.isPositionWithinRange(_mouseDownPosition, new Point(mouseX, mouseY)) ||
				dressUpAsset.doll.getBounds(this).contains(mouseX, mouseY))
			{
				dispatchEvent(EventFactory.requestDollAddCloth(cloth));
				dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CLOTHING_ADD));
			}
			else updateClothesVisibility();
			_mouseDownPosition.x = -1;
			_mouseDownPosition.y = -1;
			
			/*if(_mouseDownPosition.x != mouseX || _mouseDownPosition.y != mouseY)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onClothUp);
				stage.removeEventListener(Event.MOUSE_LEAVE, onClothUp);
				
				var cloth:String = _dragCloth.name;
				_dragCloth.stopDrag();
				if(contains(_dragCloth)) removeChild(_dragCloth);
				_dragCloth = null;
				
				if(dressUpAsset.doll.getBounds(this).contains(mouseX, mouseY))
				{
					dispatchEvent(EventFactory.requestDollAddCloth(cloth));
					dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CLOTHING_ADD));
				}
				else updateClothesVisibility();
			}
			_mouseDownPosition.x = -1;
			_mouseDownPosition.y = -1;*/
		}
		
		private function onDollClothUp(cloth:String):void
		{
			// var cloth:String = (evt.currentTarget as Sprite).name;
			dispatchEvent(EventFactory.requestDollRemoveCloth(cloth));
			dispatchEvent(EventFactory.requestPlaySoundEffect(SoundConstants.CLOTHING_REMOVE));
		}
		
		private function updateClothesVisibility():void
		{
			_clothes.updateClothesVisibility(_doll);
			_customClothes.updateClothesVisibility(_doll);
			_outfits.updateClothesVisibility(_doll);
		}
		
		private function updateClothVisibility(cloth:String, visible:Boolean):void
		{
			_clothes.updateClothVisibility(cloth, visible);
			_customClothes.updateClothVisibility(cloth, visible);
			_outfits.updateClothVisibility(cloth, visible);
		}
		
		private function onClothDesignStudioButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_CREATE));
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DESIGN_STUDIO));
		}
		
		private function onClothEditButtonClick(evt:Event):void
		{
			var clothContainer:Sprite = evt.currentTarget.parent as Sprite;
			var clothAsset:Sprite = clothContainer.getChildAt(1) as Sprite;
			var editEvent:CustomClothesEvent = new CustomClothesEvent(CustomClothesEvent.REQUEST_EDIT);
			editEvent.id = clothAsset.name;
			dispatchEvent(editEvent);
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DESIGN_STUDIO));
		}
		
		// buttons
		
		private function onHomeButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_HOME));
		}
		
		private function onDesignStudioButtonClick(evt:Event):void
		{
			dispatchEvent(new CustomClothesEvent(CustomClothesEvent.REQUEST_CREATE));
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_DESIGN_STUDIO));
		}
		
		private function onPhotoshootButtonClick(evt:Event):void
		{
			dispatchEvent(EventFactory.requestAddress(NavigationConstants.ADDRESS_PHOTOSHOOT));
		}
		
		private function onPreviousDollButtonClick(evt:Event):void
		{
			dispatchEvent(new DollsEvent(DollsEvent.REQUEST_PREVIOUS_DOLL));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
		}
		
		private function onNextDollButtonClick(evt:Event):void
		{
			dispatchEvent(new DollsEvent(DollsEvent.REQUEST_NEXT_DOLL));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
		}
		
		private function onPreviousCategoryButtonClick(evt:Event):void
		{
			dispatchEvent(new DollsEvent(DollsEvent.REQUEST_PREVIOUS_CATEGORY));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
		}
		
		private function onNextCategoryButtonClick(evt:Event):void
		{
			dispatchEvent(new DollsEvent(DollsEvent.REQUEST_NEXT_CATEGORY));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
		}
		
		private function onCategoryDropdownButtonClick(evt:Event=null):void
		{
			openCloseCategoryDropdown(!_categoriesOpen);
		}
		
		private function openCloseCategoryDropdown(open:Boolean):void
		{
			if(open != _categoriesOpen)
			{
				_categoryDropdownAnimation.stop();
				if(open) _categoryDropdownAnimation.play("open");
				else _categoryDropdownAnimation.play("close");
				_categoriesOpen = open;
				enableCategoryButtons(_categoriesOpen);
			}
		}
		
		private function enableCategoryButtons(enable:Boolean):void
		{
			var categoryButton:ButtonBehaviour;
			for each (categoryButton in _categoryButtons)
			{
				categoryButton.enabled = enable;
			}
		}
		
		private function onCategoryButtonClick(evt:Event):void
		{
			var category:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			dispatchEvent(EventFactory.requestCategory(category));
			dispatchEvent(new ClothesEvent(ClothesEvent.REQUEST_CLOTHES));
			if(_categoriesOpen) openCloseCategoryDropdown(false);
			onCategoryButtonOut(evt);
		}
		
		private function onCategoryButtonOver(evt:Event):void
		{
			var category:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateCategoryButtonLabel(category);
		}

		private function onCategoryButtonOut(evt:Event):void
		{
			var category:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateCategoryButtonLabel(category, GlobalConstants.COLOUR_BLUE);
		}
		
		private function onCategoryButtonDown(evt:Event):void
		{
			var category:uint = uint((evt.currentTarget as Sprite).name.substr(-1, 1));
			updateCategoryButtonLabel(category);
		}
		
		private function updateCategoryButtonLabel(category:uint, colour:uint=0xFFFFFF):void
		{
			TLFTextFieldUtils.formatTLFTextField(dressUpAsset.categoryDropdownClip.categoryDropdown["categoryBtn0" + category].label, CopyData.getCopy("category_" + category).toUpperCase(), 16, false, colour);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get dressUpAsset():ChooseOutfit_design
		{
			return _asset as ChooseOutfit_design;
		}
	}
}