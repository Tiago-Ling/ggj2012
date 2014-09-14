package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Tiago Ling Alexandre
	 */
	public class GameState extends FlxState 
	{
		private var p1:Player1;
		private var p2:Player2;
		private var back:Background;
		
		private var resourceGroup:FlxGroup;
		private var ammoGroup:FlxGroup;
		private var enemyGroup:FlxGroup;
		private var decoGroup:FlxGroup;
		private var delay:FlxDelay;
		private var scoreText:FlxText;
		private var explosionGroup:FlxGroup;
		private var platform:FlxSprite;
		
		public function GameState() 
		{
			
		}
		
		override public function create():void
		{
			SlotManager.init();
			FlxG.playMusic(GameData.gameMusic, 1.0);
			
			back = new Background(this);
			
			ammoGroup = new FlxGroup(50);
			for (var i:int = 0; i < 50; ++i)
			{
				ammoGroup.add(new Dart(-100, -100));
			}
			add(ammoGroup);
			
			resourceGroup = new FlxGroup(10);
			for (i = 1; i < 9; ++i)
			{	
				var yMultiplier:int = FlxMath.rand(0, 7);
				var randInt:int = FlxMath.rand(0, 3);
				FlxG.log("resource type: " + randInt);
				var tempResource:Resource = new Resource(i * 64, -(yMultiplier * 96), null, randInt);
				resourceGroup.add(tempResource);
			}
			add(resourceGroup);
			
			enemyGroup = new FlxGroup(32);
			for (i = 0; i < 32; ++i)
			{
				randInt = FlxMath.rand(0, 2);
				var tempEnemy:Enemy = new Enemy(0, 768, null, this, randInt);
				enemyGroup.add(tempEnemy);
			}
			add(enemyGroup);
			
			decoGroup = new FlxGroup(10);
			for (i = 0; i < 10; ++i)
			{
				yMultiplier = FlxMath.rand(0, 11);
				randInt = FlxMath.rand(0, 19);
				
				if (randInt < 10)
				{
					var posY:Number = SlotManager.getFreeYSlot(0);
					decoGroup.add(new Decoration(0, posY));
				}
				else
				{
					posY = SlotManager.getFreeYSlot(448 / 64);
					decoGroup.add(new Decoration(448,posY));
				}
			}
			add(decoGroup);
			
			GameData.score = 0;
			scoreText = new FlxText(5, 10, 300, "" );
			scoreText.size = 20;
			scoreText.color = 0xFFFFFF;
			scoreText.alpha = 0.75;
			add( scoreText )
			
			delay = new FlxDelay(5000);
			delay.callback = onTimer;
			delay.start();
			
			platform = new FlxSprite(86, 290);
			platform.loadGraphic(GameData.platformSprite, true, false, 340, 165, false);
			platform.addAnimation("Idle", [0, 1, 2, 3], 16, true);
			platform.play("Idle");
			add(platform);
			
			p1 = new Player1(196, 240, null, this, ammoGroup);
			add(p1);
			
			p2 = new Player2(196, 322, null, this);
			add(p2);
			
			FlxG.mouse.show();
			
			explosionGroup = new FlxGroup(50);
			for (i = 0; i < 50; ++i)
			{
				//var tempExplosion: = new Explosion( -128, -128);
				explosionGroup.add(new Explosion(-128, -128));
			}
			add(explosionGroup);
		}
		
		override public function update():void
		{
			super.update();
			back.update();
			
			GameData.score += 0.02;
			var formatedScore:Number = Math.round(GameData.score * 100.0) / 100.0;
			GameData.score = formatedScore;
			scoreText.text = "Dist.: " + formatedScore.toString() + " Litz"; 
			
			FlxG.overlap(ammoGroup, resourceGroup, handleBulletCollision);
			FlxG.overlap(p2, resourceGroup, handleP2Collision);
			FlxG.overlap(resourceGroup, enemyGroup, handleEnemyCollision);
		}
		
		// Handles colision between P1's 'dart' and 'natural' Recources
		private function handleBulletCollision(Object1:FlxObject, Object2:FlxObject):void
		{
			var res:Resource = Object2 as Resource;
			if (res.currentBehavior == 0)
			{
				Object1.kill();
				FlxG.play(GameData.crystalCracking, 1.0, false, true);
				
				//if (res.getBehavior() == 0)
				//{
					res.flicker(0.3);
					res.setBehavior(1);
				//}
			}
		}
		
		// P2 collides on Resource processed by P1
		private function handleP2Collision(Object1:FlxObject, Object2:FlxObject):void
		{
			//TODO: Put p2 collisions here
			
			var res:Resource = Object2 as Resource;
			SlotManager.releaseSlot(res.x, res.y);
			var player:Player2 = Object1 as Player2;
			if (res.getBehavior() == 1 && player.getAttachedResource() == null && player.getAnimationName() != "WalkCrystal")
			{
				FlxG.play(GameData.chewingSound, 1.0, false, true);
				res.setTarget(Object1);
				res.visible = false;
				player.setResource(res);
			}
		}
		
		// A Resource fabricated by P2 hits Enemy! :)
		private function handleEnemyCollision(Object1:FlxObject, Object2:FlxObject):void
		{
			var res:Resource = Object1 as Resource;
			var enemy:Enemy = Object2 as Enemy;
			
			SlotManager.releaseSlot(enemy.x, enemy.y);
			
			if (res.getBehavior() == 2)
			{
/*				var tempBasic:FlxBasic = explosionGroup.getFirstDead();
				var tempExplosion:Explosion = tempBasic as Explosion;*/
				//dart = darts.recycle(Dart) as Dart;
				var explo:Explosion;
				explo = explosionGroup.recycle(Explosion) as Explosion;
				if (explo != null)
				{
					FlxG.log("Should be exploding!");
					explo.revive();
					explo.visible = true;
					explo.x = enemy.x - 32;
					explo.y = res.y;
					explo.play("Explosion");
				}
				FlxG.play(GameData.swarmDeath, 1.0, false, true);
				res.setBehavior(0);
				//res.cancelTimer();
				enemy.kill();
				enemy.velocity.y = 0;
				enemy.x = -64;
				enemy.y = 832;
			}
		}
		
		private function onTimer():void
		{
			var tempBasic:FlxBasic = enemyGroup.getFirstDead();
			var tempEnemy:Enemy = tempBasic as Enemy;
			
			if (tempEnemy != null)
			{
				tempEnemy.revive();
				tempEnemy.x = SlotManager.getFreeXSlot(tempEnemy.y / 64);
				tempEnemy.y = 704 + FlxMath.rand(1, 3) * 32;
				
				if (GameData.score < 25000)
				{
					FlxG.log("RAISING SCORE!!!");
					tempEnemy.velocity.y = -12;
					delay.reset(4000);
					delay.start();
				}
				else if (GameData.score < 50000)
				{
					tempEnemy.velocity.y = -15;
					delay.reset(3500);
					delay.start();
				}
				else if (GameData.score < 75000)
				{
					tempEnemy.velocity.y = -20;
					delay.reset(3000);
					delay.start();
				}
				else if (GameData.score < 100000)
				{
					tempEnemy.velocity.y = -30;
					delay.reset(2500);
					delay.start();
				}
				else if (GameData.score < 125000)
				{
					tempEnemy.velocity.y = -45;
					delay.reset(2500);
					delay.start();
				}
				else if (GameData.score < 150000)
				{
					tempEnemy.velocity.y = -60;
					delay.reset(2500);
					delay.start();
				}
				else if (GameData.score < 175000)
				{
					tempEnemy.velocity.y = -75;
					delay.reset(2500);
					delay.start();
				}
			}
			else
			{
				//FlxG.log("tempEnemy is null!");
			}
			
/*			if (GameData.score < 25000)
			{
				delay.reset(4000);
				delay.start();
			}
			else if (GameData.score < 50000)
			{
				delay.reset(3500);
				delay.start();
			}
			else if (GameData.score < 75000)
			{
				delay.reset(3000);
				delay.start();
			}
			else
			{
				delay.reset(2500);
				delay.start();
			}*/
		}
		
		// aka GameOver! :(
		public function resetGame():void
		{
			delay.abort();
			
			for (var i:int = 0; i < resourceGroup.length; ++i)
			{
				var tempRes:Resource = resourceGroup.members[i] as Resource;
				tempRes.setBehavior(0);
				//tempRes.cancelTimer();
			}
			
			//FlxG.fade(0xFF000000, 1.5, FlxG.switchState, false);
			
			FlxG.fade(0xFF000000, 1, function():void
			{
				FlxG.switchState( new ScoreState() )
			}, false);
		}
		
	}

}