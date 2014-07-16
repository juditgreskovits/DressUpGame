/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 6, 2013
 */
package com.jeemtv.dressupgame.view.views
{
	import com.jeemtv.dressupgame.constants.GlobalConstants;
	import com.jeemtv.dressupgame.constants.CopyConstants;
	import com.jeemtv.dressupgame.view.views.utils.TLFTextFieldUtils;
	import com.jeemtv.dressupgame.model.data.CopyData;
	import com.jeemtv.dressupgame.constants.AccessibilityConstants;
	import com.jeemtv.dressupgame.view.views.utils.ButtonBehaviour;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class HelpOverlayView extends AbstractOverlayView
	{
		// private static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		private var _closeButton:ButtonBehaviour;
		private var _resumeButton:ButtonBehaviour;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function HelpOverlayView()
		{
			super(new Help_design());
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
			
			TLFTextFieldUtils.formatTLFTextField(helpOverlayAsset.settings_dropdown.help_title, CopyData.getCopy(CopyConstants.HELP_TITLE), 22);
			TLFTextFieldUtils.formatTLFTextField(helpOverlayAsset.settings_dropdown.help1, CopyData.getCopy(CopyConstants.HELP_TEXT1), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(helpOverlayAsset.settings_dropdown.help2, CopyData.getCopy(CopyConstants.HELP_TEXT2), 17, true, GlobalConstants.COLOUR_PURPLE);
			TLFTextFieldUtils.formatTLFTextField(helpOverlayAsset.settings_dropdown.help3, CopyData.getCopy(CopyConstants.HELP_TEXT3), 17, true, GlobalConstants.COLOUR_PURPLE);
			
			TLFTextFieldUtils.formatTLFTextField(helpOverlayAsset.settings_dropdown.resumeBtn.label, CopyData.getCopy(CopyConstants.RESUME_BUTTON_LABEL));

			var tabIndex:uint = AccessibilityConstants.HELP_TAB_INDEX;
			_closeButton = new ButtonBehaviour(helpOverlayAsset.settings_dropdown.button_close, tabIndex++, close);
			_resumeButton = new ButtonBehaviour(helpOverlayAsset.settings_dropdown.resumeBtn, tabIndex++, close);
		}
		
		override public function activate():void
		{
			super.activate();
			
			_closeButton.enabled = true;
			_resumeButton.enabled = true;
		}
		
		override public function deactivate():void
		{
			_closeButton.enabled = false;
			_resumeButton.enabled = false;
			
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
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE GETTERS
		//------------------------------------------------------------
		
		private function get helpOverlayAsset():Help_design
		{
			return _asset as Help_design;
		}
		
	}
}