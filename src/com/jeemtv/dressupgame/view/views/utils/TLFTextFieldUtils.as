/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import fl.text.TLFTextField;

	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;

	import flash.text.AntiAliasType;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.utils.Dictionary;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	
	public class TLFTextFieldUtils
	{
		// private static properties
		
		private static var _direction:String;
		private static var _fontName:String;
		
		private static var _positionDictionary:Dictionary;
		
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function set direction(value:String):void
		{
			_direction = value;
			if(_direction == Direction.RTL) _positionDictionary = new Dictionary();
		}
		
		public static function set fontName(value:String):void
		{
			_fontName = value;
		}

		public static function formatTLFTextField(textField:TLFTextField, copy:String, fontSize:int=25, bold:Boolean=true, fontColour:uint=0xFFFFFF, align:String="center"):void
		{
			/*textField.embedFonts = true;
			textField.direction = _direction;
			
			var fmt:TextLayoutFormat = new TextLayoutFormat();
			fmt.fontLookup = FontLookup.EMBEDDED_CFF;
			fmt.fontFamily = _fontName;
			fmt.fontSize = fontSize;
			fmt.fontWeight = bold ? FontWeight.BOLD : FontWeight.NORMAL;
			fmt.color = fontColour;
			fmt.textAlign = align;
			fmt.paddingTop = -30;
			
			if(_direction == Direction.RTL)
			{
				trace("TLFTextFieldUtils.formatTLFTextField textField.toString() = " + textField.toString());
				var key:String = getTextFieldKey(textField);
				if(_positionDictionary[key] == undefined) _positionDictionary[key] = textField.y - 10;
				textField.y = _positionDictionary[key];
			}
			var tFlow : TextFlow = textField.textFlow;
			tFlow.hostFormat = fmt;
			
			textField.text = copy;*/
			
			var layoutFormat:TextLayoutFormat = new TextLayoutFormat();
            layoutFormat.color = fontColour;
            layoutFormat.fontFamily = _fontName;
			layoutFormat.fontWeight = bold ? FontWeight.BOLD : FontWeight.NORMAL;
            layoutFormat.textAlign = align;
			layoutFormat.fontSize = fontSize;

            var copyFlowBegin:String =  "<TextFlow xmlns='http://ns.adobe.com/textLayout/2008' fontFamily='" + _fontName + "' fontSize='" + fontSize + "'>";
            var copyFlowEnd:String = "</TextFlow>";
            var tflFlow:String = copyFlowBegin + copy + copyFlowEnd;
            
			textField.embedFonts = true;
            textField.tlfMarkup = tflFlow;
            textField.antiAliasType = AntiAliasType.ADVANCED;
			
			if(_direction == Direction.RTL)
			{
				var key:String = getTextFieldKey(textField);
				if(_positionDictionary[key] == undefined) _positionDictionary[key] = textField.y - fontSize * 0.66;
				textField.y = _positionDictionary[key];
			}
            
            var textFlow:TextFlow = textField.textFlow;
            textFlow.fontLookup = FontLookup.EMBEDDED_CFF;
            textFlow.hostFormat = layoutFormat;
            textFlow.flowComposer.updateAllControllers();
		}
		
		private static function getTextFieldKey(textField:TLFTextField):String
		{
			var key:String = textField.name;
			if(textField.parent)
			{
				key = textField.parent.name + "." + key;
				// if(textField.parent.parent) key = textField.parent.parent.name + "." + key;
			}
			return key;
		}
	}
}