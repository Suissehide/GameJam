package object;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite {
	var SPEED:Float = 1;

	public var _isMoving:Bool = false;
	public var _alive:Bool = true;

	var direction_move:Array<Bool> = [false, false, false, false];
	var number_anim:Float = 0;

	public function new(X:Float, Y:Float) {
		super(X, Y);

		maxVelocity.set(120, 300);
		acceleration.y = 300;
		drag.x = maxVelocity.x * 4;
	}

	public function getInput(level:Level):Void {
        direction_move = [false, false, false, false];
        _isMoving = false;

		if (FlxG.keys.anyPressed([RIGHT, D])) { // go right
			facing = FlxObject.LEFT;
            direction_move[0] = true;
            _isMoving = true;
        } else if (FlxG.keys.anyPressed([LEFT, Q])) { // go left
			facing = FlxObject.RIGHT;
            direction_move[1] = true;
            _isMoving = true;
        }
        if (FlxG.keys.anyPressed([UP, Z]) // go up
			&& isTouching(FlxObject.FLOOR)) {
			direction_move[2] = true;
        } else if (FlxG.keys.anyPressed([DOWN, S])) { // go down
			direction_move[3] = true;
		}
	}

	override public function update(elapsed:Float):Void {
		if (_isMoving)
			animation.play("walk");
		else
			animation.play("idle");

		acceleration.x = 0;
		if (direction_move[0])
			acceleration.x = maxVelocity.x * 4;
		if (direction_move[1])
			acceleration.x = -maxVelocity.x * 4;
		if (direction_move[2])
			velocity.y = -maxVelocity.y / 2;

    	super.update(elapsed);
}

override public function kill():Void {
	if (!alive)
		return;

	super.kill();
	FlxSpriteUtil.flicker(this, 1, 0.04, true);

	FlxG.camera.shake(0.007, 0.25);
	FlxG.camera.flash(0xffd8eba2, 0.65, turnOffSlowMo);
	FlxG.timeScale = 0.35;
}

function turnOffSlowMo():Void {
	FlxG.timeScale = 1.0;
	_alive = false;
}
}
