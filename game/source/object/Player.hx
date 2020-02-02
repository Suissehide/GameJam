package object;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite {
    public var name:String = "None";
    
    var _key:Array<Array<flixel.input.keyboard.FlxKey>> = [[RIGHT], [LEFT], [UP], [DOWN]];
	var _directionMove:Array<Bool> = [false, false, false, false];
	var _numberAnim:Float = 0;
    var _isMoving:Bool = false;
    var _isWinning:Bool = false;

	public function new(X:Float, Y:Float) {
		super(X, Y);

		maxVelocity.set(120, 300);
		acceleration.y = 100;
		drag.x = maxVelocity.x * 4;
	}

	public function getInput(level:Level):Void {
		_directionMove = [false, false, false, false];
		_isMoving = false;

		if (FlxG.keys.anyPressed(_key[0])) {        // go right
			facing = FlxObject.LEFT;
			_directionMove[0] = true;
			_isMoving = true;
		} else if (FlxG.keys.anyPressed(_key[1])) { // go left
			facing = FlxObject.RIGHT;
			_directionMove[1] = true;
			_isMoving = true;
		}
		if (FlxG.keys.anyPressed(_key[2])           // go up
			&& isTouching(FlxObject.FLOOR) && !isTouching(FlxObject.CEILING)) {
			_directionMove[2] = true;
		} else if (FlxG.keys.anyPressed(_key[3])) { // go down
			_directionMove[3] = true;
		}
	}

	override public function update(elapsed:Float):Void {
		if (_isMoving)
			animation.play("walk");
		else
			animation.play("idle");

		acceleration.x = 0;
		if (_directionMove[0])
			acceleration.x = maxVelocity.x * 4;
		if (_directionMove[1])
			acceleration.x = -maxVelocity.x * 4;
		if (_directionMove[2])
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
		alive = false;
	}
}
