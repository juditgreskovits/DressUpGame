/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 29, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import com.jeemtv.dressupgame.model.vo.CustomClothVO;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.model.PatternsModel;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.CustomClothesModel;
	import com.jeemtv.dressupgame.events.CustomClothesEvent;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	import org.robotlegs.mvcs.Command;
	
	public class CustomClothesCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var customClothesEvent:CustomClothesEvent;
		
		[Inject]
		public var customClothesModel:CustomClothesModel;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		[Inject]
		public var patternsModel:PatternsModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(customClothesEvent.type)
			{
				case CustomClothesEvent.REQUEST_CREATE:
					if(GlobalConstants.getCategoryType(dollsModel.category) == GlobalConstants.CATEGORY_TYPE_CUSTOM)
					{
						var category:uint = GlobalConstants.customCategoryToCategory(dollsModel.category);
						customClothesModel.createCloth(patternsModel.currentCategoryPattern(dollsModel.id, category), dollsModel.id);
					}
					else customClothesModel.createCloth(patternsModel.currentPattern(dollsModel.id), dollsModel.id);
					break;
					
				case CustomClothesEvent.REQUEST_EDIT:
					var vo:CustomClothVO = customClothesModel.getCloth(customClothesEvent.id, dollsModel.id, dollsModel.category) as CustomClothVO;
					customClothesModel.editCloth(vo, dollsModel.id);
					break;
				
				case CustomClothesEvent.REQUEST_COMPLETE:
					customClothesModel.completeCloth(dollsModel.id);
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_CUSTOM_CLOTH, TrackingConstants.ACTION_MADE));
					break;
					
				case CustomClothesEvent.REQUEST_PATTERN_UPDATE:
					customClothesModel.updatePattern(customClothesEvent.pattern, dollsModel.id);
					break;
				
				case CustomClothesEvent.REQUEST_MATERIAL_UPDATE:
					customClothesModel.updateMaterial(customClothesEvent.material, dollsModel.id);
					break;
				
				case CustomClothesEvent.REQUEST_COLOUR_UPDATE:
					customClothesModel.updateColour(customClothesEvent.colour, dollsModel.id);
					break;
					
				case CustomClothesEvent.REQUEST_STAMP_ADD:
					customClothesModel.addStamp(customClothesEvent.stamp, dollsModel.id);
					break;
					
				case CustomClothesEvent.REQUEST_UNDO:
					customClothesModel.undo(dollsModel.id);
					break;
					
				case CustomClothesEvent.REQUEST_REDO:
					customClothesModel.redo(dollsModel.id);
					break;
				
				case CustomClothesEvent.REQUEST_CLEAR:
					customClothesModel.clear(dollsModel.id);
					break;				
			}
		}
	}
}