package  
{
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxMath;
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class SlotManager 
	{
		public static var slots:Array;
		
		public function SlotManager() 
		{
			
		}
		
		public static function init():void
		{
			slots = new Array();
			for (var i:int = 0; i < 8; ++i)
			{
				slots[i] = new Array();
				for (var j:int = 0; j < 12; ++j)
				{
					slots[i][j] = false;
				}
			}
		}
		
		public static function getFreeSlot():FlxPoint
		{
			var posX:int = FlxMath.rand(1, 6);
			var posY:int = FlxMath.rand(0, 12);
			
			if (slots[posX][posY] == true)
			{
				return getFreeSlot();
			}
			else
			{
				slots[posX][posY] = true;
				return new FlxPoint(posX * 64, posY * 64);
			}
		}
		
		public static function getFreeYSlot(currentColumn:int):Number
		{
			var posY:int = FlxMath.rand(0, 12);
			
			if (slots[currentColumn][posY] == true)
			{
				return getFreeYSlot(currentColumn);
			}
			else
			{
				return posY * 64;
			}
		}
		
		public static function getFreeXSlot(currentRow:int):Number
		{
			var posX:int = FlxMath.rand(1, 6);
			
			if (slots[posX][currentRow] == true)
			{
				return getFreeXSlot(currentRow);
			}
			else
			{
				return posX * 64;
			}
		}
		
		public static function releaseSlot(x:Number, y:Number):void
		{
			var xPos:int = x / 64;
			var yPos:int = y / 64;
			
			slots[xPos][yPos] = false;
		}
		
	}

}