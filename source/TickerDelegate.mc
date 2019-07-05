using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class TickerDelegate extends Ui.BehaviorDelegate {

    /* -- Attributes -- */
    var myView;

    var myRaceTimer;
    var myTimer;

    /* -- Constructor -- */
    function initialize(view) {
        BehaviorDelegate.initialize();

        myView = view;
        myRaceTimer = new TickerRaceTimer();
        myTimer = new Timer.Timer();

        myTimer.start(method(:timerCallback), 1000, true);
    }

    /* -- Overridden methods -- */
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
            if (myRaceTimer.myIsStopped) {
                myRaceTimer.increment(5);
            } else {
                myRaceTimer.reload();
            }
            updateRaceTimer();
            Ui.requestUpdate();
        }
    }

    function onNextPage() {
        if (myRaceTimer.myIsPaused) {
            if (myRaceTimer.myIsStopped) {
                myRaceTimer.increment(-1);
            } else {
                myRaceTimer.reset();
            }
        } else {
            myRaceTimer.syncDown();
        }

        updateRaceTimer();
        Ui.requestUpdate();
    }

    /* -- Local methods -- */
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
