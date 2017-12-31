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
  $('#patch-button').click(patch)
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

function getPatchData() {
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
    starColor: toFiveBit($('#star-color').data('colorpicker').color.toRGB()),
    softReset: checked('soft-reset'),
    alwaysSpawnMIPS: checked('always-spawn-mips'),
    alwaysSpawnSub: checked('always-spawn-sub'),
    alwaysSpawnUnpressedSwitches: checked('always-spawn-unpressed-switches'),
    alwaysSpawnToadStars: checked('always-spawn-toad-stars'),
    fatPenguin: checked('fat-penguin'),
    ttcSpeed: checked('ttc-speed'),
    wdwLevel: checked('wdw-level'),
    fiftyStarText: checked('50-star-text'),
    nonstop: checked('nonstop')
  }
}

function patch() {
  data = getPatchData()

  const {dialog, BrowserWindow} = require('electron').remote
  unpatchedROM = dialog.showOpenDialog({
    title: 'Select ROM to Patch',
    filters: [{
      name: 'z64 ROM File',
      extensions: ['z64']
    }],
    buttonLabel: 'Patch'
  })
  if(!unpatchedROM) return

  writeAsmFile(data, unpatchedROM[0])

  console.log(data)
  console.log(unpatchedROM)
}

function writeAsmFile(data, unpatchedROM) {
  var preHijack = [] // files to include before hijack resource meter
  var postHijack = [] // and after

  // TODO: custom practice files
  preHijack.push('120_star_file.asm')
  if (data.infiniteLives) {
    preHijack.push('infinite_lives.asm')
  }
  if (data.levelReset) {
    preHijack.push('level_reset_pre.asm')
    postHijack.push('level_reset_post.asm')
  }
  // TODO: THI Behavior
  if (data.starSelect) {
    postHijack.push('star_select.asm')
  }
  if (data.savestates) {
    preHijack.push('savestates.asm')
  }
  if (data.levelSelect) {
    postHijack.push('level_select.asm')
  }
  if (data.timer) {
    preHijack.push('timer_pre.asm')
    postHijack.push('timer_post.asm')
    switch (data.showTimer) {
      case 'always':
        preHijack.push('timer_always.asm')
        break
      case 'x-cam':
        preHijack.push('show_stop_xcam.asm')
        break
      case 'star-grab':
        preHijack.push('show_star_grab.asm')
        break
    }
    if (data.stopTimer === 'star-grab') {
      preHijack.push('stop_star_grab.asm')
    } else {
      preHijack.push('show_stop_xcam.asm')
      postHijack.push('xcam_post.asm')
    }
    if (data.timerInCastle) {
      preHijack.push('timer_in_castle.asm')
    }
    if (data.timerCentiseconds) {
      preHijack.push('timer_centiseconds.asm')
    }
  }
  if (data.lagCounter) {
    preHijack.push('lag_counter_pre.asm')
    postHijack.push('lag_counter_post.asm')
    if (data.lagAsLives) {
      preHijack.push('lag_as_lives.asm')
    }
  }
  if (data.speedDisplay) {
    preHijack.push('speed_display.asm')
    // TODO: speed as stars
  }
  if (!data.music) {
    preHijack.push('no_music.asm')
  }
  if (data.unobtainedStars) {
    preHijack.push('unobtained_stars.asm')
  }
  if (data.alwaysSpawnMIPS) {
    preHijack.push('always_spawn_mips.asm')
  }
  if (data.alwaysSpawnSub) {
    preHijack.push('always_spawn_sub.asm')
  }
  if (data.alwaysSpawnUnpressedSwitches) {
    preHijack.push('always_spawn_unpressed_switches.asm')
  }
  if (data.alwaysSpawnToadStars) {
    preHijack.push('always_spawn_toad_stars.asm')
  }
  if (!data.fatPenguin) {
    preHijack.push('no_fat_penguin.asm')
  }
  if (data.ttcSpeed) {
    postHijack.push('ttc_speed.asm')
  }
  if (data.wdwLevel) {
    postHijack.push('wdw_level.asm')
  }
  if (data.fiftyStarText) {
    preHijack.push('50_star_text.asm')
  }
  if (data.nonstop) {
    preHijack.push('nonstop.asm')
  }

  const fs = require('fs')
  var stream = fs.createWriteStream('asm/patch.asm')

  // header stuff
  stream.write(
    'arch n64.cpu\n' +
    'endian msb\n' +
    'include "N64.inc"\n' +
    'include "macros.inc"\n' +
    'origin 0x0\n' +
    // `insert "${unpatchedROM}"\n`
    'insert "../Super Mario 64 (J) [!].z64"\n'
  )

  preHijack.forEach(function(file) {
    stream.write(`include "codes/${file}"\n`)
  })
  stream.write('include "codes/hijack.asm"\n')
  postHijack.forEach(function(file) {
    stream.write(`include "codes/${file}"\n`)
  })
  stream.write('include "codes/return.asm"\n')

  stream.end()
}
