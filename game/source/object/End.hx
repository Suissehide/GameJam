package object;

class Box extends Object
{
    public function new(X:Int, Y:Int) {
        super(X, Y);

        loadGraphic("assets/images/box.png", true, 96, 96);

        height = height - 1;
		acceleration.y = 0;
		drag.x = 0;
    }
}