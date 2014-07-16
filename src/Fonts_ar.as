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
	public class Fonts_ar extends Sprite
	{
		//------------------------------------------------------------
		// PUBLIC PROPERTIES
		//------------------------------------------------------------
		
		[Embed(source='../assets/fonts/DroidKufi-Regular.ttf'
		,fontFamily  ='Droid'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  ='normal' // normal|bold
		,unicodeRange='U+0600-U+06FF,U+FB50-U+FDFF,U+FE70-U+FEFF'
		,embedAsCFF = 'true'
		,mimeType = 'application/x-font-truetype'
		,advancedAntiAliasing="true"
		)]
		public var DroidKufiRegular:Class;
		
		[Embed(source='../assets/fonts/DroidKufi-Bold.ttf'
		,fontFamily  ='Droid'
		,fontStyle   ='normal'
		,fontWeight  ='bold'
		,unicodeRange = 'U+0600-U+06FF,U+FB50-U+FDFF,U+FE70-U+FEFF'
		,embedAsCFF = 'true'
		,mimeType = 'application/x-font-truetype'
		,advancedAntiAliasing="true"
		)]
		public var DroidKufiBold:Class;
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function Fonts_ar()
		{
			super();
			
			Font.registerFont(DroidKufiRegular);
			Font.registerFont(DroidKufiBold);
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