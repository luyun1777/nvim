# The NeoVim Config

## Requirements

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org) `npm config set registry https://registry.npmmirror.com/`
- [Python](https://www.python.org) `pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple`
- A [Nerd Font](https://www.nerdfonts.com/) (optional, but strongly recommended)
- for `nvim-treesitter`
  - Neovim 0.11.0 or later (nightly)
  - tar and curl in your path
  - tree-sitter-cli (0.26.1 or later)
  - a C compiler in your path (see https://docs.rs/cc/latest/cc/#compile-time-requirements) for `Windows` see [MinGW-64](https://www.mingw-w64.org/) or [MinGW-W64-binaries](https://github.com/niXman/mingw-builds-binaries)

- optional
  - live grep: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - find files: [fd](https://github.com/sharkdp/fd)
  - [lazygit](https://github.com/jesseduffield/lazygit)

## Installation

- Linux / MacOS

  ```bash

  # required
  mv ~/.config/nvim{,.bak}

  # optional but recommended
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}

  git clone https://github.com/luyun1777/nvim.git ~/.config/nvim
  # or accelerate by gitee
  git clone https://gitee.com/luyun1777/nvim.git ~/.config/nvim
  ```

- Windows

  ```powershell
  # required
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

  # optional but recommended
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak

  git clone https://github.com/luyun1777/nvim.git $env:LOCALAPPDATA\nvim
  # or accelerate by gitee
  git clone https://gitee.com/luyun1777/nvim.git $env:LOCALAPPDATA\nvim
  ```

## Plugins

<!-- TODO: Plugins descrption -->
