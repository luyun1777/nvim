# <center>The NeoVim Config</center>

## Requirements

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org) `npm config set registry https://registry.npmmirror.com/`
- a C compiler for `nvim-treesitter` for `Windows` [MinGW-64](https://www.mingw-w64.org/) or [MinGW-W64-binaries](https://github.com/niXman/mingw-builds-binaries) and more
- [Python](https://www.python.org) `pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple`
- A [Nerd Font](https://www.nerdfonts.com/) (optional, but strongly recommended)
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
