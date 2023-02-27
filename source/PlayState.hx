package;

import credits.CreditsState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import ui.TextButton;
import ui.Volume;

class PlayState extends FlxState {
	private static inline var START_SPEED:Float = 1024;
	private static inline var MAX_SPEED:Float = 5000;
	private static inline var LEVEL_TIME:Float = 10;
	private static inline var LEVELS:Int = 30;
	private static inline var SPEED_INCREMENT:Float = (MAX_SPEED - START_SPEED) / LEVELS;

	private var bae:Bae;
	private var blockGroup:FlxTypedGroup<Block>;
	private var bar:Bar;

	private var level:Int = 0;
	private var levelRemainder:Float = LEVEL_TIME;
	private var gameSpeed:Float = START_SPEED;
	private var timer:FlxTimer;
	private var collider:FlxSprite;

	private var currentScore:ScoreText;
	private var bestScore:ScoreText;
	private var featureText:FeatureText;

	override public function create() {
		super.create();
		bae = new Bae(818, 29);
		add(bae);

		blockGroup = new FlxTypedGroup<Block>();
		add(blockGroup);

		collider = new FlxSprite(941, 410);
		collider.makeGraphic(48, 128, FlxColor.TRANSPARENT);
		add(collider);

		bar = new Bar(742, 646);
		bar.progress = 0;
		add(bar);

		timer = new FlxTimer();
		timer.start(3, onTimerComplete, 0);

		currentScore = new ScoreText(20, 20, "CURRENT_SPEED");
		add(currentScore);
		bestScore = new ScoreText(0, 20, "BEST_SPEED");
		bestScore.x = 1900 - bestScore.width;
		add(bestScore);

		featureText = new FeatureText(440, 850);
		add(featureText);

		var creds = new TextButton("CREDITS", 40, showCredits);
		creds.x = 20;
		creds.y = 970;
		add(creds);

		var volume = new Volume(40 + creds.width, 955, 960 - 40 - creds.width, creds.height);
		add(volume);
		volume.setVolume(0.5);

		FlxG.sound.playMusic(AssetPaths.bgm__ogg, 0.5);
	}

	private function reset() {
		level = 0;
		levelRemainder = LEVEL_TIME;
		gameSpeed = START_SPEED;
		currentScore.value = 0;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.overlap(collider, blockGroup, onCollide, (a, b) -> bae.canHit());

		levelRemainder -= elapsed;
		if (levelRemainder <= 0) {
			level++;
			levelRemainder = LEVEL_TIME;
			gameSpeed += SPEED_INCREMENT;

			currentScore.value = level;
			if (bestScore.value < level) {
				bestScore.value = level;
				bestScore.x = 1900 - bestScore.width;
			}

			updateFeatureText();
		}

		bar.progress = 1 - levelRemainder / LEVEL_TIME;
	}

	private function spawnBlock() {
		var block = blockGroup.recycle(Block, () -> new Block());
		block.set(gameSpeed);
	}

	private function onTimerComplete(timer:FlxTimer) {
		var minTime = gameSpeed / 1920;
		timer.time = minTime + FlxG.random.float(minTime, 3);

		spawnBlock();
	}

	private function onCollide(a:FlxObject, b:FlxObject) {
		FlxFlicker.flicker(bae);
		reset();
	}

	private inline function updateFeatureText() {
		var set = Math.floor(level / 10);
		if (featureText.set != set && set < 3) {
			featureText.set = set;
		}
	}

	private function showCredits() {
		this.openSubState(new CreditsState());
	}
}
