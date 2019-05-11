using Toybox.Application;
using Toybox.WatchUi;

class TickerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        var view = new TickerView();
        var delegate = new TickerDelegate(view);
        return [ view, delegate ];
    }

}
