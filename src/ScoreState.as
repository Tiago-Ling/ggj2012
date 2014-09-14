package  
{
	//NEW
	
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
	public class ScoreState extends FlxState 
	{
		private var scoreText:FlxText;
		private var titleText:FlxText;
		private var playAgainText:FlxText;
		
		private var screen:FlxSprite;
		
		//[Embed(source = "Assets/Baveuse3D.ttf", fontFamily = "system", embedAsCFF = "false")]
		[Embed(source="Assets/baveuse.ttf", fontFamily = "system", embedAsCFF = "false")]
		private var gameFont:String;
		
		public function ScoreState() 
		{
			
		}
		
		override public function create():void
		{
			GameData.score += 0.01
			var formatedScore:Number = Math.round(GameData.score * 100.0) / 100.0
			
			screen = new FlxSprite(0, 275);
			screen.loadGraphic(GameData.gameOver, false, false, 512, 350, false);
			add(screen);
			
			var logo:FlxSprite = new FlxSprite(42, 35);
			logo.loadGraphic(GameData.gameLogo, false, false, 428, 169, false);
			add(logo);
			//titleText = new FlxText( 0, 50, 512, "", true);
			//titleText.text = "BLICKZ !";
			//titleText.setFormat(gameFont, 75, 0xffffffff, "center");
			//titleText.size = 50;
			//titleText.color = 0xAAFFFFFF;
			//titleText.flicker(10000);
			//add( titleText );
			
			scoreText = new FlxText( 0, 220, 512, "", true);
			//scoreText.size = 40;
			//scoreText.color = 0xAAFFFFFF;
			scoreText.text = "You ran: " + formatedScore.toString() + " litz!";
			scoreText.setFormat(null, 35, 0xffffff, "center");
			//scoreText.flicker(-1);
			add( scoreText );
			
			
			playAgainText = new FlxText( 0, 650, 512, "", true);
			//playAgainText.size = 15;
			//playAgainText.color = 0xAAFFFFFF;
			playAgainText.text = "Press SPACE to play again!\nPress ESC for Menu";
			playAgainText.setFormat(null, 15, 0xffffff, "center");
			add( playAgainText );
			
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justPressed("SPACE") ) {
				FlxG.fade(0xFF000000, 1, goBackToLv1);
			}
			if ( FlxG.keys.justPressed("ESCAPE") ) {
				FlxG.fade(0xFF000000, 1, goBackToMenu);
			}
		}
		
		
		private function goBackToLv1():void
		{
			FlxG.switchState( new GameState() )
		}
		
		private function goBackToMenu():void
		{
			FlxG.switchState( new MenuState() )
		}
		
	}

}