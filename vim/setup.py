from mjr import etc
import os
import shutil

def link(filename):
    src = etc.script_dir() / filename
    if (etc.is_windows()):
        dest = etc.home() / ("_" + filename)
    else:
        dest = etc.home() / ("." + filename)
    print("Linking {} to {}...".format(src, dest))
    etc.update_symlink(src, dest)

print("Setting up vim...")

link("vimrc")
link("gvimrc")

if (etc.is_windows()):
    link("vsvimrc")

print("vim setup complete.")
