using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class TickerDelegate extends Ui.BehaviorDelegate {

    var myView;

    var myRaceTimer;
    var myTimer;

    function initialize(view) {
        BehaviorDelegate.initialize();

        myView = view;
        myRaceTimer = new TickerRaceTimer();
        myTimer = new Timer.Timer();

        myTimer.start(method(:timerCallback), 1000, true);
    }

    function onMenu() {
        return true;
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_RIGHT);
        return true;
    }

    function onSelect() {
        myRaceTimer.togglePause();
        return true;
    }

    function onPreviousPage() {
        if (myRaceTimer.myIsPaused) {
            myRaceTimer.reload();
            updateRaceTimer();
        }
    }

    function onNextPage() {
        if (myRaceTimer.myIsPaused) {
            myRaceTimer.reset();
        } else {
            myRaceTimer.syncDown();
        }

        updateRaceTimer();
        Ui.requestUpdate();
    }

    function timerCallback() {
        var now = Time.now();

        var info = Gregorian.info(now, Time.FORMAT_SHORT);
        var timeString = Lang.format(
            "$1$:$2$:$3$",
            [
                info.hour.format("%.2d"),
                info.min.format("%.2d"),
                info.sec.format("%.2d")
            ]
        );
        myView.findDrawableById("topLabel").setText(timeString);

        updateRaceTimer();

        Ui.requestUpdate();
    }

    function updateRaceTimer() {
        var timerString = myRaceTimer.toString();
        myView.findDrawableById("centerLabel").setText(timerString);
    }

}
