package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;

class PlayState extends FlxState
{
    var _drone:object.Drone;

    var _players:FlxGroup;
    var _objects:FlxGroup;

    var _gameCamera:FlxCamera;
    var _uiCamera:FlxCamera;

    // var _hud:Hud;
	var _fading:Bool;

    public var _map:Level;

	override public function create():Void
	{
        _drone = new object.Drone(0, 0);

        _map = new Level(_drone);
        // _hud = new Hud(_player, this);

		add(_map._mWalls);
        add(_map._mFloor);
        add(_drone);
        // add(_hud);
        
        _players = new FlxGroup();
		_players.add(_drone);
        
        /* Cameras */
        _gameCamera = new FlxCamera(0, 0, 1600, 900);
        _uiCamera = new FlxCamera(0, 0, 1600, 900);

        _gameCamera.bgColor = 0xff191716;
        _uiCamera.bgColor = FlxColor.TRANSPARENT;

        _gameCamera.follow(_drone);
        _gameCamera.zoom = 4;

        FlxG.cameras.reset(_gameCamera);
        // FlxG.cameras.add(_uiCamera);
        FlxCamera.defaultCameras = [_gameCamera];
        
		// _uiCamera.follow(_drone);
        // _hud.cameras = [_uiCamera];

        FlxG.cameras.flash(0xff131c1b, 0.65);
		_fading = false;

		super.create();
	}

	override public function update(elapsed:Float):Void
	{   
        super.update(elapsed);

        // Collisions with environment
        FlxG.collide(_players, _map._mWalls);
        
        _drone.getInput(_map);

		if (_drone.y > FlxG.height){
            _drone._alive = false;
            FlxG.resetState();
        }

        // Main menu
		#if FLX_KEYBOARD
		if (FlxG.keys.pressed.ESCAPE)
			FlxG.switchState(new menu.MenuState());
		#end
    }
    

    override public function destroy():Void {

		_drone = null;
		_objects = null;

		_map = null;

		super.destroy();
	}
}
