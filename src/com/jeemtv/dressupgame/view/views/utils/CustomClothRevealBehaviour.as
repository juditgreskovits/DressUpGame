/**
 * @author juditgreskovits
 * @version 0.1
 * @since Sep 25, 2013
 */
package com.jeemtv.dressupgame.view.views.utils
{
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.ColorChange;
	import org.flintparticles.common.actions.ScaleImage;
	import org.flintparticles.common.counters.TimePeriod;
	import org.flintparticles.common.easing.Sine;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.ScaleImageInit;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.RotateToDirection;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import org.flintparticles.twoD.zones.BitmapDataZone;
	import org.flintparticles.twoD.zones.DiscZone;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//------------------------------------------------------------
	// IMPORTS
	//------------------------------------------------------------
	
	
	public class CustomClothRevealBehaviour
	{
		//------------------------------------------------------------
		// PUBLIC STATIC METHODS
		//------------------------------------------------------------
		
		public static function activateParticleEffect(item:DisplayObject):void
		{
			var itemRectangle:Rectangle = item.getRect(item.parent);
			var bmpd:BitmapData = new BitmapData(item.width, item.height, true, 0x00000000);
			bmpd.draw(item, new Matrix(item.scaleX, 0, 0, item.scaleY));
			
			var numParticles:int = (item.width+item.height)*0.01*15;
			var _emitter:Emitter2D = new Emitter2D();
			_emitter.counter = new TimePeriod(numParticles, 1, Sine.easeInOut); // n of total particles, time, easing
			_emitter.addInitializer(new SharedImage(new Sparkle()));
			_emitter.addInitializer(new Lifetime(0.5, 1.25));
			_emitter.addInitializer(new ScaleImageInit(0.25, 1.25));
			_emitter.addInitializer(new Position(new BitmapDataZone(bmpd)));
			_emitter.addInitializer(new Velocity(new DiscZone(new Point(0, 0), 10, 5)));
			
			_emitter.addAction(new Age());
			_emitter.addAction(new Move());
			_emitter.addAction(new ScaleImage(1.1, 1.25));
			_emitter.addAction(new RotateToDirection());
			_emitter.addAction(new ColorChange(0xFFFFFFFF, 0x00FFFFFF));
			
			var asset:DisplayObject = new Sparkle();
			var margin:Number = 10 + Math.max(asset.width, asset.height);
			var canvas:Rectangle = new Rectangle(0, 0, item.width, item.height);
			canvas.inflate(margin, margin);
			var _renderer:BitmapRenderer = new BitmapRenderer(canvas);
			_renderer.addFilter( new BlurFilter( 1.25, 1.25, 3 ) );
			_renderer.mouseEnabled = false;
			_renderer.mouseChildren = false;
			_renderer.addEmitter(_emitter);
			item.parent.addChild(_renderer);
			
			_renderer.x = itemRectangle.x;
			_renderer.y = itemRectangle.y;
			_emitter.start();
		}
		
	}
}