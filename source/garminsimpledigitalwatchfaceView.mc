using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian as Date;

class garminsimpledigitalwatchfaceView extends WatchUi.WatchFace {

	const DEVICE_WIDTH_CENTER = 120;
	const DEVICE_WIDTH = 240;	
	
    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        drawTime(dc);
        drawBattery(dc);
        drawDate(dc);
        drawSteps(dc); 
    }
    
	function drawTime(dc) {
		var clockTime = System.getClockTime();
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.drawText(
	        DEVICE_WIDTH_CENTER,
	        70,
	        Graphics.FONT_SYSTEM_NUMBER_THAI_HOT,
	        Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]),
	        Graphics.TEXT_JUSTIFY_CENTER
        );
	}
	
	function drawDate(dc) {
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var date = Date.info(Time.now(), Time.FORMAT_SHORT);
    	dc.drawText(
	        DEVICE_WIDTH_CENTER,
	        180,
	        Graphics.FONT_SYSTEM_LARGE,
	        Lang.format("$1$-$2$-$3$", [date.year, date.month.format("%02d"), date.day.format("%02d")]),
	        Graphics.TEXT_JUSTIFY_CENTER
        );
	}
	
	function drawSteps(dc) {
		var activityMonitorInfo = ActivityMonitor.getInfo(); 
		dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
    	dc.drawText(
	        DEVICE_WIDTH_CENTER,
	        23,
	        Graphics.FONT_SYSTEM_LARGE,
	        Lang.format("$1$ / $2$", [activityMonitorInfo.steps.format("%d"), activityMonitorInfo.stepGoal.format("%d")]),
	        Graphics.TEXT_JUSTIFY_CENTER
        );
	}
	
	function drawBattery(dc) {
		dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 73, 240, 5);	
		dc.fillRectangle(0, 163, 240, 5);
		
		var battery = System.getSystemStats().battery;
		var batteryColor = Graphics.COLOR_LT_GRAY;
		if (battery < 16) {
			batteryColor = Graphics.COLOR_DK_RED;
		} else if (battery < 31) {
			batteryColor = Graphics.COLOR_ORANGE;
		}		
		dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
		var rectangleWidth = 113 * battery / 100;
		
		dc.fillRectangle(120, 73, rectangleWidth, 5);
		dc.fillRectangle(121 - rectangleWidth, 73, rectangleWidth, 5);	
		dc.fillRectangle(120, 163, rectangleWidth, 5);
		dc.fillRectangle(121 - rectangleWidth, 163, rectangleWidth, 5);
		
		dc.fillRectangle(0, 0, DEVICE_WIDTH, 5);
		dc.fillRectangle(0, 235, DEVICE_WIDTH, 5);    	
    	
	}

}
