/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package 
{
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	import flash.display.Sprite;
	import flash.text.Font;
	
	[SWF(width=1,height=1,backgroundColor=0x000000,frameRate=30)]
	public class Fonts_en extends Sprite
	{
		//------------------------------------------------------------
		// PUBLIC PROPERTIES
		//------------------------------------------------------------
		
		[Embed(source='../assets/fonts/DroidSans.ttf'
		,fontFamily = 'Droid'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  ='normal' // normal|bold
		,unicodeRange='U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E'
		,embedAsCFF = 'true'
		,mimeType = 'application/x-font'
		,advancedAntiAliasing='true'
		)]
		public static const DroidSans:Class;
		
		[Embed(source='../assets/fonts/DroidSans-Bold.ttf'
		,fontFamily = 'Droid'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  ='bold' // normal|bold
		,unicodeRange='U+0020,U+0041-U+005A,U+0020,U+0061-U+007A,U+0030-U+0039,U+002E,U+0020-U+002F,U+003A-U+0040,U+005B-U+0060,U+007B-U+007E'
		,embedAsCFF = 'true'
		,mimeType = 'application/x-font'
		,advancedAntiAliasing='true'
		)]
		public static const DroidSansBold:Class;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function Fonts_en()
		{
			super();
			
			Font.registerFont(DroidSans);
			Font.registerFont(DroidSansBold);
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
		
		//------------------------------------------------------------
		// PROTECTED METHODS
		//------------------------------------------------------------
		
		//------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------
		
	}
}