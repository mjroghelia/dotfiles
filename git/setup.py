from mjr import etc
import os
import shutil

print("Setting up Git...")

etc.init()

is_wsl = (os.getenv('WSL_INTEROP') != None)

print("Rendering .gitconfig to {}...".format(etc.home()))
gitignore = etc.script_dir() / "ignore"
etc.render_mustache("config.mustache", etc.home(), ".gitconfig", gitignore=gitignore.as_posix(), is_wsl=is_wsl)

print("Git setup complete.")
