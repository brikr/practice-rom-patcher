$(document).ready(function() {
  // set file picker contents/defaults
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

  // hide/show elements as necessary
  $('#star-select').change(function() {
    if($(this).is(':checked')) {
      $('#thi-behavior').parent().slideDown();
    } else {
      $('#thi-behavior').parent().slideUp();
    }
  })

  $('#timer-on').change(function() {
    if($(this).is(':checked')) {
      $('#timer-in-castle').parent().slideDown();
      $('#timer-centiseconds').parent().slideDown();
      $('#timer-always').parent().slideDown();
      $('#stop-timer').parent().slideDown();
      if(!$('#timer-always').is(':checked')) {
        $('#show-timer').parent().slideDown();
      }
    } else {
      $('#timer-in-castle').parent().slideUp();
      $('#timer-centiseconds').parent().slideUp();
      $('#timer-always').parent().slideUp();
      $('#stop-timer').parent().slideUp();
      $('#show-timer').parent().slideUp();
    }
  })

  $('#timer-always').change(function() {
    if($(this).is(':checked')) {
      $('#show-timer').parent().slideUp();
    } else {
      $('#show-timer').parent().slideDown();
    }
  })

  $('#lag-counter').change(function() {
    if($(this).is(':checked')) {
      $('#lag-as-lives').parent().slideDown();
    } else {
      $('#lag-as-lives').parent().slideUp();
    }
  })

  $('#speed-as-stars').parent().slideUp(); // speed display is off by default so this should be pre-slid
  $('#speed-display').change(function() {
    if($(this).is(':checked')) {
      $('#speed-as-stars').parent().slideDown();
    } else {
      $('#speed-as-stars').parent().slideUp();
    }
  })

  // init star color picker
  $('#star-color').colorpicker({
    format: 'rgb'
  })

  // patch button handler
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
    thiBehavior: checked('thi-behavior') ? 'tiny' : 'huge',
    savestates: checked('savestates'),
    levelSelect: checked('level-select'),
    timer: checked('timer-on'),
    timerInCastle: checked('timer-in-castle'),
    timerCentiseconds: checked('timer-centiseconds'),
    showTimer: checked('timer-always') ? 'always' : (checked('show-timer') ? 'x-cam' : 'star-grab'),
    stopTimer: checked('stop-timer') ? 'x-cam' : 'star-grab',
    lagCounter: checked('lag-counter'),
    lagAsLives: checked('lag-as-lives'),
    speedDisplay: checked('speed-display'),
    speedAsStars: checked('speed-as-stars'),
    music: checked('music'),
    unobtainedStars: checked('unobtained-stars'),
    starColor: toFiveBit($('#star-color').data('colorpicker').color.toRGB())
  }
}