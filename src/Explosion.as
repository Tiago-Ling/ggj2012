package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Explosion extends FlxSprite 
	{
		
		public function Explosion(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			init();
		}
		
		private function init():void
		{
			loadGraphic(GameData.explosionSprite, true, false, 128, 128, false);
			addAnimation("Explosion", [0, 1, 2, 3, 4, 5, 6, 7], 16, false);
			addAnimationCallback(onAnimationEnd);
			kill();
		}
		
		private function onAnimationEnd(name:String, fNumber:uint, fIndex:uint):void
		{
			if (fIndex == 7)
			{
				visible = false;
				//kill();
			}
		}
		
	}

}