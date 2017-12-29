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
  $('#star-color').colorpicker({
    format: 'rgb'
  })

  $('#patch-button').click(function() {
    json = getPatchJson()
    console.log(json)
  })
})

// helper to get selected option's value in select
function selected(id) {
  return $('#' + id + ' option:selected').val()
}

// helper to return whether or not a checkbox is checked
function checked(id) {
  return $('#' + id).is(':checked')
}

// helper to get value of selected radio option
function radio(name) {
  return $('input[name=' + name + ']:checked').val()
}

// converts RGB color to 5551 hex
function toFiveBit(color) {
  rgba = 0
  rgba += (color.r / 8) << 11
  rgba += (color.g / 8) << 6
  rgba += (color.b / 8) << 1
  rgba += 1 // alpha
  
  return rgba
}

function getPatchJson() {
  return {
    fileA: selected('file-a'),
    fileB: selected('file-b'),
    fileC: selected('file-c'),
    fileD: selected('file-d'),
    infiniteLives: checked('infinite-lives'),
    levelReset: checked('level-reset'),
    starSelect: checked('star-select'),
    thiBehavior: radio('thi-behavior'),
    savestates: checked('savestates'),
    levelSelect: checked('level-select'),
    timer: checked('timer'),
    timerInCastle: checked('timer-in-castle'),
    timerCentiseconds: checked('timer-centiseconds'),
    showTimer: radio('show-timer'),
    stopTimer: radio('stop-timer'),
    lagCounter: checked('lag-counter'),
    lagAsLives: checked('lag-as-lives'),
    speedDisplay: checked('speed-display'),
    speedAsStars: checked('speed-as-stars'),
    music: checked('music'),
    unobtainedStars: checked('unobtained-stars'),
    starColor: toFiveBit($('#star-color').data('colorpicker').color.toRGB())
  }
}