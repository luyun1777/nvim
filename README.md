# The NeoVim Config

## Requirements

- Neovim >=0.11.2
- [Git](https://git-scm.com/) >= 2.19.0 (for partial clones support)
- `nvim-treesitter` requirements. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- optional (but strongly recommended)
  - A [Nerd Font](https://www.nerdfonts.com/)
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
