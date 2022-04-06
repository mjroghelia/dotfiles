from mjr import etc
import shutil

print("Setting up Bash...")

etc.init()

env_file = etc.home() / '.env'

if (not env_file.exists()):
    print("Creating .env file...")
    with open(env_file, 'w') as f:
        f.write('ETC_SRC={}\n'.format(etc.src()))
        f.write('ETC_DIR={}\n'.format(etc.script_dir().parent))
        f.write('ETC_PLATFORM={}\n'.format(etc.platform()))
        f.write('ETC_WORK={}\n'.format(str(etc.is_work()).lower()))

if (etc.is_codespace() and etc.is_work()):

elif (not etc.is_windows()):
    alias_src = etc.script_dir() / "aliases"
    print("Linking .bash_aliases to {}...".format(alias_src))
    etc.update_symlink(alias_src, etc.home() / ".bash_aliases")

    profile_src = etc.script_dir() / "profile.bash"
    print("Linking .bash_profile to {}...".format(profile_src))
    etc.update_symlink(profile_src, etc.home() / ".bash_profile")

print("Bash setup complete.")
