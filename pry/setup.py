from mjr import etc

print("Setting up Pry...")

etc.init()

pryrc_src = etc.script_dir() / 'pryrc'
pryrc_dest = etc.home() / '.pryrc'

print("Linking {} to {}...".format(pryrc_src, pryrc_dest))
etc.update_symlink(pryrc_src, pryrc_dest)

print("Pry setup complete.")
