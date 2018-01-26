// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function setupTasks() {
  $("input[id$='completion']").on("change", function(event) {
    var taskId = event.target.getAttribute("taskid");
    $.ajax({
      url: "/tasks/" + taskId,
      method: "PATCH",
      data: { task: { completed: event.target.checked }, no_show: true }
    });
  });
}

$(document).on("turbolinks:load", setupTasks);
