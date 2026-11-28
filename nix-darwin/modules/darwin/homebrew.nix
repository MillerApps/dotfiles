{
  config = {
    # Homebrew
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false;
        upgrade = false;
        cleanup = "none";
      };
      brews = [
        "mas"
        "tabiew"
        "otree"
        "FelixKratz/formulae/borders"
        "opencode"
        "ripgrep"
        "fd"
        "colima"
        "docker"
        "gowall"
        "gromgit/brewtils/taproom"
        "nmap"
      ];
      taps = [
        "FelixKratz/formulae"
        "gromgit/brewtils"
        "nikitabobko/tap"
        "steipete/tap"
        "theboredteam/boring-notch"
      ];
      masApps = {
        "ExcalidrawZ" = 6636493997;
        "Infuse" = 1136220934;
        "Final Cut Pro" = 424389933;
        "Keka" = 470158793;
      };
      # Must have apps
      casks = [
        # Privacy-focused app for managing your finances
        "actual"
        # Terminal
        "ghostty"
        # AirPods companion app
        "airbuddy"
        # Menu bar tool to limit maximum charging percentage
        "aldente"
        # Application uninstaller
        "appcleaner"
        # Tool to flash OS images to SD cards & USB drives
        "balenaetcher"
        # Blizzard game launcher
        "battle-net"
        # 3D model slicing software for 3D printers, maintained by Bambu Lab
        "bambu-studio"
        # Graphical configurator for Dygma Raise keyboards
        "bazecor"
        # Not so boring notch That Rocks
        "theboredteam/boring-notch/boring-notch"
        # OpenAI's official ChatGPT desktop app
        "chatgpt"
        # Anthropic's official Claude AI desktop app
        "claude"
        # Terminal-based AI coding assistant
        "claude-code"
        # Screen capturing tool
        "cleanshot"
        # OpenAI's coding agent that runs in your terminal
        "codex"
        # Menu bar usage monitor for Codex and Claude
        "steipete/tap/codexbar"
        # Server and cloud storage browser
        "cyberduck"
        # Convert potentially dangerous PDFs or Office documents into safe PDFs
        "dangerzone"
        # Virtual monitor for screen sharing
        "deskpad"
        # Downloads videos from different websites
        "downie"
        # Productivity app
        "dropzone"
        # Matrix collaboration client
        "element"
        # Desktop client for Ente Photos
        "ente"
        # Desktop client for Ente Auth
        "ente-auth"
        "font-jetbrains-mono-nerd-font"
        "font-meslo-lg-nerd-font"
        "font-monaspice-nerd-font"
        "font-roboto-mono-nerd-font"
        # Native app for managing terminal themes
        "forel"
        # Free and open-source media player
        "iina"
        # Free and open-source image editor
        "gimp"
        # Grok desktop client
        "grok-bot"
        # Chromium-based web browser
        "helium-browser"
        # GUI for browsing Homebrew packages
        "homebrew-app"
        # Keyboard shortcuts for every button on your screen
        "homerow"
        # Keyboard customiser
        "karabiner-elements"
        # Open-source keystroke visualiser
        "keycastr"
        # Utility that shows the latest app updates
        "latest"
        # Custom Discord client
        "legcord"
        # Open-source cross-platform alternative to AirDrop
        "localsend"
        # Software for Logitech devices
        "logi-options+"
        # USB device utility
        "macusb"
        # Tool to control external monitor brightness & volume
        "monitorcontrol"
        # VPN client
        "mullvad-vpn"
        # Free and open-source RSS reader
        "netnewswire"
        # Knowledge base that works on top of a local folder of plain text Markdown files
        "obsidian"
        # Get up and running with large language models locally
        "ollama-app"
        # Verify system files structure, run miscellaneous maintenance and more
        "onyx"
        # AI coding agent desktop client
        "opencode-desktop"
        # WebKit based web browser
        "orion"
        # Client for Proton Drive
        "proton-drive"
        # Client for Proton Mail and Proton Calendar
        "proton-mail"
        # Bridge for Proton Mail
        "proton-mail-bridge"
        # Desktop client for Proton Pass
        "proton-pass"
        # VPN client focusing on security
        "protonvpn"
        # HTTP debugging proxy
        "proxyman"
        # Control your tools with a few keystrokes
        "raycast"
        # Open source virtual/remote desktop application
        "rustdesk"
        # Instant messaging application focusing on security
        "signal"
        # Network toolbox
        "surge"
        # Real time file synchronisation software
        "syncthing-app"
        # Mesh VPN based on WireGuard
        "tailscale-app"
        # Customizable email client
        "thunderbird"
        # Web browser focusing on security
        "tor-browser"
        # Open-source BitTorrent client
        "transmission"
        # Virtual machines UI using QEMU
        "utm"
        # Menu bar toolkit with keep-awake, clipboard manager, and more
        "vorssaint"
        # Wine wrapper built with SwiftUI
        "whisky"
        # Network protocol analyzer
        "wireshark-app"
        # Multiplayer code editor
        "zed"
        # Gecko based web browser
        "zen"
        # Tiling window manager
        "nikitabobko/tap/aerospace"
      ];
    };
  };
}
