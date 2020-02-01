package object;

import flixel.FlxObject;

class Drone extends Player
{
	public function new(X:Float, Y:Float) {
		super(X, Y);

		loadGraphic("assets/images/drone.png", true, 60, 45);
		setFacingFlip(FlxObject.LEFT, false, true);
		setFacingFlip(FlxObject.RIGHT, true, true);

		animation.add("idle", [0], 10, true);
        animation.add("walk", [0], 10, true);
    
        scale.set(0.5, 0.5);
        updateHitbox();
    }
}