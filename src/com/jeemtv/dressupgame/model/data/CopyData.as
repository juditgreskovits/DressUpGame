/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 21, 2013
 */
package com.jeemtv.dressupgame.model.data
{	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	import flash.utils.Dictionary;
	
	public class CopyData
	{	
		// private static properties
		
		private static var _copyDictionary:Dictionary;
		
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function parseCopyXML(copyXML:XML):void
		{
			_copyDictionary = new Dictionary();
			var copyXMLList:XMLList = copyXML.copy;
			for each (copyXML in copyXMLList)
			{
				_copyDictionary[String(copyXML.@id)] = String(copyXML);
			}
		}
		
		public static function getCopy(id:String):String
		{
			if(_copyDictionary[id] != undefined) return _copyDictionary[id];
			return "Copy is missing for id: " + id;
		}
	}
}