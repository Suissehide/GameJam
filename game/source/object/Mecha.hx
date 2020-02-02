package object;

import flixel.FlxObject;

class Mecha extends Player
{
	public function new(X:Float, Y:Float) {
		super(X, Y);

		loadGraphic("assets/images/test-mecha.png", true, 70, 100);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		animation.add("idle", [0, 1, 2, 3], 10, true);
        animation.add("walk", [10, 11, 12, 13, 14, 15, 16, 17], 10, true);
        
        scale.set(0.5, 0.5);
        updateHitbox();

        name = "Mecha";
        _key = [[D], [Q], [Z], [S]];
	}
}