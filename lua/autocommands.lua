lvim.autocommands = {
  { "BufEnter",
    {
      pattern = { "*.vert", "*.frag" },
      command = "set ft=glsl"
    }
  }
}
