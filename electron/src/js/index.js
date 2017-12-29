$(document).ready(function() {
  fileOptions = {
    'Empty': 0,
    '120 Star': 120,
    '74 Star (Up RTA)': 74
  }

  $.each(fileOptions, function(key, value) {
    $('.practice-file-select').each(function() {
      $(this).append($('<option></option>')
        .attr('value', value)
        .text(key)
      )
    })
  })

  $('#file-c').val(120)
  $('#file-d').val(74)
})