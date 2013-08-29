package ;

import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.util.FlxAngle;
import org.flixel.util.FlxPoint;

/**
 * ...
 * @author Adam Harte (adam@adamharte.com)
 */
class EnemyBullet extends FlxSprite
{
	public var speed:Float;
	
	
	public function new() 
	{
		super();
		
		speed = 200;
		
		loadGraphic('assets/bullet.png', true);
		width = 4;
		height = 4;
		offset.x = 6;
		offset.y = 6;
		
		addAnimation('up', [0]);
		addAnimation('down', [1]);
		addAnimation('left', [2]);
		addAnimation('right', [3]);
		addAnimation('hit', [4, 5, 6], 12, false);
	}
	
	override public function update():Void
	{
		if (!alive) 
		{
			if (finished) 
			{
				exists = false;
			}
		}
		else if (touching != 0) 
		{
			kill();
		}
		
		super.update();
	}
	
	override public function kill():Void
	{
		if(!alive)
		{
			return;
		}
		
		velocity.x = 0;
		velocity.y = 0;
		
		alive = false;
		solid = false;
		
		play('hit');
		
		//super.kill();
	}
	
	public function shoot(location:FlxPoint, direction:Int):Void
	{
		super.reset(location.x - width / 2, location.y - height / 2);
		solid = true;
		switch (direction) 
		{
			case FlxObject.UP:
				play('up');
				velocity.y = -speed;
			case FlxObject.DOWN:
				play('down');
				velocity.y = speed;
			case FlxObject.LEFT:
				play('left');
				velocity.x = -speed;
			case FlxObject.RIGHT:
				play('right');
				velocity.x = speed;
		}
	}
	
	public function shootPrecise(location:FlxPoint, rotationAngle:Float):Void
	{
		super.reset(location.x - width / 2, location.y - height / 2);
		solid = true;
		play('left');
		angle = FlxAngle.asDegrees(rotationAngle);
		velocity.x = Math.cos(rotationAngle) * speed;
		velocity.y = Math.sin(rotationAngle) * speed;
	}
	
}