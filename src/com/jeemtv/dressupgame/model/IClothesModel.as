
/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 5, 2013
 */
package com.jeemtv.dressupgame.model
{
	import com.jeemtv.dressupgame.model.vo.AbstractClothVO;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public interface IClothesModel
	{
		
		//------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------

		function getClothes(doll:uint, category:uint):Vector.<AbstractClothVO>;
		
		function getCloth(id:String, doll:uint, category:uint):AbstractClothVO;
	}
}