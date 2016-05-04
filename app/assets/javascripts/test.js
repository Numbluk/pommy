$(document).ready(function() {
  var current_stage = 1;
  var first_stage = 1;
  var final_stage = 9;
  var labor_stages = [1, 4, 6, 8];
  var rest_stages = [3, 5, 7];
  var minutes = 3;
  var seconds;

  var setMinutes = function setMinutes() {
    minutes = Math.floor(total_time_in_seconds / 60);
  };

  var setSeconds = function setSeconds() {
    seconds = total_time_in_seconds % 60;
  };

  var changeTime = function changeTime(minutes, seconds) {
    $("#minutes").text(pad(minutes));
    $("#seconds").text(pad(seconds));
  };

  var completeStage = function completeStage() {
    if ( current_stage === final_stage){

      $("i.fa[data-stage='" + final_stage + "']").addClass("finished_stage");
      $("div[data-stage='" + final_stage + "']").addClass("finished_line_or_circle");
      current_stage = 1;

    } else {

      if ( $("[data-stage='" + current_stage + "']").length > 2 &&
           current_stage !== first_stage ) {
        $("i.fa[data-stage='" + current_stage + "']").addClass("finished_stage");
        $("span[data-stage='" + current_stage + "']").addClass("finished_line_or_circle");
        $("div[data-stage='" + current_stage + "']").addClass("finished_line_or_circle");
      } else if ( current_stage === 2 ) {
        $("[data-stage='" + current_stage + "']").addClass("finished_line_or_circle");
      }

      current_stage += 1;
    }
  };

  var nextStage = function nextStage() {
    if ( labor_stages.indexOf(current_stage) > -1 ) {
      setToLabor();
    } else if ( rest_stages.indexOf(current_stage) > -1 ) {
      setToShortBreak();
    } else if ( current_stage === final_stage ) {
      setToLongBreak();
    }
  };

  var pad = function pad(number) {
    number = number.toString();
    if ( number.length === 1 ) {
      number = "0" + number;
    }
    return number;
  };

  var setToLabor = function setToLabor() {
    changeTime(30, 0);
  };

  var setToShortBreak = function setToShortBreak() {
    changeTime(5, 0);
  };

  var setToLongBreak = function setToLongBreak() {
    changeTime(15, 0);
  };

  var getSecondsOnClock = function getSecondsOnClock() {
    return +$("#minutes").text() * 60;
  };

  var checkIfStartTime = function checkIfStartTime() {
    if ( minutes === 30 && labor_stages.indexOf(current_stage) > -1 ||
         minutes === 5 && rest_stages.indexOf(current_stage) > -1 ||
         minutes === 15 && current_stage === final_stage ) {
      return true;
    }
    return false;
  };

  var checkIfEndingTime = function checkIfEndingTime() {
    if ( minutes === 0 && seconds === 0) { return true; }
    return false;
  };

  var resetStages = function resetStages() {
    $(".finished_stage").removeClass("finished_stage");
    $(".finished_line_or_circle").removeClass("finished_line_or_circle");
  };

  // initialize values
  var total_time_in_seconds = getSecondsOnClock();
  setMinutes();
  setSeconds();

  $("#start_end_time").on("click", function() {

     if ( checkIfStartTime() ) {
      if ( current_stage === first_stage ) {
        $("i.fa[data-stage='" + first_stage + "']").addClass("finished_stage");
        $(".circle[data-stage='" + first_stage + "']").addClass("finished_line_or_circle");

        current_stage += 1;
      }

      var timerVar = window.setInterval(function decrementSecond() {
        total_time_in_seconds -= 1;
        setMinutes();
        setSeconds();
        changeTime( minutes, seconds );

        if ( checkIfEndingTime() ) {
          window.clearInterval(timerVar);
          if ( current_stage !== final_stage ) {
            $("#start_end_time").text("Set Time");
          } else {
            $("#start_end_time").text("Reset");
          }
          completeStage();
        }

      }, 1000);
    } else if ( checkIfEndingTime() ) {
      if ( $("#start_end_time").text() === "Reset" ) { resetStages(); }
      nextStage();
      seconds = getSecondsOnClock();
      total_time_in_seconds = getSecondsOnClock();
      $("#start_end_time").text("Begin");
      setMinutes();
      setSeconds();
    }
  });
});
