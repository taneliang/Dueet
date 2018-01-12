// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $(".datepicker").pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15, // Creates a dropdown of 15 years to control year,
    today: "Today",
    clear: "Clear",
    close: "Ok",
    closeOnSelect: false // Close upon selecting a date,
  });

  $("input[id$='completion']").on("change", function(event) {
    var taskId = event.target.getAttribute("taskid");
    $.ajax({
      url: "/tasks/" + taskId,
      method: "PATCH",
      data: { task: { completed: event.target.checked } }
    });
  });
});
