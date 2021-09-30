from mjr import etc
import os
import shutil

print("Setting up Windows Terminal...")

etc.init()

settings_file = 'settings.json'
settings_src = etc.script_dir() / settings_file
settings_dest = etc.home() / 'AppData' / 'Local' / 'Packages' / 'Microsoft.WindowsTerminal_8wekyb3d8bbwe' / 'LocalState' / settings_file

print("Copying {} to {}...".format(settings_src, settings_dest))
etc.update_symlink(settings_src, settings_dest)

print("Windows Terminal setup complete.")
