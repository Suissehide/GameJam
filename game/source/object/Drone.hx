package object;

import flixel.FlxObject;

class Drone extends Player
{
	public function new(X:Float, Y:Float) {
		super(X, Y);

		loadGraphic("assets/images/player.png", true, 8, 8);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		animation.add("idle", [0], 10, true);
        animation.add("walk", [0, 1], 10, true);
        
        // makeGraphic(8, 8, FlxColor.RED);
	}
}