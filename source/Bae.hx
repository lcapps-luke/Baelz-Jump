package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;

class Bae extends FlxSprite {
	private static inline var ANIM_RUN:String = "run";
	private static inline var ANIM_JUMP:String = "jump";
	private static inline var ANIM_FPS:Int = 20;

	private var jumpAction:FlxActionDigital;

	public function new(x:Float, y:Float) {
		super(x, y);
		loadGraphic(AssetPaths.bae__png, true, 208, 512);
		animation.add(ANIM_RUN, [for (i in 0...9) i], ANIM_FPS, true);
		animation.add(ANIM_JUMP, [for (i in 11...23) i], ANIM_FPS, false);

		animation.finishCallback = onAnimationFinish;

		var jumpAction = new FlxActionDigital("jump", onJump);
		jumpAction.addKey(ANY, JUST_PRESSED);
		jumpAction.addMouse(LEFT, JUST_PRESSED);
		jumpAction.addGamepad(ANY, JUST_PRESSED);

		FlxG.inputs.add(new FlxActionManager()).addAction(jumpAction);

		animation.play(ANIM_RUN, true);
	}

	private function onAnimationFinish(anim:String) {
		if (anim == ANIM_JUMP) {
			animation.play(ANIM_RUN, true);
		}
	}

	private function onJump(action:FlxActionDigital) {
		if (animation.name == null || animation.name == ANIM_RUN) {
			animation.play(ANIM_JUMP, true);
		}
	}

	public function canHit():Bool {
		return animation.name == null
			|| animation.name == ANIM_RUN
			|| (animation.name == ANIM_JUMP && !(animation.frameIndex > 12 && animation.frameIndex < 22));
	}
}
