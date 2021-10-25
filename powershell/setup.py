from mjr import etc
import os
import subprocess

print("Setting up PowerShell...")

etc.init()

src_dir = etc.src()
if (not src_dir.exists()):
    os.makedirs(src_dir)

subprocess.run(["pwsh", "-Command", "\"Install-Module posh-git\""])

def render_profile(directory, name="Profile.ps1"):
    print("Rendering {} to {}...".format(name, directory))
    etc.render_mustache("profile.mustache", directory, name)

if etc.is_windows():
    render_profile(etc.documents() / "WindowsPowerShell")
    render_profile(etc.documents() / "PowerShell")
else:
    render_profile(etc.home() / ".config" / "powershell", "profile.ps1")

print("Done")
