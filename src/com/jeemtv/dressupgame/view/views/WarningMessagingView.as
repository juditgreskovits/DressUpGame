/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.events.NavigationEvent;
	import com.jeemtv.dressupgame.events.StorageServiceEvent;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;

	import flash.events.Event;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class WarningMessagingView extends AbstractOverlayView
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _closeButton:ButtonBehaviour;
		private var _cancelButton:ButtonBehaviour;
		private var _okButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function WarningMessagingView()
		{
			super(new Warning_design());
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
			
			// copy 2 labels 2 buttons
			
			TLFTextFieldUtils.formatTLFTextField(warningMessagingAsset.warning_dropdown.title, CopyData.getCopy(CopyConstants.WARNING_TITLE), 22);
			TLFTextFieldUtils.formatTLFTextField(warningMessagingAsset.warning_dropdown.message, CopyData.getCopy(CopyConstants.RESET_WARNING_MESSAGE), 22, false, GlobalConstants.COLOUR_PURPLE);
			
			TLFTextFieldUtils.formatTLFTextField(warningMessagingAsset.warning_dropdown.cancelBtn.label, CopyData.getCopy(CopyConstants.CANCEL_BUTTON_LABEL));
			TLFTextFieldUtils.formatTLFTextField(warningMessagingAsset.warning_dropdown.okBtn.label, CopyData.getCopy(CopyConstants.CONFIRM_BUTTON_LABEL));
			
			// three buttons
			var tabIndex:uint = AccessibilityConstants.WARNING_TAB_INDEX;
			_cancelButton = new ButtonBehaviour(warningMessagingAsset.warning_dropdown.cancelBtn, tabIndex++, close);
			_okButton = new ButtonBehaviour(warningMessagingAsset.warning_dropdown.okBtn, tabIndex++, onOkButtonClick);
			_closeButton = new ButtonBehaviour(warningMessagingAsset.warning_dropdown.closeBtn, tabIndex++, close);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_closeButton.enabled = true;
			_cancelButton.enabled = true;
			_okButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_closeButton.enabled = false;
			_cancelButton.enabled = false;
			_okButton.enabled = false;
			
			super.deactivate();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PROTECTED OVERRIDE METHODS
		//------------------------------------------------------------
		
		override protected function close(evt:Event=null):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.REQUEST_MESSAGING));
		}
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		private function onOkButtonClick(evt:Event):void
		{
			dispatchEvent(new StorageServiceEvent(StorageServiceEvent.REQUEST_RESET));
			addFunctionToTransitionComplete(dispatchEvent, [new NavigationEvent(NavigationEvent.REQUEST_OVERLAY)]);
			close();
		}
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get warningMessagingAsset():Warning_design
		{
			return _asset as Warning_design;
		}
		
	}
}