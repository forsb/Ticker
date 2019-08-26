using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class TickerRaceTimer {

    /* -- Attributes -- */
    var myStartTime;
    var myDuration;
    var myPauseTime;

    var myIsPaused;
    var myIsStopped;

    /* -- Constructor -- */
    function initialize() {
        myDuration = 0;
        myIsPaused = true;
        myIsStopped = true;
    }

    /* -- Global methods -- */
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
        myIsStopped = false;

        myStartTime = new Time.Moment(Time.now().value()).add(new Time.Duration(myDuration));
    }

    function reset() {
        myDuration = 0;
        myIsStopped = true;
    }

    function reload() {
        myDuration = 5 * Gregorian.SECONDS_PER_MINUTE;
    }

    function increment(minutes) {
        myDuration += minutes * Gregorian.SECONDS_PER_MINUTE;
        if (myDuration < 0) {
            myDuration = 0;
        }
    }

    function syncUp() {
        // Feature disabled
    }

    function syncDown() {
        var duration = getDuration();

        if (duration > 0) {
            var seconds = duration % Gregorian.SECONDS_PER_MINUTE;
            myStartTime = new Time.Moment(myStartTime.value()).subtract(new Time.Duration(seconds));
        }
    }

    function getDuration() {
        return myIsPaused ? myDuration : myStartTime.compare(Time.now());
    }

    function getSeconds() {
        return getDuration().abs() % Gregorian.SECONDS_PER_MINUTE;
    }

    function getMinutes() {
        return Math.floor(getDuration().abs() / Gregorian.SECONDS_PER_MINUTE);
    }

    function isPaused() {
        return myIsPaused;
    }

    function isCountingDown() {
        return getDuration() >= 0;
    }

}
