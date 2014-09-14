package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxGame;
	import ANIMAENTRADA;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class Main extends Sprite 
	{
		private var game:FlxGame;
		private var anim:ANIMAENTRADA;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			//stage.align = StageAlign.TOP_LEFT;
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.displayState = StageDisplayState.NORMAL;
			//stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullscreen);
			
			trace("is fullscreen allowed? -> " + stage.allowsFullScreen);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			game = new FlxGame(512, 768, MenuState, 1, 30, 30, false);
			//game.forceDebugger = true;
			addChild(game);
		}
		
		
		 
/*		function fullscreen(e:FullScreenEvent):void {
			if(e.fullScreen) stage.displayState = StageDisplayState.NORMAL;
		}*/
		
	}
	
}