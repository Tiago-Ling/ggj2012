package  
{
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Decoration extends FlxSprite 
	{
		
		public function Decoration(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			init();
		}
		
		private function init():void
		{
			loadGraphic(GameData.decor, false, false, 64, 64, false);
			
			addAnimation("0", [0]);
			addAnimation("1", [1]);
			addAnimation("2", [2]);
			addAnimation("3", [3]);
			addAnimation("4", [4]);
			addAnimation("5", [5]);
			addAnimation("6", [6]);
			addAnimation("7", [7]);
			addAnimation("8", [8]);
			addAnimation("9", [9]);
			addAnimation("10", [10]);
			addAnimation("11", [11]);
			addAnimation("12", [12]);
			addAnimation("13", [13]);
			
			var randInt:int = FlxMath.rand(0, 13);
			play(randInt.toString());
			
			//velocity.y = 80;
			velocity.y = 120;
		}
		
		override public function update():void
		{
			super.update();
			
/*			if (GameData.score < 50000)
			{
				velocity.y = 95;
			}
			else if (GameData.score < 100000)
			{
				velocity.y = 110;
			}
			else if (GameData.score < 150000)
			{
				velocity.y = 125;
			}
			else if (GameData.score < 200000)
			{
				velocity.y = 135;
			}
			else if (GameData.score < 250000)
			{
				velocity.y = 145;
			}
			else if (GameData.score < 300000)
			{
				velocity.y = 155;
			}
			else
			{
				velocity.y = 180;
			}*/
			
			if (this.y > 800)
			{
				var randInt:int = FlxMath.rand(0, 9);
				
				if (randInt < 5)
					this.x = 0;
				else
					this.x = 448;
					
				randInt = FlxMath.rand(0, 13);
				play(randInt.toString());
					
				//this.y = -64;
				this.y = SlotManager.getFreeYSlot(this.x / 64) * -1;
			}
		}
		
	}

}