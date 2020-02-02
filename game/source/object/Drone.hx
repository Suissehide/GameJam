package object;

import flixel.FlxObject;

class Drone extends Player
{
	public function new(X:Float, Y:Float) {
		super(X, Y);

		loadGraphic("assets/images/drone.png", true, 60, 45);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		animation.add("idle", [0], 10, true);
        animation.add("walk", [0], 10, true);
    
        scale.set(0.5, 0.5);
        updateHitbox();
    
        name = "Drone";
        _key = [[L], [J], [I], [K]];
    }
}