from mjr import etc

etc.init()

print("Setting up Ruby...")

etc.symlink_dotfile('irbrc')
etc.symlink_dotfile('pryrc')

print("Ruby setup complete.")
