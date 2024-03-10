## <center>The NeoVim Config</center>

## ⚡️ Requirements

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org) `npm config set registry https://registry.npmmirror.com/`
- a C compiler for `nvim-treesitter` and more [MinGW-64](https://www.mingw-w64.org/) or [MinGW-W64-binaries](https://github.com/niXman/mingw-builds-binaries)
- [Python](https://www.python.org) `pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple`
- [Make](https://www.gnu.org/software/make/) or [cMake](https://cmake.org/download/)
- A [Nerd Font](https://www.nerdfonts.com/) / [Github](https://github.com/ryanoasis/nerd-fonts) (optional, but strongly recommended)
- for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (optional)
  - live grep: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - find files: [fd](https://github.com/sharkdp/fd)
- [lazygit](https://github.com/jesseduffield/lazygit) (optional)

## 🛠️ Installation

- Linux / MacOS

  ```bash
  # required
  mv ~/.config/nvim ~/.config/nvim.bak

  # optional but recommended
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  mv ~/.local/state/nvim ~/.local/state/nvim.bak
  mv ~/.cache/nvim ~/.cache/nvim.bak

  git clone https://github.com/luyun1777/nvim.git ~/.config/nvim
  # or accelerate with gitee
  git clone https://gitee.com/luyun1777/nvim.git ~/.config/nvim
  ```

- Windows

  ```powershell
  # required
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

  # optional but recommended
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak

  git clone https://github.com/luyun1777/nvim.git $env:LOCALAPPDATA\nvim
  # or accelerate with gitee
  git clone https://gitee.com/luyun1777/nvim.git
  ```

## 📦 Plugins
