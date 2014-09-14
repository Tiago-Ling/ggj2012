package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.flixel.FlxBasic;
	import org.flixel.FlxText;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxScreenGrab;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class MenuState extends FlxState 
	{
		private var scoreText:FlxText;
		private var titleText:FlxText;
		private var playAgainText:FlxText;
		private var menuAnim:ANIMAENTRADA;
		
		public function MenuState() 
		{
			
		}
		
		override public function create():void
		{
			GameData.score += 0.01;
			var formatedScore:Number = Math.round(GameData.score * 100.0) / 100.0;
			
/*			titleText = new FlxText( 80, 50, 350, "" );
			titleText.size = 50;
			titleText.color = 0xAAFFFFFF;
			//titleText.flicker(10000)
			titleText.text = "BLICKZ !";
			add( titleText );
			
			scoreText = new FlxText( 20, 350, 350, "" );
			scoreText.size = 40;
			scoreText.color = 0xAAFFFFFF;
			scoreText.flicker(10000);
			scoreText.text = "PRESS:";
			add( scoreText );
			
			
			playAgainText = new FlxText( 20, 400, 350, "" );
			playAgainText.size = 30;
			playAgainText.color = 0xAAFFFFFF;
			playAgainText.text = "\n  SPACE to play\n  Z for credits\nX for how to";
			add( playAgainText );*/
			menuAnim = new ANIMAENTRADA();
			menuAnim.x = 256;
			menuAnim.y = 384;
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			FlxG.stage.addChild(menuAnim);
			FlxG.playMusic(GameData.menuMusic, 0.5);
		}
		
		override public function update():void
		{
			super.update();
			
			if ( FlxG.keys.justPressed("SPACE") ) {
				FlxG.fade(0xFF000000, 1, goToLv1);
			}
			
			if ( FlxG.keys.justPressed("Z") ) {
				FlxG.fade(0xFF000000, 1, goToAbout);
			}
			
			if (FlxG.keys.justPressed("X"))
			{
				FlxG.fade(0xFF000000, 1, goToHowTo);
			}
		}
		
		
		private function goToLv1():void
		{
			FlxG.switchState( new PreGameState() );
		}
		
		private function goToAbout():void
		{
			FlxG.switchState( new AboutState() );
		}
		
		private function goToHowTo():void
		{
			FlxG.switchState( new HowToState() );
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				//trace("çldadflakdlas");
				FlxG.stage.removeChild(menuAnim);
				goToLv1();
			}
			
			if (e.keyCode == Keyboard.Z)
			{
				//trace("çldadflakdlas");
				FlxG.stage.removeChild(menuAnim);
				goToAbout();
			}
			
			if (e.keyCode == Keyboard.X)
			{
				//trace("çldadflakdlas");
				FlxG.stage.removeChild(menuAnim);
				goToHowTo();
			}
		}
		
	}

}