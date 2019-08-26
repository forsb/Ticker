using Toybox.Attention;

class TickerFeedback {

    /* -- Attributes -- */
    const myLongVibe = [new Attention.VibeProfile(100, 2000)];
    const myShortVibe = [new Attention.VibeProfile(100, 500)];
 
    const myBigTone = Attention.TONE_TIME_ALERT;
    const mySmallTone = Attention.TONE_LOUD_BEEP;

    /* -- Constructor -- */
    function initialize() {
    }

    /* -- Global methods -- */
    function poke(minutes, seconds) {
        if (minutes == 0 && seconds == 0) {
            // Start!
            sound(myBigTone);
            vibrate(myLongVibe);
        } else if (minutes == 0 && seconds <= 15) {
            // Last 15 seconds
            sound(mySmallTone);
            vibrate(myShortVibe);
        } else if (minutes == 0 && seconds % 10 == 0) {
            // Every 10 sec the last minute
            sound(mySmallTone);
            vibrate(myShortVibe);
        } else if (seconds == 0) {
            // Every minute
            sound(mySmallTone);
            vibrate(myShortVibe);
        }
    }

    /* -- Local methods -- */
    function vibrate(vibe) {
        if (Attention has :vibrate) {
            Attention.vibrate(vibe);
        }
    }

    function sound(tone) {
        if (Attention has :playTone) {
            Attention.playTone(tone);
        }
    }

}
