using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class TickerRaceTimer {

    var myStartTime;
    var myDuration;
    var myPauseTime;

    var myIsPaused;

    function initialize() {
        myDuration = 0;
        myIsPaused = true;
    }

    function togglePause() {
        if (myIsPaused) {
            resume();
        } else {
            pause();
        }
    }

    function pause() {
        myIsPaused = true;

        myPauseTime = Time.now();
        myDuration =  myStartTime.value() - myPauseTime.value();
    }

    function resume() {
        myIsPaused = false;

        myStartTime = new Time.Moment(Time.now().value()).add(new Time.Duration(myDuration));
    }

    function reset() {
        myDuration = 0;
    }

    function reload() {
        myDuration = 5 * Gregorian.SECONDS_PER_MINUTE;
    }

    function syncUp() {
        // Feature disabled
    }

    function syncDown() {
        var now = Time.now();
        var duration = myStartTime.compare(now);

        if (duration > 0) {
            var seconds = duration % Gregorian.SECONDS_PER_MINUTE;
            myStartTime = new Time.Moment(myStartTime.value()).subtract(new Time.Duration(seconds));
        }
    }

    function toString() {
        var duration = myIsPaused ? myDuration.abs() : myStartTime.compare(Time.now()).abs();

        var seconds = duration % Gregorian.SECONDS_PER_MINUTE;
        var minutes = (duration - seconds) / Gregorian.SECONDS_PER_MINUTE;

        return Lang.format(
                "$1$:$2$",
                [minutes.format("%.2d"), seconds.format("%.2d")]
        );
    }

}
