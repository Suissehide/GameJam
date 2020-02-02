package object;

class Box extends Object
{
    public function new(X:Int, Y:Int) {
        super(X, Y);

        loadGraphic("assets/images/box.png", true, 96, 96);
        height = height - 1;
		acceleration.y = 400;
        drag.x = 400;
        
        scale.set(0.25, 0.25);
        updateHitbox();
    }
}