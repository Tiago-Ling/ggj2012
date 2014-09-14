package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Background
	{
		private var parent:FlxState;
		private var part1:FlxSprite;
		private var part2:FlxSprite;
		
		public function Background(par:FlxState) 
		{
			parent = par;
			init();
		}
		
		private function init():void
		{
			part1 = new FlxSprite(0, 0);
			//part1.makeGraphic(512, 768, 0xFF123EAD, false, null);
			part1.loadGraphic(GameData.background, false, false, 512, 768, false);
			//part1.velocity.y = 80;
			part1.velocity.y = 120;
			parent.add(part1);
			
			part2 = new FlxSprite(0, -768);
			//part2.makeGraphic(512, 768, 0xFFFFAB00, false, null);
			part2.loadGraphic(GameData.background, false, false, 512, 768, false);
			//part2.velocity.y = 80;
			part2.velocity.y = 120;
			parent.add(part2);
			
			//FlxG.watch(part1, "y", "part1 y:");
			//FlxG.watch(part2, "y", "part2 y:");
		}
		
		public function update():void
		{
/*			if (GameData.score < 50000)
			{
				part1.velocity.y = 95;
				part2.velocity.y = 95;
			}
			else if (GameData.score < 100000)
			{
				part1.velocity.y = 110;
				part2.velocity.y = 110;
			}
			else if (GameData.score < 150000)
			{
				part1.velocity.y = 125;
				part2.velocity.y = 125;
			}
			else if (GameData.score < 200000)
			{
				part1.velocity.y = 135;
				part2.velocity.y = 135;
			}
			else if (GameData.score < 250000)
			{
				part1.velocity.y = 145;
				part2.velocity.y = 145;
			}
			else if (GameData.score < 300000)
			{
				part1.velocity.y = 155;
				part2.velocity.y = 155;
			}
			else
			{
				part1.velocity.y = 180;
				part2.velocity.y = 180;
			}*/
			
			if (part1.y >= 768)
			{
				part1.y = -768;
			}
			
			if (part2.y >= 768)
			{
				part2.y = -768;
				
			}
		}
		
		public function stop():void
		{
			part1.acceleration.y = 0;
			part2.acceleration.y = 0;
			part1.drag.y = 1;
			part2.drag.y = 1;
			
		}
		
		public function setSpeed(spd:Number):void
		{
			part1.velocity.y = spd;
			part2.velocity.y = spd;
		}
		
	}

}