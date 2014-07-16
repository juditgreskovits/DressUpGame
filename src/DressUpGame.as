/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 19, 2013
 */
package 
{
	import com.google.analytics.GATracker;
	import com.jeemtv.dressupgame.ApplicationContext;

	import flash.display.Sprite;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
		
	
	//------------------------------------------------------------
	//  SWF META DATA
	//------------------------------------------------------------
	
	[SWF(backgroundColor="#FFFFFF", width="852", height="520", frameRate="30")]
	[Frame(factoryClass="com.jeemtv.dressupgame.preloader.Preloader")]
	public class DressUpGame extends Sprite
	{
		// public static constants
		
		// public properties
		
		// protected properties
		
		// private properties
		
		//------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------
		
		public function DressUpGame(tracker:GATracker)
		{
			super();

			new ApplicationContext(this, tracker);
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