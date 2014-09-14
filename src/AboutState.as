package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxScreenGrab;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class AboutState extends FlxState 
	{
		//private var scoreText:FlxText;
		//private var titleText:FlxText;
		//private var playAgainText:FlxText;
		private var credits:FlxSprite;
		
		public function AboutState() 
		{
			
		}
		
		override public function create():void
		{
			credits = new FlxSprite(0, 0);
			credits.loadGraphic(GameData.credits, false, false, 512, 768, false);
			add(credits);
			
			FlxG.playMusic(GameData.menuMusic, 0.5);
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justPressed("ESCAPE") )
			{
				FlxG.fade(0xFF000000, 1, goBackToMenu);
			}
		}
		
		private function goBackToMenu():void
		{
			FlxG.switchState( new MenuState() );
		}
		
	}

}