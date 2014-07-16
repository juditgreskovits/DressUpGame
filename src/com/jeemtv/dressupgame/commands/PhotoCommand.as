/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 16, 2013
 */
package com.jeemtv.dressupgame.commands
{
	import com.jeemtv.dressupgame.constants.TrackingConstants;
	import com.jeemtv.dressupgame.events.PhotoEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.events.utils.EventFactory;
	import com.jeemtv.dressupgame.model.DollsModel;
	import com.jeemtv.dressupgame.model.LocationsModel;
	import com.jeemtv.dressupgame.model.PhotoModel;
	import com.jeemtv.dressupgame.model.vo.PhotoVO;

	import org.robotlegs.mvcs.Command;

	import flash.display.Sprite;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintJobOrientation;
	
	//------------------------------------------------------------------------
	//  IMPORTS
	//------------------------------------------------------------------------
	
	
	public class PhotoCommand extends Command
	{
		
		//------------------------------------------------------------------------
		//  INJECTED PROPERTIES
		//------------------------------------------------------------------------
		
		[Inject]
		public var photoEvent:PhotoEvent;
		
		[Inject]
		public var photoModel:PhotoModel;
		
		[Inject]
		public var dollsModel:DollsModel;
		
		[Inject]
		public var locationsModel:LocationsModel;
		
		//------------------------------------------------------------------------
		//  PUBLIC OVERRIDE METHODS
		//------------------------------------------------------------------------
		
		override public function execute():void
		{
			switch(photoEvent.type)
			{
				case PhotoEvent.REQUEST_PHOTOS:
					dispatch(EventFactory.updatePhotos(photoModel.getCurrentPhotos(), photoModel.hasNextAndPrevious()));
					break;
					
				case PhotoEvent.REQUEST_PREVIOUS_PHOTOS:
					dispatch(EventFactory.updatePhotos(photoModel.getPreviousPhotos(), photoModel.hasNextAndPrevious()));
					break;	
				
				case PhotoEvent.REQUEST_NEXT_PHOTOS:
					dispatch(EventFactory.updatePhotos(photoModel.getNextPhotos(), photoModel.hasNextAndPrevious()));
					break;		
					
				case PhotoEvent.REQUEST_PHOTO:
					var photo:PhotoVO = photoEvent.id ? photoModel.getPhotoById(photoEvent.id) : photoModel.getPhotoByIndex(photoEvent.index);
					dispatch(EventFactory.updatePhoto(photo));
					dispatch(EventFactory.requestLocation(photo.location.id));
					break;
					
				case PhotoEvent.REQUEST_ADD_PHOTO:
					var track:Boolean = photoModel.addPhoto(photoEvent.doll, locationsModel.getLocation());
					dispatch(EventFactory.updatePhotos(photoModel.getCurrentPhotos(), photoModel.hasNextAndPrevious()));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					if(track) dispatch(EventFactory.trackEvent(TrackingConstants.CATEGORY_PHOTO, TrackingConstants.ACTION_TAKEN));
					break;
					
				case PhotoEvent.REQUEST_REMOVE_PHOTO:
					var photos:Vector.<PhotoVO> = photoModel.removePhoto(photoEvent.index);
					dispatch(EventFactory.updatePhotos(photos, photoModel.hasNextAndPrevious()));
					dispatch(new StorageServiceEvent(StorageServiceEvent.REQUEST_SAVE));
					break;	
					
				case PhotoEvent.REQUEST_PRINT:
					var print:Sprite = photoEvent.print;
					var printJob:PrintJob = new PrintJob();
					print.scaleX = photoEvent.print.scaleY = 0.95;
					if(printJob.orientation != PrintJobOrientation.LANDSCAPE) print.rotation = 90;
					if(printJob.start())
					{
						try { printJob.addPage(photoEvent.print, null, new PrintJobOptions(true)); }
						catch (err:Error) { trace("PhotoCommand.execute printJob error"); }
					}
					printJob.send();
					print.scaleX = photoEvent.print.scaleY = 1.0;
					print.rotation = 0.0;
					break;		
			}
		}
	}
}