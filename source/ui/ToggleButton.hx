package ui;

import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class ToggleButton extends Button {
	public var checked(default, set):Bool;

	private var toggleCallback:Bool->Void;

	public function new(spr:FlxSprite, toggleCallback:Bool->Void, border:Bool = true) {
		super(spr, toggle, border);

		this.toggleCallback = toggleCallback;
	}

	public function toggle() {
		checked = !checked;
		toggleCallback(checked);
	}

	private function set_checked(v:Bool):Bool {
		spr.animation.frameIndex = v ? 1 : 0;
		return checked = v;
	}
}
