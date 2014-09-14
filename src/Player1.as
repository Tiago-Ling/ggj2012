package  
{
	//import flash.events.WeakFunctionClosure;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Player1 extends FlxSprite 
	{
		private var darts:FlxGroup;
		private var parent:FlxState;
		//private var dart:Dart;
		
		public function Player1(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, par:FlxState = null, ammo:FlxGroup = null) 
		{
			super(X, Y, SimpleGraphic);
			parent = par;
			darts = ammo;
			init();
		}
		
		private function init():void
		{
			//makeGraphic(64, 75, 0xFFFFFFFF, false, null);
			loadGraphic(GameData.player1Sheet, true, false, 64, 75, false);
			addAnimation("Walk", [0, 1, 2, 3, 4, 5], 16, true);
			addAnimation("Shoot", [6, 7, 8, 9, 10, 11], 16, false);
			addAnimationCallback(onAnimationEnd);
			play("Walk");
		}
		
		private function onAnimationEnd(name:String, fNumber:uint, fIndex:uint):void
		{
			//if (name == "Shoot" && fIndex == 11)
			if (fIndex == 11)
			{
				FlxG.log("Shoot End");
				play("Walk");
			}
		}
		
		private function handleInput():void
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				var dart:Dart;
				play("Shoot");
				//var tempBasic:FlxBasic = darts.getFirstDead();
				dart = darts.recycle(Dart) as Dart;
				//var tempDart:Dart = tempBasic as Dart;
   				if (dart != null)
				{
					dart.revive();
					dart.x = this.x + 21;
					dart.y = this.y;
					FlxG.play(GameData.shotSnd, 1.0, false, true);
				}
				else
				{
					FlxG.log("Does the bullet appear?");
				}
				
				FlxG.log("Darts current size: " + darts.length);
			}
			
			if (FlxG.keys.justPressed("A"))
			{
				this.velocity.x = -190;
			}
			else if (FlxG.keys.justPressed("D"))
			{
				this.velocity.x = 190;
			}
			
			if ( this.x > 354 ) {
				this.x = 354;
			}
			
			if ( this.x < 94 ) {
				this.x = 94;
			}
			
			
			if (FlxG.keys.justReleased("A") || FlxG.keys.justReleased("D"))
			{
				this.velocity.x = 0;
			}
		}
		
		override public function update():void
		{
			super.update();
			handleInput();
		}
		
	}

}