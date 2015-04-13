from shutil import *
from os import *
from os.path import expanduser

pj = path.join
rel = lambda *x: pj(path.abspath(path.dirname(__file__)), *x)

def gohome(fn, extra=""):
    fdest = extra + fn
    src = rel(fn)
    dest = expanduser(pj("~", fdest))
    print "symlink", src, dest
    try:
        symlink(src, dest)
    except OSError:
        pass


for f in []:
    gohome(f)

for f in [
    "nvimrc",
    "xinitrc",
    "Xresources",
    "zshrc",
    "gitignore",
    "gitconfig",
    "xmodmap"
]:
    gohome(f, ".")

fontsd = expanduser("~/.fonts/")
try:
    mkdir(fontsd)
except OSError:
    pass
gohome(listdir(fontsd)[0], fontsd)


def setup_neovim():
    gohome("nvim", ".")
