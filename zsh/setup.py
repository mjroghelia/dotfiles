from mjr import etc
import shutil

print("Setting up zsh...")

etc.init()

env_file = etc.home() / '.env'

if (not env_file.exists()):
    print("Creating .env file...")
    with open(env_file, 'w') as f:
        f.write('ETC_SRC={}\n'.format(etc.src()))
        f.write('ETC_DIR={}\n'.format(etc.script_dir().parent))
        f.write('ETC_PLATFORM={}\n'.format(etc.platform()))
        f.write('ETC_WORK={}\n'.format(str(etc.is_work()).lower()))

rc_src = etc.script_dir() / "zshrc"
print("Linking .zshrc to {}...".format(rc_src))
etc.update_symlink(rc_src, etc.home() / ".zshrc")

print("zsh setup complete.")
