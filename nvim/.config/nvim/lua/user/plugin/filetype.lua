return function ()
  require'filetype'.setup {
    overrides = {
      extensions = {
        service     = "systemd",
        target      = "systemd",
        timer       = "systemd",
        slice       = "systemd",
        profile     = "firejail",
        ['local']   = "firejail",
      },
    },
  }
end
