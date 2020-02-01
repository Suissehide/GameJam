package object;

import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;

class Box extends FlxSprite
{
    override public function new(X:Int, Y:Int) {
        super(X, Y);

        loadGraphic("assets/images/box.png", true, 32, 32);
        height = height - 1;
		acceleration.y = 400;
		drag.x = 200;
    }
}