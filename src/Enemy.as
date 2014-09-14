package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author ...
	 */
	public class Enemy extends FlxSprite 
	{
		private var parent:GameState;
		private var enemyType:int;
		
		public function Enemy(X:Number=0, Y:Number=0, SimpleGraphic:Class=null, par:GameState = null, type:int = 0) 
		{
			super(X, Y, SimpleGraphic);
			parent = par;
			enemyType = type;
			init();
		}
		
		private function init():void
		{
			loadGraphic(GameData.enemySprite, true, false, 64, 75, false);
			
			switch (enemyType)
			{
				case 0:
					addAnimation("Walk", [0, 1, 2, 3, 4, 5, 6], 24, true);
					break;
					
				case 1:
					addAnimation("Walk", [7, 8, 9, 10, 11, 12, 13], 24, true);
					break;
					
				case 2:
					addAnimation("Walk", [14, 15, 16, 17, 18, 19, 20], 24, true);
					break;
			}
			
			play("Walk");
			
			//velocity.y = -40;
			kill();
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.y <= 397)
			{
				parent.resetGame();
			}
		}
		
	}

}