package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;

import Constants;

class PlayState extends FlxState {

	var _players:FlxTypedGroup<object.Player>;
	var _objects:FlxGroup;

	var _gameCamera:FlxCamera;
	var _uiCamera:FlxCamera;

	// var _hud:Hud;
	var _fading:Bool;

	public var _map:Level;

	override public function create():Void {
		_players = new FlxTypedGroup<object.Player>();
		_objects = new FlxGroup();

		_map = new Level(_players, _objects, Constants.LEVEL_NAME[Constants.LEVEL]);
		// _hud = new Hud(_players, this);

		add(_map.mWalls);
		add(_map.mFloor);
        add(_players);
        add(_objects);
		// add(_hud);

        /* Cameras */
		/* Player camera */
		_gameCamera = new FlxCamera(0, 0, 1600, 700);
		_gameCamera.bgColor = 0xff191716;
        _gameCamera.setScrollBoundsRect(0, 0, _map.width, _map.height, true);
        _gameCamera.follow(getMecha(), PLATFORMER, 1);
        _gameCamera.zoom = 4;
		FlxG.cameras.reset(_gameCamera);
		FlxCamera.defaultCameras = [_gameCamera];

		/* HUD camera */
		// _uiCamera = new FlxCamera(0, 0, 1600, 900);
		// _uiCamera.bgColor = FlxColor.TRANSPARENT;
		// _uiCamera.follow(_drone);
		// _hud.cameras = [_uiCamera];
		// FlxG.cameras.add(_uiCamera);

		FlxG.cameras.flash(0xff131c1b, 0.85);
		_fading = false;

		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

        // Collisions with environment
        FlxG.collide(_objects, _map.mWalls);
        FlxG.collide(_players, _map.mWalls);
        FlxG.collide(_players, _objects);
        FlxG.collide(_players, _players);
    
        _players.forEach(function(player:object.Player) {
            player.getInput(_map);
            
            if (player.y > FlxG.height) {
                player.alive = false;
                FlxG.resetState();
            }
        });
    
        // Main menu
        #if FLX_KEYBOARD
        if (FlxG.keys.pressed.ESCAPE)
            FlxG.switchState(new menu.MenuState());
        #end
    }

    override public function destroy():Void {
        _players = null;
        _objects = null;
        _map = null;

        super.destroy();
    }

    function getMecha():object.Player {
        for (player in _players) {
            if (player.name == 'Mecha') {
                return player;
            }
        }
        return null;
    }
}
