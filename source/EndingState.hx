package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author bbpanzu
 */
class EndingState extends FlxState
{

    override public function create():Void 
    {
        super.create();
        var end:FlxSprite = new FlxSprite(0, 0);
		end.loadGraphic(Paths.image("ThanksU"));
        add(end);
        new FlxTimer().start(8, endIt);

    }

    override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);

        if (FlxG.keys.pressed.ENTER){
            endIt();
        }

    }


    public function endIt(e:FlxTimer=null){
        trace("ENDING");
        FlxG.switchState(new StoryMenuState());
    }

}