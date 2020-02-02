package object;

class Box extends Object
{
    public var isTrigger:Bool = false;

    public function new(X:Int, Y:Int) {
        super(X, Y);

        loadGraphic("assets/images/box.png", true, 96, 96);

		animation.add("off", [0], 10, true);
        animation.add("on", [1], 10, true);

        height = height - 1;
		acceleration.y = 0;
		drag.x = 0;
    }
}