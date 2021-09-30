from mjr import etc
import os
import shutil

print("Setting up VS Code...")

etc.init()

if (etc.is_windows()):
    conf_dir = etc.home() / 'AppData' / 'Roaming' / 'Code' / 'User'
elif (etc.is_mac()):
    conf_dir = etc.home() / 'Library' / 'Application Support' / 'Code' / 'User'
elif (etc.is_linux()):
    conf_dir = etc.home() / '.config' / 'Code' / 'User'
else:
    raise Exception("Unsupported platform: {}".format(etc.platform()))

if (not os.path.isdir(conf_dir)):
    os.makedirs(conf_dir)

# settings.json

settings_file = 'settings.json'
settings_src = etc.script_dir() / settings_file
settings_dest = conf_dir / settings_file
print("Linking {} to {}...".format(settings_src, settings_dest))
etc.update_symlink(settings_src, settings_dest)

# keybindings.json

keybindings_file = 'keybindings.json'
keybindings_src = etc.script_dir() / keybindings_file
keybindings_dest = conf_dir / keybindings_file
print("Linking {} to {}...".format(keybindings_src, keybindings_dest))
etc.update_symlink(keybindings_src, keybindings_dest)

# Repeating keys

if (etc.is_mac()):
    print("Enabling repeating keys...")
    os.system('defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false')
    os.system('defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false')

print("VS Code setup complete.")
