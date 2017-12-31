$(document).ready(function() {
  // set file picker contents/defaults
  fileOptions = {
    'Empty': 0,
    '120 Star': 120,
    '74 Star (Up RTA)': 74
  }
  $.each(fileOptions, (key, value) => {
    $('.practice-file-select').each((i, el) => {
      $(el).append($('<option></option>')
        .attr('value', value)
        .text(key)
      )
    })
  })
  $('#file-c').val(120)
  $('#file-d').val(74)

  // hide/show elements as necessary
  $('#star-select').change(() => {
    if($(this).is(':checked')) {
      $('#thi-behavior').parent().slideDown();
    } else {
      $('#thi-behavior').parent().slideUp();
    }
  })

  $('#timer-on').change(() => {
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

  $('#timer-always').change(() => {
    if($(this).is(':checked')) {
      $('#show-timer').parent().slideUp();
    } else {
      $('#show-timer').parent().slideDown();
    }
  })

  $('#lag-counter').change(() => {
    if($(this).is(':checked')) {
      $('#lag-as-lives').parent().slideDown();
    } else {
      $('#lag-as-lives').parent().slideUp();
    }
  })

  $('#speed-as-stars').parent().slideUp(); // speed display is off by default so this should be pre-slid
  $('#speed-display').change(() => {
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

  patchROM(data, unpatchedROM[0])
}

function patchROM(data, unpatchedROM) {
  // codes are included in master assembly file in the following order:
  // 1. normal codes - these just modify existing game values one time or do 
  //      something basic
  // 2. codes that need to be ran every frame - to achieve this, we hijack the
  //      resource meter and have it run a bunch of custom code
  //      note that none of these codes have an origin, because they are all
  //      executed in succession
  //    2.1 constant writes - these are always setting a memory value
  //    2.2 conditionals - if thens, essentially
  // 3. append a return statement to our resource meter hijacking
  // 4. other - these involve custom code placed at the end of memory so we
  //      separate them.
  //      TODO: why isn't savestates.asm in this?

  var normal = [] // normal/*.asm
  var hijack = [] // hijack/*.asm
  var other = [] // other/*.asm

  normal.push('title_screen.asm')
  // TODO: custom practice files
  if (data.infiniteLives) {
    hijack.push('infinite_lives.asm')
  }
  if (data.levelReset) {
    normal.push('level_reset.asm')
    hijack.push('level_reset.asm')
  }
  if (data.starSelect) {
    if (data.thiBehavior === 'tiny') {
      hijack.push('star_select_tiny.asm')
    } else {
      hijack.push('star_select_huge.asm')
    }
  }
  if (data.savestates) {
    normal.push('savestates.asm')
  }
  if (data.levelSelect) {
    normal.push('level_select.asm')
    hijack.push('level_select.asm')
  }
  if (data.timer) {
    normal.push('timer.asm')
    hijack.push('reset_timer.asm')
    if (data.timerInCastle) {
      normal.push('timer_in_castle.asm')
    }
    if (data.timerCentiseconds) {
      normal.push('timer_centiseconds.asm')
    }
    var xCam = false
    switch (data.showTimer) {
      case 'always':
        normal.push('show_timer_always.asm')
        break
      case 'x-cam':
        // TODO: using stop code here. shouldn't matter, but should split it out
        xCam = true
        break
      case 'star-grab':
        normal.push('show_star_grab.asm')
        break
    }
    if (data.stopTimer === 'star-grab') {
      normal.push('stop_star_grab.asm')
    } else {
      xCam = true
    }
    if (xCam) {
      // only want to add this once
      normal.push('stop_xcam.asm')
      other.push('stop_xcam.asm')
    }
  }
  if (data.lagCounter) {
    normal.push('lag_counter.asm')
    hijack.push('reset_lag_counter.asm')
    if (data.lagAsLives) {
      normal.push('lag_as_lives.asm')
    }
  }
  if (data.speedDisplay) {
    normal.push('speed_display.asm')
    if (data.speedAsStars) {
      other.push('speed_as_stars.asm')
    }
  }
  if (!data.music) {
    normal.push('no_music.asm')
  }
  if (data.unobtainedStars) {
    normal.push('unobtained_stars.asm')
  }
  // TODO: custom star color
  if (data.softReset) {
    hijack.push('soft_reset.asm')
  }
  if (data.alwaysSpawnMIPS) {
    normal.push('always_spawn_mips.asm')
  }
  if (data.alwaysSpawnSub) {
    normal.push('always_spawn_sub.asm')
  }
  if (data.alwaysSpawnUnpressedSwitches) {
    normal.push('always_spawn_unpressed_switches.asm')
  }
  if (data.alwaysSpawnToadStars) {
    normal.push('always_spawn_toad_stars.asm')
  }
  if (!data.fatPenguin) {
    normal.push('no_fat_penguin.asm')
  }
  if (data.ttcSpeed) {
    hijack.push('ttc_clock_speed.asm')
  }
  if (data.wdwLevel) {
    hijack.push('wdw_water_level.asm')
  }
  if (data.fiftyStarText) {
    normal.push('50_star_text.asm')
  }
  if (data.nonstop) {
    normal.push('nonstop.asm')
  }

  const fs = require('fs-extra')

  fs.copy(unpatchedROM, `asm/unpatched.z64`)

  var stream = fs.createWriteStream('asm/patch.asm')

  // header stuff
  stream.write(
    'arch n64.cpu\n' +
    'endian msb\n' +
    'include "N64.inc"\n' +
    'include "macros.inc"\n' +
    'origin 0x0\n' +
    'insert "./unpatched.z64"\n'
  )

  normal.forEach(val => {
    stream.write(`include "codes/normal/${val}"\n`)
  })
  if (hijack.length != 0) {
    stream.write('include "codes/hijack/hijack.asm"\n')
  }
  stream.write('include "codes/hijack/custom_start.asm"\n')
  if (hijack.length != 0) {
    hijack.forEach(val => {
      stream.write(`include "codes/hijack/${val}"\n`)
    })
    stream.write('include "codes/hijack/return.asm"\n')
  }
  other.forEach(val => {
    stream.write(`include "codes/other/${val}"\n`)
  })

  stream.end()

  // TODO: execSync not working for some reason, so i'm in promise hell
  const {exec} = require('child_process')
  exec('bass.exe -create patch.asm -o output.z64',
    { cwd: 'asm' },
    () => {
      exec('n64crc.exe output.z64',
        { cwd: 'asm' },
        () => {
          fs.remove('asm/unpatched.z64')
          fs.move('asm/output.z64', './Super Mario 64 [J] Patched.z64')
        }
      )
  })
}
