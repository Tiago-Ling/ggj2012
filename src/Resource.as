package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Resource extends FlxSprite 
	{
		/*
		 * 0 - Initialized( natural form )
		 * 1 - Got shot, is now collectable by P2
		 * 2 - P2 processed and is holding 
		 * TODO 3 - P2 released resource
		 */
		public var currentBehavior:int;
		private var target:FlxObject;
		private var resourceType:int;
		private var delay:FlxDelay;
		
		public function Resource(X:Number=0, Y:Number=0, SimpleGraphic:Class=null, type:int = 0) 
		{
			super(X, Y, SimpleGraphic);
			resourceType = type;
			init();
		}
		
		private function init():void
		{
			loadGraphic(GameData.crystalSprite, true, false, 64, 64, false);
			
			switch(resourceType)
			{
				case 0:
					//makeGraphic(64, 64, 0xFFFF0000, false, null);
					addAnimation("Raw", [0], 0, true);
					addAnimation("Destroyed", [1], 0, true);
					addAnimation("Processed", [2], 0, true);
					break;
					
				case 1:
					//makeGraphic(64, 64, 0xFF990000, false, null);
					addAnimation("Raw", [3], 0, true);
					addAnimation("Destroyed", [4], 0, true);
					addAnimation("Processed", [5], 0, true);
					break;
					
				case 2:
					//makeGraphic(64, 64, 0xFF440000, false, null);
					addAnimation("Raw", [6], 0, true);
					addAnimation("Destroyed", [7], 0, true);
					addAnimation("Processed", [8], 0, true);
					break;
			}
			
			//this.velocity.y = 80;
			this.velocity.y = 120;
			
			currentBehavior = 0;
			play("Raw");
			
			delay = new FlxDelay(4000);
			delay.callback = onTimer;
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.y >= 800)
			{
				this.y = -this.height;
			}
			
			if (target != null)
			{
				this.x = target.x;
			}
		}
		
		public function dropAsBarrier():void {
			if ( target != null ) {
				var tempP2:Player2 = target as Player2;
				target = null;
				setBehavior(2);
				delay.abort();
				y += 96;
				//velocity.y = 80;
				velocity.y = 120;
				visible = true;
				
				if (this.x < 32)
					this.x = 0;
				else if (this.x < 96)
					this.x = 64;
				else if (this.x < 160)
					this.x = 128;
				else if (this.x < 224)
					this.x = 192;
				else if (this.x < 288)
					this.x = 256;
				else if (this.x < 352)
					this.x = 320;
				else if (this.x < 416)
					this.x = 384;
				else
					this.x = 448;
			}
		}
		
		public function setBehavior(behavior:int):void
		{
			currentBehavior = behavior;
			
			switch (currentBehavior)
			{
				case 0:
					delay.abort();
					play("Raw");
					break;
					
				case 1:
					play("Destroyed");
					delay.reset(2000);
					delay.start();
					break;
					
				case 2:
					play("Processed");
					break;
					
				default:
					
					break;
			}
		}
		
		public function setTarget(tgt:FlxObject):void
		{
			target = tgt;
			this.y = target.y - 64;
			velocity.y = 0;
		}
		
		public function getBehavior():int
		{
			return currentBehavior;
		}
		
		public function hasTarget():Boolean
		{
			return target != null;
		}
		
		private function onTimer():void
		{
			if (!flickering)
			{
				flicker(1.5);
				delay.reset(1500);
				delay.start();
			}
			else
			{
				setBehavior(0);
				delay.abort();
			}
		}
		
		public function cancelTimer():void
		{
			delay.abort();
		}
		
	}

}