package  
{
	import flash.events.DRMCustomProperties;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBar;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Player2 extends FlxSprite 
	{
		private var attachedResource:Resource;
		private var bar:FlxBar;
		private var parent:FlxState;
		
		private var lastPosX:Number;
		
		public function Player2(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, par:FlxState = null) 
		{
			super(X, Y, SimpleGraphic);
			parent = par;
			init();
		}
		
		private function init():void
		{
			//makeGraphic(64, 75, 0xFF123AA0, false, null);
			
			loadGraphic(GameData.player2NoCrystal, true, true, 64, 75, false);
			
			addAnimation("ProcessCrystal", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 29,
											30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
											49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
											68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85], 16, false);
											
/*			addAnimation("ProcessCrystal", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 29,
											30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
											49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68], 30, false);*/
			addAnimation("WalkCrystal", [88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105], 24, true);
			addAnimation("PlaceCrystal", [86, 87], 6, true);
			addAnimation("WalkNoCrystal", [106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123], 24, true);
			
			play("WalkNoCrystal");
			//play("PlaceCrystal");
			
			bar = new FlxBar(this.x, this.y - 18, FlxBar.FILL_LEFT_TO_RIGHT, 64, 10, this, "health", 0, 100, true);
			bar.percent = 0;
			bar.setCallbacks(null, barFullCallback, false);
			bar.visible = false;
			parent.add(bar);
			
			addAnimationCallback(onAnimationEnd);
			this.path = new FlxPath();
			this.path.add(0, 0);
			this.followPath(this.path, 190, FlxObject.PATH_FORWARD, false);
			
		}
		
		private function onAnimationEnd(name:String, fNumber:uint, fIndex:uint):void
		{
			if (name == "PlaceCrystal" && fNumber == 1)
			{
				FlxG.log("ok!");
				play("WalkNoCrystal");
			}
		}
		
		private function handleInput():void
		{
			// when there is resource attached, a Click will drop it
			if ( attachedResource != null ) {
				//FlxG.log("Releasing crystal? "+attachedResource.getBehavior().toString() );
				if (FlxG.mouse.justPressed() && attachedResource.getBehavior() == 2)
				{
					//attachedResource.releaseTarget()
					if ( attachedResource.hasTarget() ) {
						play("PlaceCrystal");
						FlxG.log(_curAnim.name);
						//FlxG.log("Dropping crystal!")
						FlxG.play(GameData.blockPlacing, 1.0, false, true);
						attachedResource.dropAsBarrier();
						attachedResource = null;
						
					}
				}
			}
		}
		
		public function getAttachedResource():Resource
		{
			return attachedResource;
		}
		
		override public function update():void
		{
			super.update();
			
			if (_curAnim.name != "ProcessCrystal")
			{
				var tempX:Number = FlxG.mouse.getWorldPosition().x;
				if (tempX > 354)
				{
					tempX = 354;
				}
				
				if (tempX < 94)
				{
					tempX = 94;
				}
				
				//this.x = tempX;
				
				path.nodes[0].x = tempX;
				path.nodes[0].y = 360;
				followPath(path, 190, FlxObject.PATH_FORWARD, false);
				//path.addAt(FlxG.mouse.getWorldPosition().x, 322, 0);
			}
			else
			{
				stopFollowingPath(false);
				velocity.x = 0;
				//FlxG.log("stopFollowing");
			}
			
			var diff:Number = tempX - lastPosX;
			
			if (diff > 0)
			{
				this.facing = 0x0010;
			}
			else if (diff < 0)
			{
				
				this.facing = 0x0001;
			}
			else
			{
				//TODO: Play Idle Animation 
			}
			
			handleInput();
			
			if (_curAnim.name == "ProcessCrystal" && attachedResource != null)
			{
				//FlxG.log("processing");
				health += 2;
				bar.x = this.x;
				bar.visible = true;
			}
			else
			{
				//FlxG.log("Anim over");
				health = 0;
				bar.percent = 0;
				bar.visible = false;
			}
			
			lastPosX = tempX;
		}
		
		public function setResource(res:Resource):void
		{
			attachedResource = res;
			//play("WalkCrystal");
			play("ProcessCrystal");
		}
		
		private function barFullCallback():void
		{
			play("WalkCrystal");
			//attachedResource.releaseTarget();
			attachedResource.setBehavior(2);
			attachedResource.cancelTimer();
			bar.percent = 0;
			health = 0;
			bar.visible = false;
		}
		
		public function setAnimation(anim:String):void
		{
			play(anim);
		}
		
		public function getAnimationName():String
		{
			return _curAnim.name;
		}
		
	}

}