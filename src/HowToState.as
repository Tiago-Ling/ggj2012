package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HowToState extends FlxState 
	{
		private var screen:FlxSprite;
		
		public function HowToState() 
		{
			
		}
		
		override public function create():void
		{
			screen = new FlxSprite(0, 0);
			screen.loadGraphic(GameData.howToPlay, false, false, 512, 768, false);
			add(screen);
			
			FlxG.playMusic(GameData.menuMusic, 0.5);
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justPressed("ESCAPE") ){
				FlxG.fade(0xFF000000, 1, goBackToMenu);
			}
		}
		
		private function goBackToMenu():void
		{
			FlxG.switchState( new MenuState() )
		}
		
	}

}