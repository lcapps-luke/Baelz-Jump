package;

import flixel.FlxG;
import flixel.FlxSprite;

class Block extends FlxSprite {
	public function new() {
		super(0, 440, AssetPaths.block__png);
	}

	override function revive() {
		super.revive();
		x = FlxG.width;
	}

	public function set(speed:Float) {
		x = FlxG.width;
		velocity.set(-speed);
	}
}
