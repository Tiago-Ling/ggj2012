package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class PreGameState extends FlxState 
	{
		private var screens:FlxSprite;
		private var currentFrame:int;
		private var blinkingTest:FlxText;
		
		public function PreGameState() 
		{
			
		}
		
		override public function create():void
		{
			currentFrame = 0;
			
			screens = new FlxSprite(0, 0);
			screens.loadGraphic(GameData.helpScreens, true, false, 512, 768, false);
			screens.addAnimation("0", [0], 0, true);
			screens.addAnimation("1", [1], 0, true);
			screens.addAnimation("2", [2], 0, true);
			screens.addAnimation("3", [3], 0, true);
			screens.play("0");
			add(screens);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				if (currentFrame >= 3)
					FlxG.switchState(new GameState);
				else
					currentFrame++;
					screens.play(currentFrame.toString());
			}
		}
		
	}

}