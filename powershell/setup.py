from mjr import etc
import os
import subprocess

print("Setting up PowerShell...")

etc.init()

src_dir = etc.src()
if (not src_dir.exists()):
    os.makedirs(src_dir)

poshgit_dir = src_dir / 'posh-git'
poshgit_file = poshgit_dir / "src" / "posh-git.psd1"

if (not poshgit_dir.exists()):
    print("Cloning posh-git...")
    subprocess.run(["git", "clone", "https://github.com/dahlbyk/posh-git.git", str(poshgit_dir)])
else:
    print("posh-git already cloned.")

def render_profile(directory, name="Profile.ps1"):
    print("Rendering {} to {}...".format(name, directory))
    etc.render_mustache("profile.mustache", directory, name)

if etc.is_windows():
    render_profile(etc.documents() / "WindowsPowerShell")
    render_profile(etc.documents() / "PowerShell")
else:
    render_profile(etc.home() / ".config" / "powershell", "profile.ps1")

print("Done")
