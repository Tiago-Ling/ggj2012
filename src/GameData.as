package  
{
	import flash.display.MovieClip;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author ...
	 */
	public class GameData
	{
		
		public function GameData() 
		{
		}
		
		[Embed(source="Assets/char02_sheet.png")]
		public static var player2NoCrystal:Class;
		
		[Embed(source = "Assets/char01_sheet.png")]
		public static var player1Sheet:Class;
		
		//[Embed(source="Assets/background-test.png")]
		[Embed(source="Assets/background-test01.png")]
		public static var background:Class;
		
		[Embed(source = "Assets/Spreadsheet_background.PNG")]
		public static var decor:Class;
		
		[Embed(source = "Assets/enemy.png")]
		public static var enemySprite:Class;
		
		[Embed(source = "Assets/Crystals.png")]
		public static var crystalSprite:Class;
		
		[Embed(source = "Assets/bullet.png")]
		public static var bulletSprite:Class;
		
		[Embed(source="Assets/mastigacao.mp3")]
		public static var chewingSound:Class;
		
		[Embed(source = "Assets/block_chao.mp3")]
		public static var blockPlacing:Class;
		
		[Embed(source="Assets/tiro_laser.mp3")]
		public static var shotSnd:Class;
		
		[Embed(source="Assets/music_Blickz.mp3")]
		public static var gameMusic:Class;
		
		[Embed(source = "Assets/swarmdeath.mp3")]
		public static var swarmDeath:Class;
		
		[Embed(source = "Assets/GAME_OVER.png")]
		public static var gameOver:Class;
		
/*		[Embed(source = "Assets/Baveuse3D.ttf", fontFamily = "system", embedAsCFF = "false")]
		public static var gameFont:String;*/
		
		[Embed(source = "Assets/explosion.png")]
		public static var explosionSprite:Class;
		
		[Embed(source = "Assets/crystal_crack.mp3")]
		public static var crystalCracking:Class;
		
		[Embed(source = "Assets/platform.png")]
		public static var platformSprite:Class;
		
		[Embed(source = "Assets/logo.png")]
		public static var gameLogo:Class;
		
		[Embed(source = "Assets/Musica_Menu_Blickz.mp3")]
		public static var menuMusic:Class;
		
		[Embed(source = "Assets/play-credits_0001.png")]
		public static var howToPlay:Class;
		
		[Embed(source = "Assets/play-credits_0002.png")]
		public static var credits:Class;
		
		[Embed(source = "Assets/help.png")]
		public static var helpScreens:Class;
		
		public static var score:Number;
		
	}

}