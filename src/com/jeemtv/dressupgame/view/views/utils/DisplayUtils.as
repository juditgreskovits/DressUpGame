/**
 * @author juditgreskovits
 * @version 0.1
 * @since Aug 20, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.IBitmapDrawable;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.Font;
	
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	public class DisplayUtils
	{	
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function hasFrameLabel(mc:MovieClip, label:String):Boolean
		{
			var frameLabels:Array = mc.currentLabels;
			var frameLabel:FrameLabel;
			for each(frameLabel in frameLabels)
			{
				if(frameLabel.name == label) return true;
			}
			return false;
		}
		
		public static function stopMovieClips(d:DisplayObjectContainer):void
		{
			var c:DisplayObject;
			var i:int = 0, l:int = d.numChildren;
			for(; i<l; i++)
			{
				c = d.getChildAt(i);
				if(c is MovieClip) (c as MovieClip).stop();
				if(c is DisplayObjectContainer && (c as DisplayObjectContainer).numChildren) stopMovieClips(c as DisplayObjectContainer);
			}
		}
		
		public static function enumerateFonts():void
		{
			var embeddedFonts:Array = Font.enumerateFonts(false);
			embeddedFonts.sortOn("fontName", Array.CASEINSENSITIVE);
			trace("\n----- Enumerate Fonts -----");
			for(var i : int = 0;i < embeddedFonts.length;i++)
			{
				trace(embeddedFonts[i].fontName);
			}
			trace("---------------------------\n");
		}
		
		public static function drawBitmapData(source:IBitmapDrawable):BitmapData
		{
			var s:DisplayObject = source as DisplayObject;
			var bmpd:BitmapData = new BitmapData(s.width, s.height, true, 0x0);
			var matrix:Matrix = new Matrix(s.scaleX, 0, 0, s.scaleY);
			bmpd.draw(source, matrix);
			return bmpd;
		}
		
		public static function enableTabbing(ios:Vector.<InteractiveObject>):void
		{
			var io:InteractiveObject;
			for each (io in ios)
			{
				io.tabEnabled = true;
			}
		}
		
		public static function disableTabbing(exclude:InteractiveObject, doc:DisplayObjectContainer, ios:Vector.<InteractiveObject>=null):Vector.<InteractiveObject>
		{
			if(!ios) ios = new Vector.<InteractiveObject>();
			var io:InteractiveObject;
			var i:uint, l:uint = doc.numChildren;
			for(; i<l; i++)
			{
				io = doc.getChildAt(i) as InteractiveObject;
				// trace("DisplayUtils.disableTabbing io = " + io.tabEnabled);
				if(io && io.tabEnabled && io != exclude)
				{
					io.tabEnabled = false;
					ios.push(io);
				}
				if(io is DisplayObjectContainer) disableTabbing(exclude, io as DisplayObjectContainer, ios);
			}
			return ios;
		}
		
		public static function isPositionWithinRange(startPosition:Point, endPosition:Point, range:Number=2):Boolean
		{
			var diff:Point = startPosition.subtract(endPosition);
			return Math.abs(diff.x) <= range && Math.abs(diff.y) <= range;
		}
	}
}