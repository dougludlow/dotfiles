# dotfiles

My personal dotfiles.

## Installation

```bash
git clone https://github.com/dougludlow/dotfiles.git ~/.dotfiles
~/.dotfiles/install
```

## First-time Install

```bash
sudo xcode-select --install
sudo softwareupdate --install-rosetta
```

## When Migrating to a New Machine

- [ ] Create a new Brewfile and copy any new packages - `brew bundle dump`.
- [ ] Copy over additional dotfiles:

  - Enable File Sharing on the old machine
    - System Settings > General > Sharing > File Sharing
  - Connect to the old machine, create a mount at `/Volumes/doug.ludlow`
    - From the terminal - `open smb://doug.ludlow:password@old-machine-name/doug.ludlow`
  - Copy the files over:

    ```bash
    cd /Volumes/doug.ludlow

    # aws cli
    mkdir ~/.aws
    cp .aws/config ~/.aws/.

    # aws vpn
    mkdir -p ~/.config/AWSVPNClient/OpenVpnConfigs
    cp .config/AWSVPNClient/ConnectionProfiles ~/.config/AWSVPNClient/ConnectionProfiles
    cp .config/AWSVPNClient/OpenVpnConfigs/Swell ~/.config/AWSVPNClient/OpenVpnConfigs/Swell

    # kubectl
    mkdir ~/.kube
    cp .kube/config ~/.kube

    # pulumi
    mkdir -p ~/.pulumi/workspaces
    cp -r .pulumi/workspaces/. ~/.pulumi/workspaces
    cp .pulumi/credentials.json ~/.pulumi

    # ssh
    cp -r .ssh/. ~/.ssh

    # gpg
    gpg -o ~/my-key.asc --export-secret-key D78C0B6C7ABA20E07ED3F8DC688F84E9202AA6E9
    mv my-key.asc ~/.
    gpg --import ~/my-key.asc
    rm -f ~/my-key.asc
    cp .gnupg/gpg-agent.conf ~/.gnupg/.
    cp .gnupg/gpg.conf ~/.gnupg/.

    # fonts
    cp -r Library/Fonts/. ~/Library/Fonts
    ```

- [ ] Set preferences:
  - System Settings > Appearance > Dark > Enable
  - System Settings > Desktop & Dock > Mission Control > Automatically rearrange Spaces based on most recent use > Disable
  - System Settings > Mouse > Tracking Speed > 8/10
  - System Settings > Mouse > Secondary Click > Enable
  - System Settings > Keyboard > Keyboard Shortcuts... > Modifier Keys > Option (⌥) Key > Command (⌘)
  - System Settings > Keyboard > Keyboard Shortcuts... > Modifier Keys > Command (⌘) Key > Option (⌘)
- [ ] Export/import Postico and MongoDB Compass connections
- [ ] Copy over any `.env` and `.vscode/settings.json` from any projects
