from dotenv import load_dotenv
import pystache
import os
from pathlib import Path
import sys

def init():
    load_dotenv()

def documents():
    if not is_windows():
        raise Exception("Documents directory only supported on Windows")

    import ctypes
    from ctypes.wintypes import MAX_PATH

    dll = ctypes.windll.shell32
    buf = ctypes.create_unicode_buffer(MAX_PATH + 1)
    if dll.SHGetSpecialFolderPathW(None, buf, 0x0005, False):
        return Path(buf.value)
    else:
        raise Exception("Failed to find documents directory")

def home():
    return Path.home()

def src():
    var = os.getenv('ETC_SRC')
    if (var is None):
        return home() / 'src'
    else:
        return Path(var)

def script_dir():
    return Path(os.path.dirname(os.path.realpath(sys.argv[0])))

def is_windows():
    return sys.platform.startswith('win32')

def is_mac():
    return sys.platform.startswith('darwin')

def is_linux():
    return sys.platform.startswith('linux')

def platform():
    if is_windows():
        return 'windows'
    elif is_linux():
        return 'linux'
    elif is_mac():
        return 'mac'
    else:
        return 'other'

def is_work():
    var = os.getenv('ETC_WORK')
    return (var is not None and var.lower() == 'true')

def is_codespace():
    var = os.getenv('CODESPACES"')
    return (var is not None and var.lower() == 'true')

def symlink_dotfile(filename):
    src = script_dir() / filename
    dest = home() / ('.' + filename)
    update_symlink(src, dest)

def update_symlink(src, dest):
    if os.path.exists(dest):
        os.remove(dest)
    os.symlink(src, dest)

def template_context(kvs):
    ctx = {
        'home': str(home()),
        'src': str(src()),
        'script_dir': str(script_dir()),
        'is_work': is_work(),
        'platform': platform(),
        'is_windows': is_windows(),
        'is_mac': is_mac(),
        'is_linux': is_linux(),
        'separator': os.path.sep
    }
    ctx.update(kvs)
    return ctx

def read_template(template_filename):
    filepath = os.path.join(script_dir(), template_filename)
    with open(filepath, 'r') as f:
        return f.read()

def write_output(directory, filename, value):
    if (not os.path.isdir(directory)):
        os.makedirs(directory)
    output = os.path.join(directory, filename)
    with open(output, 'w') as f:
        f.write(value)

MUSTACHE_TEMPLATE_EXTENSION = ".mustache"

def render_mustache(template_filename, result_dir, result_filename=None, **kwargs):
    if (not template_filename.endswith(MUSTACHE_TEMPLATE_EXTENSION)):
        raise ValueError("Expected a filename ending in {}".format(MUSTACHE_TEMPLATE_EXTENSION))
    template = read_template(template_filename)
    ctx = template_context(kwargs)
    result = pystache.render(template, ctx)
    if (result_filename is None):
        result_filename = template_filename.replace(MUSTACHE_TEMPLATE_EXTENSION, '')
    write_output(result_dir, result_filename, result)
