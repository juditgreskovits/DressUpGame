/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 15, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;

	import flash.display.MovieClip;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class CustomClothesAnimationBehaviour extends ClothesAnimationBehaviour
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _designStudioButtonClickFunction:Function;
		private var _editButtonClickFunction:Function;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function CustomClothesAnimationBehaviour(asset:MovieClip, clothDownFunction:Function, transitionOutEndFunction:Function, designStudioButtonClickFunction:Function, editButtonClickFunction:Function, tabIndex:uint)
		{
			super(asset, clothDownFunction, transitionOutEndFunction, tabIndex);
			
			_designStudioButtonClickFunction = designStudioButtonClickFunction;
			_editButtonClickFunction = editButtonClickFunction;
			createDesignStudioAndEditButtons();
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		override protected function setClothVisbility(clothContainer:MovieClip, visible:Boolean):void
		{
			super.setClothVisbility(clothContainer, visible);
			clothContainer.editBtn.visible = visible;
		}
		
		override protected function removeClothButton(clothContainer:MovieClip):void
		{
			if(clothContainer.numChildren > 3) clothContainer.removeChildAt(1);
		}
		
		override protected function createClothButton(clothes:Vector.<AbstractClothVO>, index:uint, clothContainer:MovieClip):void
		{
			if(clothes && index <= clothes.length)
			{
				super.createClothButton(clothes, index, clothContainer);
				clothContainer.editBtn.visible = true;
				clothContainer.designStudioBtn.visible = false;
			}
			else
			{
				clothContainer.editBtn.visible = false;
				clothContainer.designStudioBtn.visible = true;
			}
		}
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function createDesignStudioAndEditButtons():void
		{
			var i:uint, clothContainer:MovieClip, designStudioButton:ButtonBehaviour, editButton:ButtonBehaviour;
			while(clothContainer = _asset["item0" + ++i])
			{
				TLFTextFieldUtils.formatTLFTextField(clothContainer.designStudioBtn.label, CopyData.getCopy(CopyConstants.DESIGN_YOUR_OWN), 15);
				designStudioButton = new ButtonBehaviour(clothContainer.designStudioBtn, i, _designStudioButtonClickFunction);
				editButton = new ButtonBehaviour(clothContainer.editBtn, i, _editButtonClickFunction);
				designStudioButton.enabled = editButton.enabled = true;
			}
		}
		
	}
}