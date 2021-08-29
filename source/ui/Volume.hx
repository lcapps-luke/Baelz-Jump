package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class Volume extends FlxSpriteGroup {
	private var icon:ToggleButton;
	private var track:FlxSprite;
	private var ball:FlxSprite;

	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(x, y);

		var iconSpr = new FlxSprite();
		iconSpr.loadGraphic(AssetPaths.volume__png, true, 80, 80);
		var iconScale = height / iconSpr.height;
		iconSpr.scale.set(iconScale, iconScale);
		iconSpr.updateHitbox();
		icon = new ToggleButton(iconSpr, onMuteToggle, false);

		add(icon);

		var trackSize = Math.round(height / 6);
		track = new FlxSprite();
		track.makeGraphic(Math.round(width - icon.width), Math.round(trackSize));
		track.updateHitbox();
		track.height = height;
		track.offset.y = -0.5 * (height - track.frameHeight);
		track.origin.set(0, track.frameHeight * 0.5);
		track.x = icon.width;
		track.y = height / 4;
		add(track);

		var ballSize = Math.round(height / 2);
		ball = new FlxSprite(icon.width, height / 2);
		ball.makeGraphic(ballSize, ballSize);
		ball.updateHitbox();
		add(ball);
	}

	private function onMuteToggle(mute:Bool) {
		FlxG.sound.muted = mute;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (InteractionUtils.isHeld()) {
			var p = InteractionUtils.clickPoint();
			if (track.getHitbox().containsPoint(p)) {
				var pos = Math.min(Math.max((p.x) - track.x, 0), track.width);
				var vol = pos / track.width;
				FlxG.sound.volume = vol;
				ball.x = pos + track.x - ball.width / 2;
			}
		}
	}

	public function setVolume(v:Float) {
		ball.x = track.width * v + track.x - ball.width / 2;
		FlxG.sound.volume = v;
	}
}
