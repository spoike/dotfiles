// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    updateChannel: 'stable',
    fontSize: 12,
    fontFamily: '"FiraCode-Retina", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',
    cursorAccentColor: '#000',
    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',
    cursorBlink: false,
    showHamburgerMenu: '',
    showWindowControls: '',
    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '0px',
    shell: '',
    shellArgs: ['--login'],
    env: {},
    bell: 'SOUND',
    copyOnSelect: false,
    defaultSSHApp: true,
    base16: {
      scheme: 'mocha',
    },
    visor: {
      hotkey: 'CommandOrControl+Shift+Z',
      position: 'top',
    },
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyperpower',
    'hypersixteen',
    'hyperterm-visor',
    'hyper-spotify'
  ],

  localPlugins: [],

  keymaps: {
  },
};
