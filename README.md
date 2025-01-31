<div align="center">
  <img alt="repo size" src="https://img.shields.io/github/repo-size/millerapps/dotfiles?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387" />
  <img alt="darwin-build" src="https://img.shields.io/github/actions/workflow/status/millerapps/dotfiles/validatenix.yml?branch=main&label=Darwin%20Build&style=for-the-badge&labelColor=1e1e2e&color=a6e3a1&logo=github-actions&logoColor=a6e3a1&successColor=a6e3a1&failColor=f38ba8" />
  <img alt="nixos-unstable" src="https://img.shields.io/badge/Nix-nixpkgs.unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3" />
  <img alt="nix-darwin" src="https://img.shields.io/badge/Nix-Darwin-blue.svg?style=for-the-badge&labelColor=30344i6&logo=NixOS&logoColor=white&color=f2cdcd" />
  <img alt="homebrew" src="https://img.shields.io/badge/Homebrew-macOS-blue.svg?style=for-the-badge&labelColor=1e1e2e&logo=Homebrew&logoColor=white&color=cba6f7" />
  <img alt="nix-home-manager" src="https://img.shields.io/badge/Nix-Home_Manager-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=eba0ac" />
</div>

<br />

<div align="center">
  <img alt="nix-darwin-flake" src="/imgs/nix-darwin-flake.png" />
</div>
<br />

[TODO](./TODO.md)

# Nix-Darwin, Nix-Home-Manager, & Homebrew

This repository serves as a guide for setting up and managing my macOS system using Nix-Darwin, Nix Home Manager, and Homebrew. 
It is designed for personal reference but can also be useful to others interested in a similar setup.

How it works:
- The Nix package manager is used as the primary way to handle needed clitools, Languages, and apps.
- Nix-Darwin sets up the system based on the flake.nix and the correlating files in the nix-darwin directory.
- Nix-Home-Manager hooks into Nix-Darwin to handle the .config files and other .files in the home directory.
- Homebrew is used to install macOS apps and fonts. This is handled by Nix-Darwin's homebrew module. Homebrew is also installed via [Nix-Homebrew](https://github.com/zhaofengli/nix-homebrew).

> [!NOTE]
> This is a first round at integrating nix-darwin, nix-home-manager, and homebrew. This is a work in progress and will be updated as I learn more.
> If you have any tips or know of a better way to do something, please let me know.

> [!WARNING]
> If you not looking to dive into the rabbit hole that is Nix, then this type of setup is not for you. It is a steep learning curve, but the benefits are worth it.

## Lets dive the rabbit hole!

![Rabbit Hole](./imgs/rabbit-hole.gif)

## Table of Contents
- [Introduction](#nix-darwin-nix-home-manager--homebrew)
- [Nix Language Overview](#nix-language-overview)
- [Install Guide for Nix-Darwin](#install-guide-for-nix-darwin)
  - [Install Nix Package Manager](#install-nix-package-manager)
  - [Clone Repository](#clone-repository)
  - [Install Nix-Darwin](#install-nix-darwin)
  - [Apply Configuration](#apply-configuration)
- [Nix-Darwin Directory Structure](#nix-darwin-directory-structure)
  - [Explanation of the Structure](#explanation-of-the-structure)
	- [How It Works](#how-it-works)
- [Script/backup](#scripts)
- [Converting Apple Key Codes (0x Format)](#converting-apple-key-codes-0x-format)
	- [Command Line Methods](#command-line-methods)
	- [Manual Conversion (Hex to Decimal)](#manual-conversion-hex-to-decimal)
	- [Manual Conversion (Decimal to Hex)](#manual-conversion-decimal-to-hex)
	- [Useful Tip for Manual Conversion](#useful-tip-for-manual-conversion)
	- [Function Key Codes](#function-key-codes)
	- [Easier way](#easier-way)
	- [Nix Configuration Example](#nix-configuration-example)
- [Resources - learning](#resources---learning)

## Nix Language Overview

The Nix language is a domain-specific, declarative, and functional language designed for defining derivations—precise descriptions of how existing files or inputs are used to generate new ones.

> [!Tip]
> For a beginner-friendly introduction, visit the [Introduction to Nix Language](https://nix.dev/tutorials/nix-language).

Language Features relevant to this setup:

> [!Note]
> Will be updated as I learn more. Possibly some more examples.

| Example | Description |
|---------|-------------|
| `"hello world"` | A basic string |
| `# Comment` | Simple comment |
| `true`, `false` | Boolean values |
| `[ 1 2 3 ]` | A list |
| `{ x = 1; y = 2; }` | An attribute set, nearly everything is a set |
| `"${pkgs.vim}/bin/vim"` | String interpolation |
| `{ inherit pkgs; }` | Inherit keyword |
| `import ./file.nix` | Import a Nix file |
| `{ ... }` | Ellipsis (ignored arguments) |
| `~/.config` | Home directory path |
| `./relative/path` | Relative path |
| `{ config, pkgs, ... }: { }` | Basic configuration |

## Install Guide for Nix-Darwin

> [!IMPORTANT]
> The Nix package manager is required to install nix-darwin. If you have not installed Nix, follow the instructions below.

1. **Install the Nix package manager**  
   Run the following command to install Nix:
   ```sh
   curl -sSf -L https://install.lix.systems/lix | sh -s -- install
   ```

2. **Clone the repository using a temporary Git installation**  
   If Git is not installed, you can use a temporary version provided by Nix:
   ```sh
   nix-shell -p git --run "git clone https://github.com/MillerApps/dotfiles.git ~/dotfiles"
   ```
> [!NOTE]
> This will:
> - Temporarily use Git from Nix
> - Clone your repository
> - Create a `dotfiles` directory in your home folder
> - Place all repository contents in `~/dotfiles`

3. **Use `just` temporarily to manage system commands**  
   If `just` is not installed, you can run it temporarily with Nix:
   ```sh
   nix-shell -p just
   ```

4. **Bootstrap nix-darwin**

[nix-darwin](https://github.com/LnL7/nix-darwin) for full details see, the installation instructions at the link. Use the flake section.
    
> [!NOTE]
> This installs nix-darwin using the flake feature of nix. This is the recommended way to install nix-darwin.
> This also assumes you cloned the repo to `~/dotfiles`

   Install xcode tools: 
   ```sh
   xcode-select --install
   ```

   Use the Justfile target for `bootstrap`, or directly run:
   ```sh
   nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix-darwin#macbook
   ```

5. **Rebuild and apply the configuration**  
   Use the Justfile target for `switch`, or directly run:
   ```sh
   darwin-rebuild switch --flake ~/dotfiles/nix-darwin#macbook
   ```

> [!NOTE]
> These are the commands available in the Justfile. You can run them using `just <command>`.
> Which will be available permanently after step 5, from within the dotfiles directory.

<details>
<summary><b>Click to view Justfile commands</b></summary>

- `switch`: Switch to the current flake configuration
- `bootstrap`: Bootstrap nix-darwin and install Xcode Command Line Tools
- `clean`: Remove unused store entries
- `clean-all`: Remove all unused store entries, including old generations
- `update`: Update flake inputs
- `check`: Verify configuration
- `rollback`: Rollback to the previous generation
- `generations`: Show system generations and available rollback targets
- `build`: Build configuration without switching

</details>

## Nix-Darwin directory structure

The nix-darwin directory is structured as follows:

```sh
 nix-darwin
├──  flake.lock
├──  flake.nix
├── 󱂵 home
│   ├──  default.nix
│   └──  tylermiller
│       ├──  default.nix
│       ├──  git.nix
│       ├──  lazygit.nix
│       ├──  neovim.nix
│       ├──  spiceify.nix
│       ├──  tmux.nix
│       └──  zellij.nix
└──  modules
    ├──  common
    │   ├──  nix.nix
    │   ├──  packages.nix
    │   ├──  system.nix
    │   ├──  users.nix
    │   └──  zsh.nix
    ├──  darwin
    │   ├──  homebrew.nix
    │   └──  macos.nix
    └──  default.nix
```

> The modules directory splits the config into modular files, which form the overall Nix-Darwin configuration.
> `default.nix` is the container for all modules. This is automatically sourced by nix-darwin when importing `./modules` in `flake.nix`.

### Explanation of the Structure

1. flake.nix

The primary configuration file for Nix Flakes. It defines inputs (dependencies like Nixpkgs, Home Manager, and Darwin modules) and outputs (system-wide and user-specific configurations). It serves as the entry point for building and managing the Nix-Darwin setup.

2. flake.lock

A lock file that ensures the setup is reproducible by fixing dependencies to specific versions. This file is automatically generated and ensures consistent behavior across systems.

3. home/
A directory containing a `default.nix` and a `tylermiller` directory. 
The `default.nix` file is the entry point for building the user setup. The file acts as an entry point for Home Manager, separating the setup from the actual configurations.
The `default.nix` inside the tylermiller directory contains user-specific configurations, managed by Home Manager. It handles settings like shell preferences, environment variables, and dotfiles (my main use case).

4. modules/

A collection of modular files that define specific aspects of the system or user configuration. Each file in this directory is dedicated to a particular functionality.
- `default.nix`
  - This is the “main” file in the modules folder. When you import the folder, Nix automatically looks for default.nix first.
  - It imports all your other modules (like homebrew.nix, macos.nix, etc.). Essentially, it says, “Combine all these configuration pieces together into one system configuration.”
- `homebrew.nix`
  - Sets up Homebrew through nix‐darwin.
  - Declares which Homebrew packages (taps, casks, and even Mac App Store apps) you want installed automatically.
  - By listing them here, nix‐darwin ensures they’re always present, keeps them updated, and so on.
- `macos.nix`
  - Tweaks macOS‐specific settings, such as:
  - Enabling sudo with Touch ID.
  - Customizing the Dock (which apps are pinned, size, etc.).
  - Finder preferences (showing hard drives on desktop, new window location, etc.).
  - Trackpad settings.
  - Think of it as your “macOS system preferences in Nix form.”
- `nix.nix`
  - Adjusts how Nix itself behaves on your system.
  - For instance, it might set your nixPath, turn on experimental features like flakes, etc.
- `packages.nix`
  - Declares the system packages you want installed from the Nix package collection (nixpkgs).
  - Lists things like command‐line tools (e.g., lazygit, bat, fzf, lua, etc.).
  - If you add a package here, it will be part of your system profile.
- `system.nix`
  - Contains some higher‐level nix‐darwin system config, such as a stateVersion or references to Git commit hashes (so you can track system changes).
  - Not heavily used in every setup, but good for storing “top‐level” or version‐related settings.
- `users.nix`
  - Defines user‐specific settings under users.users.<name>.
  - For instance, it can set the home directory or other user details.
  - In a more advanced setup, you could also manage user groups, shells, etc., but here it mainly shows where the home folder lives.
- `zsh.nix`
  - Enables and configures Zsh as your login shell under nix‐darwin.
  - Sets up additional Zsh features:
  - Hooks to source Zsh plugins (e.g. zsh-autosuggestions, zsh-syntax-highlighting).
  - Paths for frameworks like oh-my-zsh and theme engines like powerlevel10k.

### How It Works

- `flake.nix` references `./modules` and other configuration files to build the overall system and user setup.
- The `modules/default.nix` file ensures that all relevant modules in the modules directory are included automatically.
- This structure allows for a clear separation of concerns, making configurations easier to manage and extend.

## Scripts

Inside the script directory is an optional minimal backup script. Its only functionality is to perform a brew bundle dump and to make a backup of the current wallpaper if it has 
changed.    
**Why brew bundle dump?** Well simply in case I forgot to add the new app into `homebrew.nix`, this way I'm covered in case of a device failure as well.

### How its used
Setup cron with the following:
```sh
crontab -e
```

Then use the following:

```cron
# Runs every Monday, Wednesday, Friday, and Sunday at 1PM EST
0 13 * * 0,1,3,5 /Users/tylermiller/dotfiles/script/backup.zsh && curl -H ta:smiley -d "Backup complete" https://ntfy.<ntfy-url>/cronjob || curl -H ta:worried -d "Something went wrong" https://ntfy.<ntfy-url>/cronjob

```
## Converting Apple Key Codes (0x Format)

### Command Line Methods
```bash
# Convert hex to decimal using Bash arithmetic expansion
# Bash recognizes numbers prefixed with `16#` as base-16 (hexadecimal).
echo $((16#FFFF))  # 65535
echo $((16#0050))  # 80

# Convert decimal to hex using printf
# The %X formats the number as hexadecimal, and %04X ensures padding with zeros for 4 characters.
printf '0x%04X\\n' 65535  # 0xFFFF
printf '0x%04X\\n' 80     # 0x0050
```

### Explanation:

#### **Hexadecimal to Decimal**:
- The `16#` prefix indicates a base-16 number.
- The `$((...))` syntax evaluates arithmetic expressions and converts the hexadecimal value into its decimal equivalent.

#### **Decimal to Hexadecimal**:
- `printf` with `%X` formats the number as hexadecimal.
- `%04X` ensures the result is at least 4 characters wide, padding with zeros if necessary.
- Adding `0x` as a prefix makes it clear the output is in hexadecimal format.

---

### Manual Conversion (Hex to Decimal)
Convert by multiplying each hex digit by its positional value (powers of 16).

#### Step-by-Step Process:
1. Write the number, separating each digit.
2. Identify the positional value of each digit (16ⁿ from right to left).
3. Multiply each digit by its positional value.
4. Add the results together.

#### Example: 0x0050
```
0 × 16³ (0 × 4096) = 0
0 × 16² (0 × 256)  = 0
5 × 16¹ (5 × 16)   = 80
0 × 16⁰ (0 × 1)    = 0
                    = 80
```

#### Example: 0xFFFF
```
F(15) × 16³ (15 × 4096) = 61,440
F(15) × 16² (15 × 256)  = 3,840
F(15) × 16¹ (15 × 16)   = 240
F(15) × 16⁰ (15 × 1)    = 15
                        = 65,535
```

#### Useful Tip for Manual Conversion:
- Use a chart for hexadecimal digits (0-9, A-F):
  | Hex Digit | Decimal Value |
  |-----------|---------------|
  | 0         | 0             |
  | 1         | 1             |
  | 2         | 2             |
  | ...       | ...           |
  | A         | 10            |
  | B         | 11            |
  | C         | 12            |
  | D         | 13            |
  | E         | 14            |
  | F         | 15            |

### Manual Conversion (Decimal to Hex)
1. Divide the decimal number by 16.
2. Record the remainder (this will be the least significant digit).
3. Repeat the division with the quotient until it equals 0.
4. Reverse the remainders to get the hexadecimal result.

#### Example: Convert 80 to Hex
1. `80 ÷ 16 = 5` remainder `0` (least significant digit).
2. `5 ÷ 16 = 0` remainder `5`.
3. Reverse the remainders: `50` (hexadecimal).

---

## Function Key Codes
Prefix: 65535 (0xFFFF) for all function keys

| Key | Decimal | Hex    |
|-----|---------|--------|
| F19 | 80      | 0x0050 |
| F20 | 90      | 0x005A |
| F21 | 91      | 0x005B |
| F22 | 92      | 0x005C |
| F23 | 93      | 0x005D |
| F24 | 94      | 0x005E |

## Easier way

The easier way would be to use this handy chart from [jimratliff on GitHub](https://gist.github.com/jimratliff/227088cc936065598bedfd91c360334e):

<details>
<summary>Keyboard Mapping Reference</summary>

| Keyboard Label | Character | ASCII code (Parameter #1) | Mac Virtual Key Code (Parameter #2) | Layout dependence |
|---------------|-----------|-------------------------|-----------------------------------|------------------|
| 0 | 0 | 48 | 029 | ANSI-US |
| 1 | 1 | 49 | 018 | ANSI-US |
| 2 | 2 | 50 | 019 | ANSI-US |
| 3 | 3 | 51 | 020 | ANSI-US |
| 4 | 4 | 52 | 021 | ANSI-US |
| 5 | 5 | 53 | 023 | ANSI-US |
| 6 | 6 | 54 | 022 | ANSI-US |
| 7 | 7 | 55 | 026 | ANSI-US |
| 8 | 8 | 56 | 028 | ANSI-US |
| 9 | 9 | 57 | 025 | ANSI-US |
| A | a | 97 | 000 | ANSI-US |
| B | b | 98 | 011 | ANSI-US |
| C | c | 99 | 008 | ANSI-US |
| D | d | 100 | 002 | ANSI-US |
| E | e | 101 | 014 | ANSI-US |
| F | f | 102 | 003 | ANSI-US |
| G | g | 103 | 005 | ANSI-US |
| H | h | 104 | 004 | ANSI-US |
| I | i | 105 | 034 | ANSI-US |
| J | j | 106 | 038 | ANSI-US |
| K | k | 107 | 040 | ANSI-US |
| L | l | 108 | 037 | ANSI-US |
| M | m | 109 | 046 | ANSI-US |
| N | n | 110 | 045 | ANSI-US |
| O | o | 111 | 031 | ANSI-US |
| P | p | 112 | 035 | ANSI-US |
| Q | q | 113 | 012 | ANSI-US |
| R | r | 114 | 015 | ANSI-US |
| S | s | 115 | 001 | ANSI-US |
| T | t | 116 | 017 | ANSI-US |
| U | u | 117 | 032 | ANSI-US |
| V | v | 118 | 009 | ANSI-US |
| W | w | 119 | 013 | ANSI-US |
| X | x | 120 | 007 | ANSI-US |
| Y | y | 121 | 016 | ANSI-US |
| Z | z | 122 | 006 | ANSI-US |
| F1 | | 65535 | 122 | Independent |
| F2 | | 65535 | 120 | Independent |
| F3 | | 65535 | 099 | Independent |
| F4 | | 65535 | 118 | Independent |
| F5 | | 65535 | 096 | Independent |
| F6 | | 65535 | 097 | Independent |
| F7 | | 65535 | 098 | Independent |
| F8 | | 65535 | 100 | Independent |
| F9 | | 65535 | 101 | Independent |
| F10 | | 65535 | 109 | Independent |
| F11 | | 65535 | 103 | Independent |
| F12 | | 65535 | 111 | Independent |
| F13 | | 65535 | 105 | Independent |
| F14 | | 65535 | 107 | Independent |
| F15 | | 65535 | 113 | Independent |
| F16 | | 65535 | 106 | Independent |
| F17 | | 65535 | 064 | Independent |
| F18 | | 65535 | 079 | Independent |
| F19 | | 65535 | 080 | Independent |
| F20 | | 65535 | 090 | Independent |
| Keypad0 | | 65535 | 082 | ANSI-US |
| Keypad1 | | 65535 | 083 | ANSI-US |
| Keypad2 | | 65535 | 084 | ANSI-US |
| Keypad3 | | 65535 | 085 | ANSI-US |
| Keypad4 | | 65535 | 086 | ANSI-US |
| Keypad5 | | 65535 | 087 | ANSI-US |
| Keypad6 | | 65535 | 088 | ANSI-US |
| Keypad7 | | 65535 | 089 | ANSI-US |
| Keypad8 | | 65535 | 091 | ANSI-US |
| Keypad9 | | 65535 | 092 | ANSI-US |
| KeypadClear | | 65535 | 071 | ANSI-US |
| KeypadDecimal | | 65535 | 065 | ANSI-US |
| KeypadDivide | | 65535 | 075 | ANSI-US |
| KeypadEnter | | 65535 | 076 | ANSI-US |
| KeypadEquals | | 65535 | 081 | ANSI-US |
| KeypadMinus | | 65535 | 078 | ANSI-US |
| KeypadMultiply | | 65535 | 067 | ANSI-US |
| KeypadPlus | | 65535 | 069 | ANSI-US |
| Backslash | \ | 92 | 042 | ANSI-US |
| CapsLock | | 65535 | 057 | Independent |
| Comma | , | 44 | 043 | ANSI-US |
| Command | | 65535 | 055 | Independent |
| Control | | 65535 | 059 | Independent |
| Delete | | 65535 | 051 | Independent |
| DownArrow | | 65535 | 125 | Independent |
| End | | 65535 | 119 | Independent |
| Equal | = | 61 | 024 | ANSI-US |
| Escape | | 27 | 053 | Independent |
| ForwardDelete | | 65535 | 117 | Independent |
| Function | | 65535 | 063 | Independent |
| Grave | ` | 96 | 050 | ANSI-US |
| Help | | 65535 | 114 | Independent |
| Home | | 65535 | 115 | Independent |
| LeftArrow | | 65535 | 123 | Independent |
| LeftBracket | [ | 91 | 033 | ANSI-US |
| Minus | - | 45 | 027 | ANSI-US |
| Mute | | 65535 | 074 | Independent |
| Option | | 65535 | 058 | Independent |
| PageDown | | 65535 | 121 | Independent |
| PageUp | | 65535 | 116 | Independent |
| Period | . | 46 | 047 | ANSI-US |
| Quote | ' | 39 | 039 | ANSI-US |
| Return | | 65535 | 036 | Independent |
| RightArrow | | 65535 | 124 | Independent |
| RightBracket | ] | 93 | 030 | ANSI-US |
| RightCommand | | 65535 | 054 | Independent |
| RightControl | | 65535 | 062 | Independent |
| RightOption | | 65535 | 061 | Independent |
| RightShift | | 65535 | 060 | Independent |
| Semicolon | ; | 59 | 041 | ANSI-US |
| Shift | | 65535 | 056 | Independent |
| Slash | / | 47 | 044 | ANSI-US |
| Space | | 32 | 049 | Independent |
| Tab | | 9 | 048 | Independent |
| UpArrow | | 65535 | 126 | Independent |
| VolumeDown | | 65535 | 073 | Independent |
| VolumeUp | | 65535 | 072 | Independent |
</details>

Or you can use the following method:

1. Open Keyboard in System Preferences. system preferences > Keyboard (> Shortcuts) 
2. Then change settings for what you wish to find the symbolic hotkey IDs for.
3. Use the following Sequence of commands to get all the information you need:
```sh
# 1. Dump current symbolic hotkey mappings
defaults read com.apple.symbolichotkeys > before.plist

# 2. Dump updated symbolic hotkey mappings
defaults read com.apple.symbolichotkeys > after.plist

# 3. Compare plists to identify the Symbolic Hotkey ID and its parameter values
diff before.plist after.plist
```

This process captures:
  - Symbolic Hotkey ID (e.g., "163")
  - Parameter array (keycode, modifiers)
  - Type (e.g., "standard")
  - Enabled state
  - The diff will show the complete symbolic hotkey definition for the modified System Shortcut.

## Nix Configuration Example

```nix
"com.apple.symbolichotkeys" = {
  AppleSymbolicHotKeys = {
    "163" = {  # Notification Center
      enabled = true;
      value = {
        parameters = [ 
          65535     # Function key prefix (0xFFFF)
          80        # Key code (F19 = 0x0050)
          0         # No modifiers
        ];
        type = "standard";
      };
    };
  };
};
```

## Resources - learning

- [Home Manager Options Reference](https://nix-community.github.io/home-manager/options.xhtml) - Comprehensive list of Home Manager options
- [Nix Language Tutorial](https://nix.dev/tutorials/nix-language) - Beginner-friendly introduction to the Nix language
- [Nix Language Manual](https://nix.dev/manual/nix/2.24/language/) - Official Nix language documentation
- [Nix Packages Search](https://search.nixos.org/packages) - Search for packages in Nixpkgs
- [My Nixos](https://mynixos.com/) - Has useful search for docs and packages
- [Vimjoyer youtube](https://www.youtube.com/watch?v=a67Sv4Mbxmc&list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE) - Great video series on nix and nixos
- [Nix Glossary](https://nix.dev/manual/nix/2.18/glossary#gloss-derivation) - Nix glossary of terms
- [Nix Flakes](https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-flake) - Nix Flakes docs
- [Activate Your Preferences](https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236) - Quick tip on activating preferences
- [Apple keycodes chart - info](https://gist.github.com/jimratliff/227088cc936065598bedfd91c360334e) - Apple keycodes
- [Nix Witch](https://isabelroses.com/blog/tag/nix) - isabelroses (Nix Witch) blog on nix; very helpful if you reach out as well.
- [Jake Hamilton](https://www.youtube.com/playlist?list=PLCy0xwW0SDSSt2VJKx3MsXRuVvcFUO6Sw) - Past Live streams on nix and nixos
- [Nix for Startups](https://www.youtube.com/watch?v=WJZgzwB3ziE) - Nix for Startups by Cam Pedersen
