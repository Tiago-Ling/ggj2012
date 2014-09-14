package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Dart extends FlxSprite 
	{
		
		public function Dart(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			init();
		}
		
		private function init():void
		{
			//makeGraphic(4, 8, 0xFFFF0000, false, null);
			loadGraphic(GameData.bulletSprite, true, false, 22, 22, false);
			addAnimation("Idle", [0, 1], 12, true);
			play("Idle");
			this.velocity.y = -240;
			//kill();
		}
		
		override public function kill():void
		{
			super.kill();
			
			//exists = true;
			
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.y < -10)
				kill();
				//this.health = 0;
		}
		
		
		
	}

}