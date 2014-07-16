/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package com.jeemtv.dressupgame.view.mediators
{
	import com.jeemtv.dressupgame.constants.NavigationConstants;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	import com.jeemtv.dressupgame.events.PatternsEvent;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	import com.jeemtv.dressupgame.view.views.DesignStudioView;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	
	public class DesignStudioMediator extends AbstractAddressMediator
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DesignStudioMediator()
		{
			super(NavigationConstants.ADDRESS_DESIGN_STUDIO);
		}
		
		//------------------------------------------------------------
		// GETTERS & SETTERS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			eventMap.mapListener(eventDispatcher, CustomClothesEvent.UPDATE, onClothUpdate);
			eventMap.mapListener(eventDispatcher, CustomClothesEvent.COMPLETE, onClothComplete);
			
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_CREATE, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_COMPLETE, dispatch);
			eventMap.mapListener(designStudioView, PatternsEvent.REQUEST_NEXT, dispatch);
			eventMap.mapListener(designStudioView, PatternsEvent.REQUEST_PREVIOUS, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_MATERIAL_UPDATE, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_COLOUR_UPDATE, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_STAMP_ADD, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_UNDO, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_REDO, dispatch);
			eventMap.mapListener(designStudioView, CustomClothesEvent.REQUEST_CLEAR, dispatch);
		}
		
		override public function onRemove():void
		{
			eventMap.unmapListener(eventDispatcher, CustomClothesEvent.UPDATE, onClothUpdate);
			eventMap.unmapListener(eventDispatcher, CustomClothesEvent.COMPLETE, onClothComplete);
			
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_CREATE, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_COMPLETE, dispatch);
			eventMap.unmapListener(designStudioView, PatternsEvent.REQUEST_NEXT, dispatch);
			eventMap.unmapListener(designStudioView, PatternsEvent.REQUEST_PREVIOUS, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_MATERIAL_UPDATE, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_COLOUR_UPDATE, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_STAMP_ADD, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_UNDO, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_REDO, dispatch);
			eventMap.unmapListener(designStudioView, CustomClothesEvent.REQUEST_CLEAR, dispatch);
			
			super.onRemove();
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
		
		private function onClothUpdate(evt:CustomClothesEvent):void
		{
			var vo:CustomClothVO = evt.cloth;
			designStudioView.updatePattern(vo.pattern);
			designStudioView.updateMaterial(vo.material);
			designStudioView.updateColour(vo.colour);
			designStudioView.updateStamps(vo.cloneStamps());
			designStudioView.updateButtons(evt.hasPrevious, evt.hasNext);
		}
		
		private function onClothComplete(evt:CustomClothesEvent):void
		{
			var vo:CustomClothVO = evt.cloth;
			designStudioView.complete(vo.customClothBmp);
			designStudioView.enabled = false;
			designStudioView.updateButtons(false, false);
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get designStudioView():DesignStudioView
		{
			return abstractView as DesignStudioView;
		}
	}
}