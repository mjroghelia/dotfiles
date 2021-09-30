from mjr import etc
import os
import shutil

print("Setting up PowerToys...")

etc.init()

if (etc.is_windows()):
    conf_dir = etc.home() / 'AppData' / 'Local' / 'Microsoft' / 'PowerToys' / 'Keyboard Manager'
else:
    raise Exception("Unsupported platform: {}".format(etc.platform()))

if (not os.path.isdir(conf_dir)):
    os.makedirs(conf_dir)

settings_file = 'keyboard-manager-default.json'
settings_src = etc.script_dir() / settings_file
settings_dest = conf_dir / 'default.json'
print("Linking {} to {}...".format(settings_src, settings_dest))
etc.update_symlink(settings_src, settings_dest)

print("PowerToys setup complete.")
