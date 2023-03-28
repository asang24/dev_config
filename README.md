# dev_config

#### Mac Terminal(iterm2) Setup

mac 安装 oh-my-zsh 主题 (mac install oh-mh-zsh and powerlevel10k theme)，终端配置

#### 安装 iterm2

https://www.iterm2.com/downloads.html

#### 安装 iterm2 theme (optional)

- https://github.com/mbadolato/iTerm2-Color-Schemes

Term2 > Preferences > Profiles > Colors Tab -> import from and choose theme file.

#### 安装字体 (install nerd-font)

https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

Iterm2 里配置非 acsii 字体，否则对于 powerlevel10k 主题的特殊字体会显示不出来。

(Iterm2 -> Preferences -> Profiles -> Text -> Non-Ascii-Font 选择, 之后重启 Iterm2 生效

#### 安装 tmux 和 tmux 插件管理器(optional)

```bash
brew install tmux

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp .tmux.conf ~/.tmux.conf
cp .tmux.conf.local ~/.tmux.conf.local
```

#### 增加你的终端光标移动速度(移动速度飞起)

```bash
# 终端下执行以下几个命令，然后重新登出当前账户并登入（或者重启）
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1  # 默认值 2，设置成 1 合适，设置成 0 就太快了
defaults write NSGlobalDomain InitialKeyRepeat -int 10
```

